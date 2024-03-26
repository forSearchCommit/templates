using GCT.Common.Logger;
using GCT.Common.Utilities;
using GCT.Entities.Entities;
using GCT.Entities.Enum;
using GCT.Entities.VO;
using GCT.Manager.Integration.Configuration;
using GCT.Manager.MemberManagement.Manager;
using GCT.Manager.PaymentManagement.Manager;
using GCT.Manager.PaymentManagement.Utilities;
using log4net;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;

namespace GCT.Manager.PaymentManagement.Vendor
{
    public class xxPay : IDPNotificationHandler, IBankingDepositWithdrawal, IDPResponseHandler, IDPSubmitThenHandle
    {
        #region Declaration

        private static readonly ILog PaymentLogger = LogManager.GetLogger("Payment");

        private const PaymentEnum.PaymentProvider _provider = PaymentEnum.PaymentProvider.xxPay;
        public static xxPay Instance { get; } = new xxPay();
        private static ELKLogger ELKLog { get; } = new ELKLogger(_provider.ToString());
        public string FormSubmitMethod => HttpMethod.Post.ToString();
        public string NotifyMethod => HttpMethod.Post.ToString();
        public string WithdrawalNotifyMethod => HttpMethod.Post.ToString();

        #endregion Declaration

        #region DepositProcess

        //Deposit
        RequestEntity IDPSubmitThenHandle.CreateRequest(PaymentDepositEntity entity, PaymentTypeGatewaySettingEntity gateway)
        {
            var submitEntity = new RequestEntity()
            {
                FormMethod = HttpMethod.Post,
                ContentType = "application/x-www-form-urlencoded",
                IsUseProxy = AppConfiguration.Instance.casinoConfig.PaymentGatewayIsUseProxy
            };

            if (submitEntity.FormHeaders == null)
            {
                submitEntity.FormHeaders = new Dictionary<string, string>();
            }

            submitEntity.FormHeaders.Add("Accept", "application/json");
            submitEntity.UsingSSLProtocol = true;
            Dictionary<string, string> result = null;

            try
            {
                ELKLog.LogAction(() =>
                {
                    result = CreateRequest(entity, gateway);
                    submitEntity.FormContent = new FormUrlEncodedContent(result);
                    submitEntity.Url = gateway.ProviderDepositURL;
                }, OnAfterExecution: _log =>
                {
                    _log.setLogIdentity(entity.transactionNo);
                    _log.SetValue(Actions: nameof(IDPSubmitThenHandle.CreateRequest), _params: result);
                });
                FileLogger.Instance.Info($"[Request - {_provider}] [{JsonConvert.SerializeObject(submitEntity)}]");

            }
            catch (Exception ex)
            {
                PaymentLogger.Error(ex);
                throw;
            }

            return submitEntity;
        }

        private Dictionary<string, string> CreateRequest(PaymentDepositEntity entity, PaymentTypeGatewaySettingEntity gateway)
        {
            Dictionary<string, string> resultRequestData = null;
            var details = PaymentDepositManager.Instance.DepositGateway().GetGateway(entity.paymentType).GetPaymentTransactionDetail(entity.transactionNo);
            decimal amount = gateway.IsActiveAmountBuffer ? PaymentDepositManager.Instance.GenerateDepositAssignAmount(entity.transactionNo, entity.paymentType, (PaymentEnum.PaymentOption)entity.paymentOptionID, entity.grossAmount) : entity.grossAmount;
            var memberEntity = MemberManager.Instance.GetMemberById(entity.memberID);
            var secureKeyDic = gateway.secureKeyList.ToDictionary(x => x.KeyName, x => x.KeyValue);

            var RequestData = new FTPayDepositSubmissionRequest(
                    gateway.merchantID,     //userid
                    entity.transactionNo,   //orderno
                    "N8 Deposit",           //desc
                    amount.ToString("F"),   //amount
                    gateway.proxyNotifyURL, //notifyurl
                    gateway.proxyRedirectURL, //backurl
                    "onlinekj",             //paytype
                                            //string.Empty,           //bankstyle
                    memberEntity.givenName, //acname
                                            //string.Empty,           //notifystyle
                    "CNY",                  //attach
                    details.IpAddress,       //userip
                                             //string.Empty,           //bankname
                    "CNY",                  //currency
                    string.Empty            //sign
                );

            resultRequestData = RequestData.AsDictionary();

            resultRequestData[nameof(FTPayDepositSubmissionRequest.sign)] = FTPayHelper.SignatureGeneration(resultRequestData, secureKeyDic, FTPayActionType.DepositRequest);

            FileLogger.Instance.Info($"[{_provider} Deposit Request] [{JsonConvert.SerializeObject(resultRequestData)}]");

            return resultRequestData;
        }

        //Deposit Response

        DPSubmitRespHandleResult IDPSubmitThenHandle.ResponseHandle(HttpResponseMessage response, PaymentDepositEntity entity, PaymentTypeGatewaySettingEntity gateway)
        {
            FTPayDepositSubmissionResponse res = null;
            Dictionary<string, string> dic = null;
            string redirectUrl = string.Empty;

            ELKLog.LogAction(() =>
            {
                var json = response.Content.ReadAsStringAsync().Result;
                res = ConvertDepositResponse(json);
                dic = res.AsDictionary(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance,
                                                                    translator: FTPayHelper.Stringify,
                                                                    Query: (prop) => { return prop.OrderBy(x => x.Name); });

                if (res.status == "1")
                {
                    redirectUrl = res.payurl;
                };

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(entity.transactionNo);
                _log.SetValue(nameof(IDPSubmitThenHandle.ResponseHandle), _params: dic);
            });

            return new DPSubmitRespHandleResult { Action = FurtherAction.Redirect, Result = redirectUrl ?? string.Empty, UsePost = false };
        }


        //Notify

        public Dictionary<string, string> ParseNotifyBackEnd(out string transactionId, out PaymentEnum.PaymentDepositStatus status, out string referenceNumber, out decimal amount, out string remark)
        {
            Dictionary<string, string> resDict = null;
            FTPayDepositNotifyModel data = null;
            string json = string.Empty;

            ELKLog.LogAction(() =>
            {
                var formText = HttpContext.Current.Request.Form;
                data = ConvertDepositNotify(formText);
                resDict = data.AsDictionary(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public,
                    translator: FTPayHelper.Stringify, Query: (prop) => { return prop; });

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(data.orderno);
                _log.SetValue(Actions: nameof(ParseNotifyBackEnd), _params: resDict);
            });

            transactionId = data.orderno;
            referenceNumber = data.outorder;
            amount = Convert.ToDecimal(data.amount);

            var depositEntity = PaymentDepositManager.Instance.GetPaymentById(0, transactionId);

            if (data.status.Equals("1", StringComparison.InvariantCultureIgnoreCase))
            {
                status = PaymentEnum.PaymentDepositStatus.Successful;
                remark = $"Request [{transactionId}] Payment Deposit State : Success, " +
                    $"Message : {FTPayHelper.StatusCode[data.status]}";
            }
            else
            {
                status = PaymentEnum.PaymentDepositStatus.Failed;
                remark = $"Request [{transactionId}] Payment Deposit State : Fail" +
                    (FTPayHelper.StatusCode.ContainsKey(data.status)
                    ? $", Message : {FTPayHelper.StatusCode[data.status]}"
                    : $", Provider Status Code : {data.status}");
            }

            return resDict;
        }

        public bool VerifyNotifyRequest(Dictionary<string, string> paramsNotify, PaymentTypeGatewaySettingEntity gateway)
        {
            bool verified = false;
            string orderNo = string.Empty;
            string actualSign = paramsNotify[nameof(FTPayDepositNotifyModel.sign)];
            var secureKeyDic = gateway.secureKeyList.ToDictionary(x => x.KeyName, x => x.KeyValue);

            ELKLog.LogAction(() =>
            {
                orderNo = paramsNotify[nameof(FTPayDepositNotifyModel.orderno)];

                string expectedSign = FTPayHelper.SignatureGeneration(paramsNotify, secureKeyDic, FTPayActionType.DepositNotify);

                verified = actualSign.Equals(expectedSign);

                if (!verified)
                    PaymentLogger.Info($"[{_provider} Deposit Notify] Sign Code not match => expected:{ paramsNotify[nameof(FTPayDepositNotifyModel.sign)] } ; actualSign:{ actualSign }");


            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(orderNo);
                _log.SetValue(Actions: nameof(VerifyNotifyRequest), _params: paramsNotify);
            });

            return verified;
        }
        #endregion

        #region WithdrawalProcess
        //Submit Process
        public PaymentEnum.PaymentWithdrawalStatus SendWithdrawalRequest(PaymentWithdrawalNLBTDetailVo entity, out string requestID, out string message)
        {
            //initiation
            string url = "";
            bool isSucessStatusCode = true;
            HttpStatusCode responseStatusCode = HttpStatusCode.OK;
            Dictionary<string, string> requestDataDict = null;
            PaymentTypeGatewaySettingEntity gateway = new PaymentTypeGatewaySettingEntity();

            /*
            Getting Required Parameters  :
            GetPaymentTypeGatewaySettingDetails - gatway setting and secure key
                1. merchantID
                2. ProviderDepositURL
                3. secureKeyList
            GetPaymentById - withdrawal entity
                1. payoutTransactionNo
                2. grossAmount.ToString("F")
                3. memberID.ToString()
            GetMemberByLoginName - member entity
                1. 
                2. 
                3. 








*/
            gateway = PaymentSettingManager
                .Instance
                .GetPaymentTypeGatewaySettingDetails((int)entity.paymentType, entity.PaymentOptionID); //get gateway setting

            Dictionary<string, string> secureKeyDic = gateway
                .secureKeyList
                .ToDictionary(x => x.KeyName, x => x.KeyValue); // get secure key

            var withdrawalEntity = PaymentWithdrawalManager
                .Instance
                .GetPaymentById(entity.AccountID, entity.TransactionNo);// no bank info

            MemberEntity member = MemberManager
                .Instance
                .GetMemberByLoginName(entity.LoginName, 2); //columns available balance, memberid, accountid

            PaymentProviderBankCodeEntity providerBankCode = PaymentSettingManager.Instance.GetPaymentProviderBankCodeByBankID((int)_provider, withdrawalEntity.bankId); //get provider bank code

            ELKLog.LogAction(() =>
            {
                url = gateway.ProviderDepositURL;
                var currentCulture = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-GB");

                var requestData = new xxPayWithdrawalSubmissionRequest(
                    gateway.merchantID, //merchantId
                    withdrawalEntity.payoutTransactionNo, //merchantOrderId
                    "1060", //payType
                    withdrawalEntity.grossAmount.ToString("F"), //payAmount
                    providerBankCode.Code, //bankType - bank code
                    entity.MemberAccountNo, //bankNum
                    entity.MemberAccountName, //bankAccount - account name
                    "Beijing", //bankAddress
                    gateway.proxyNotifyURL, //notifyUrl
                    withdrawalEntity.memberID.ToString(), //userId
                                                          //withdrawalEntity.ipAddress, //userIp optional for xx
                    gateway.secureKey //sign
                    ); ;

                //dictionary conversion
                requestDataDict = requestData.AsDictionary();

                //signing
                string signature = requestDataDict[nameof(xxPayWithdrawalSubmissionRequest.sign)] = xxPayHelper.SignatureGeneration(requestDataDict, secureKeyDic, xxPayActionType.WithdrawalRequest);

                System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(entity.TransactionNo);
                _log.SetValue(Actions: nameof(SendWithdrawalRequest) + "-Request", _params: requestDataDict);
            });

            try
            {
                xxPayWithdrawalSubmissionResponse returnResult = null;
                string jsonResult = string.Empty;

                ELKLog.LogAction(() =>
                {
                    //FileLogger.Instance.Info($"[{_provider} WEB INTEGRATION] Withdrawal request : {PaymentHelper.ConvertToKeyValueString(resultRequestData)}");
                    FileLogger.Instance.Info($"[{_provider} WEB INTEGRATION] Withdrawal URL: {url}");

                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;

                    //firewall configuration, comment out for local deployment
                    HttpClientHandler httpClientHandler = new HttpClientHandler
                    {
                        Proxy = new WebProxy(new Uri(AppConfiguration.Instance.casinoConfig.ProxyUrl)),
                        UseProxy = AppConfiguration.Instance.casinoConfig.PaymentGatewayIsUseProxy
                    };

                    using (var client = new HttpClient(httpClientHandler) { Timeout = TimeSpan.FromSeconds(30) })
                    {
                        var content = new StringContent(JsonConvert.SerializeObject(requestDataDict), Encoding.UTF8, "application/json");

                        if (content != null)
                            content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");

                        using (var response = client.PostAsync(new Uri(url), content).Result)
                        {
                            responseStatusCode = response.StatusCode;
                            if (!response.IsSuccessStatusCode)
                            {
                                FileLogger.Instance.Info($"[{_provider} WEB INTEGRATION] Withdrawal({entity.TransactionNo}) Request Fail Status Code : {response.StatusCode}");
                                isSucessStatusCode = false;
                            }

                            jsonResult = response.Content.ReadAsStringAsync().Result;
                            FileLogger.Instance.Info($"[{_provider} WEB INTEGRATION] Withdrawal response json : {jsonResult}");
                            returnResult = ConvertWithdrawalResponse(jsonResult);
                            FileLogger.Instance.Info($"[{_provider} WEB INTEGRATION] data response : status:{ (returnResult.status.Equals("1") ? "Success" : "Fail") }, transactionid:{ entity.TransactionNo }");
                        }
                    }
                }, OnAfterExecution: _log =>
                {
                    _log.setLogIdentity(entity.TransactionNo);
                    _log.SetValue(Actions: nameof(SendWithdrawalRequest) + "-Response", _params: jsonResult);
                });

                if (returnResult.status == "1")
                {
                    requestID = "";
                    message = $"Withdrawal submit success, status:success, ref_no: {entity.TransactionNo}, payout_no:{entity.PayoutTransactionNo}";
                    return PaymentEnum.PaymentWithdrawalStatus.SubmittedToGateway;
                }
                else
                {
                    requestID = "";
                    message = $"Withdrawal fail, status:fail, ref_no: {entity.TransactionNo}, payout_no:{entity.PayoutTransactionNo}, message: {returnResult.msg}";
                    return PaymentEnum.PaymentWithdrawalStatus.Failed;
                }

            }
            catch (Exception ex)
            {
                FileLogger.Instance.Info($"[{_provider} WEB INTEGRATION] Withdrawal({entity.TransactionNo}) submit exception: {ex.Message}; Full Exception:{ex}");
                requestID = "";
                message = isSucessStatusCode ? $"Withdrawal submit fail, error msg:{ex.Message}" : $"Withdrawal submit fail, Request TimeOut StatusCode : [{responseStatusCode}]";
                return PaymentEnum.PaymentWithdrawalStatus.ReadyToSubmit;
            }
        }

        private xxPayWithdrawalSubmissionResponse ConvertWithdrawalResponse(string json)
        {
            xxPayWithdrawalSubmissionResponse returnData = new xxPayWithdrawalSubmissionResponse();
            FileLogger.Instance.Info($"[{_provider} Withdrawal Response - ] [{json}]");
            try
            {
                returnData = JsonConvert.DeserializeObject<xxPayWithdrawalSubmissionResponse>(json);
            }
            catch (Exception ex)
            {
                FileLogger.Instance.Info($"[{_provider} Withdrawal Response ] [ERROR] [Failed To Deserialize - {json}]");
                FileLogger.Instance.Exception(ex);
            }

            return returnData;
        }

        //Notify

        public string ParseWithdrawalNotify(HttpContext context,
            out PaymentEnum.PaymentWithdrawalStatus status,
            out string gatewayRefId,
            out string successDateTime,
            out string message,
            out string returnMessage)
        {
            Dictionary<string, string> dic = null;
            xxPayWithdrawalNotifyModel data = null;
            PaymentWithdrawalEntity paymentEntity = new PaymentWithdrawalEntity();
            status = PaymentEnum.PaymentWithdrawalStatus.Successful;
            string transactionNo = string.Empty;
            bool verifyResult = false;
            string json = string.Empty;

            ELKLog.LogAction(() =>
            {
                /*Deserialization - Json*/
                var bodyStream = new StreamReader(HttpContext.Current.Request.InputStream);
                bodyStream.BaseStream.Seek(0, SeekOrigin.Begin);
                json = bodyStream.ReadToEnd();
                data = ConvertWithdrawalNotify(json);
                 

                PaymentLogger.Info($"[{_provider} Withdrawal] WD Notify => Content: {data}");
                FileLogger.Instance.Info($"[{_provider} Withdrawal Notify3 - ] [{data.paidAmount.ToString()}]");

                transactionNo = data.merchantOrderId;
                paymentEntity = PaymentWithdrawalManager.Instance.GetPaymentByPayoutId(0, transactionNo);
                var gatewaySetting = PaymentSettingManager.Instance.GetPaymentTypeGatewaySettingDetails((int)paymentEntity.paymentType, paymentEntity.paymentOptionID);


                dic = data.AsDictionary(System
                    .Reflection
                    .BindingFlags
                    .Public | 
                    System
                    .Reflection
                    .BindingFlags
                    .Instance,
                    translator: xxPayHelper.Stringify, Query: (prop) => { return prop; });
                verifyResult = VerifyNotifyWDRequest(dic, gatewaySetting);

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(paymentEntity.transactionNo);
                _log.SetValue(Actions: nameof(ParseWithdrawalNotify), _params: dic);
            });

            gatewayRefId = null;
            status = PaymentEnum.PaymentWithdrawalStatus.SubmittedToGateway;
            successDateTime = null;
            returnMessage = "fail";

            if (!verifyResult)
            {
                message = $"sign verify fail";
                return null;
            }

            gatewayRefId = null;
            successDateTime = DateTime.Now.ToString();
            returnMessage = string.Empty;
            var remark = $"transactionID:{data.payOrderId}";

            if (data.orderStatus.Equals("3"))
            {
                message = $"Notify success, remark => {remark}";
                status = PaymentEnum.PaymentWithdrawalStatus.Successful;
            }
            else
            {
                message = $"Notify fail, remark => {remark}";
                status = PaymentEnum.PaymentWithdrawalStatus.Failed;
            }

            return transactionNo;
        }

        public bool VerifyNotifyWDRequest(Dictionary<string, string> paramsNotify, PaymentTypeGatewaySettingEntity gateway) => VerifyWithdrawalNotify(paramsNotify, gateway);

        private bool VerifyWithdrawalNotify(Dictionary<string, string> paramDict, PaymentTypeGatewaySettingEntity gateway)
        {
            //signature verification
            bool verified = false;
            string orderNo = string.Empty;
            string actualSign = paramDict[nameof(xxPayWithdrawalNotifyModel.sign)];
            paramDict.Remove(nameof(xxPayWithdrawalNotifyModel.sign));
            Dictionary<string, string> secureKeyDic = gateway.secureKeyList.ToDictionary(x => x.KeyName, x => x.KeyValue);

            ELKLog.LogAction(() =>
            {
                orderNo = paramDict[nameof(xxPayWithdrawalNotifyModel.payOrderId)];
                string signature = xxPayHelper.SignatureGeneration(paramDict, secureKeyDic, xxPayActionType.WithdrawalNotify);
                verified = actualSign.Equals(signature);

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(orderNo);
            });

            return verified;
        }

        public xxPayWithdrawalNotifyModel ConvertWithdrawalNotify(string jsonString)
        {
            xxPayWithdrawalNotifyModel returnData = new xxPayWithdrawalNotifyModel();
            FileLogger.Instance.Info($"[{_provider} Withdrawal Notify - ] [{jsonString}]");

            try
            {
                Dictionary<string, string> keyValueDict = new Dictionary<string, string>();
                returnData = JsonConvert.DeserializeObject<xxPayWithdrawalNotifyModel>(jsonString);
            }
            catch (Exception ex)
            {
                FileLogger.Instance.Info($"[{_provider} Withdrawal Notify] [ERROR] [Failed To Deserialize - {returnData}]");
                FileLogger.Instance.Exception(ex);
            }
            return returnData;
        }
        #endregion Process

        #region Status Response Return
        public string CreateWDConfirmSuccess(PaymentTypeGatewaySettingEntity gateway, string referenceNo = "")
        {
            return "success";
        }

        public string CreateWDConfirmFail()
        {
            return "success";
        }



        public string CreateConfirmSuccess(Dictionary<string, string> resultDictionary, PaymentTypeGatewaySettingEntity gateway)
        {
            return "success";
        }

        public string CreateConfirmFail(Dictionary<string, string> resultDictionary)
        {
            return "success";
        }
        #endregion Status Response Return

        #region NotImplemented

        public Dictionary<string, string> ParseWithdrawalSubmit(out string transactionId, out string notifyUrl, out string returnUrl)
        {
            throw new NotImplementedException();
        }

        public bool VerifyWithdrawalSubmitRequest(Dictionary<string, string> paramsSubmit, PaymentTypeGatewaySettingEntity gateway)
        {
            throw new NotImplementedException();
        }

        public string CreateWithdrawalResponseString(Dictionary<string, string> submitDictionary, PaymentTypeGatewaySettingEntity gateway)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> CreateWithdrawalNotifyBackEnd(Dictionary<string, string> submitDictionary, PaymentTypeGatewaySettingEntity gateway)
        {
            throw new NotImplementedException();
        }

        public string ParseWithdrawalNotify(string xmlRequest, HttpContext context, out PaymentEnum.PaymentWithdrawalStatus status, out string gatewayRefId, out string successDateTime, out string message, out string returnMessage)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> ParseNotifyFrontEnd(out string transactionId)
        {
            throw new NotImplementedException();
        }

        #endregion NotImplemented
    }

    #region Enum
    internal enum xxPaySecureKey
    {
        Key
    }

    internal enum ASPWDMessageRequest
    {
        merchantId,
        merchantOrderId,
        payAmount
    }

    internal enum ASPWDNotifyRequest
    {
        merchantId,
        merchantOrderId,
        payOrderId,
        payAmount,
        paidAmount
    }

    internal enum xxPayActionType
    {
        DepositRequest,
        WithdrawalRequest,
        DepositResponse,
        WithdrawalResponse,
        DepositNotify,
        WithdrawalNotify
    }
    #endregion Enum

    #region Models

    //Request Models - Withrawal Submission
    internal class xxPayWithdrawalSubmissionRequest
    {
        private Dictionary<string, string> _dict = new Dictionary<string, string>();
        //follow properties in docs
        internal string a { get; set; }

        
        internal xxPayWithdrawalSubmissionRequest(
            string ab)
        {
            a = ab;
            _dict = GenerateDictionary();
        }

        private Dictionary<string, string> GenerateDictionary()
        {
            var reflectionBindingFlag = System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic;
            Func<System.Reflection.PropertyInfo[], IEnumerable<System.Reflection.PropertyInfo>> PropertyQuery = (props) =>
            {
                List<string> ignoredParams = new List<string> { nameof(_dict), nameof(sign) };
                var queryRules = props.Where(prop => !ignoredParams.Contains(prop.Name));
                var final = queryRules.OrderBy(prop => prop.Name);

                return final;
            };

            return this.AsDictionary(reflectionBindingFlag, PropertyQuery, xxPayHelper.Stringify);
        }

        internal Dictionary<string, string> AsDictionary()
        {
            return _dict;
        }
    }

    internal class xxPayWithdrawalSubmissionResponse
    {
        public string status { get; set; }
        public string msg { get; set; }
        public xxWithdrawalSubmissionResponseData data { get; set; }
    }

    internal class xxWithdrawalSubmissionResponseData
    {
        //follow properties in docs
        public string a { get; set; }
    }

    public class xxPayWithdrawalNotifyModel
    {
        //follow properties in docs
        public string a { get; set; }
    }

    #endregion Models

    #region Helper
    internal static class xxPayHelper
    {

        internal static string Stringify(object obj)
        {
            try
            {
                if (obj == null)
                    return string.Empty;
                if (obj is decimal)
                    return ((decimal)obj).ToString();
                if (obj is int?)
                    return ((int?)obj).HasValue ? obj.ToString() : string.Empty;
                return obj.ToString().Trim();
            }
            catch (Exception ex)
            {
                FileLogger.Instance.Exception(ex);
                throw;
            }
        }

        /// <summary>
        /// Signature Generations
        /// </summary>
        internal static string SignatureGeneration(Dictionary<string, string> requestDataDict,
            Dictionary<string, string> dictKeys,
            xxPayActionType actionType)
        {
            string message = string.Empty;
            string signature = string.Empty;

            switch (actionType)
            {
                case xxPayActionType.DepositRequest:
                case xxPayActionType.WithdrawalRequest:
                    {
                        message = HashMessage(requestDataDict, dictKeys, true, false);
                        signature = AppCryptoHelper.GetMd5Hash(message).ToLower();
                        break;
                    }
                case xxPayActionType.DepositNotify:
                case xxPayActionType.WithdrawalNotify:
                    {
                        message = HashMessage(requestDataDict, dictKeys, false, true);
                        signature = AppCryptoHelper.GetMd5Hash(message).ToLower();
                        break;
                    }
                default:
                    {
                        signature = AppCryptoHelper.GetMd5Hash(message).ToLower();
                        break;
                    }
            }

            return signature;
        }
        /// <summary>
        /// Hash Message Generations
        /// </summary>
        internal static string HashMessage(Dictionary<string, string> requestDataDict,
            Dictionary<string, string> dictKeys,
            bool ASPWDMessageRequest, bool ASPWDNotifyRequest)
        {
            string message = string.Empty;
            int i = 0;
            foreach (KeyValuePair<string, string> value in requestDataDict)
            {
                if (ASPWDMessageRequest)
                {
                    if (Enum.TryParse(value.Key, out ASPWDMessageRequest checkEnum))
                    {
                        message += $"{value.Key}={value.Value}&";
                    }
                }
                if (ASPWDNotifyRequest)
                {
                    if (Enum.TryParse(value.Key, out ASPWDNotifyRequest checkEnum))
                    {
                        FileLogger.Instance.Info($"[Message 1- {message}]");
                        if (!String.IsNullOrEmpty(value.Value) && value.Value != "0.00")
                        {
                            message += $"{value.Key}={value.Value}&";
                            FileLogger.Instance.Info($"[Message 2- {message}]");
                        }
                    }
                }
                i++;
            }

            message += dictKeys.ContainsKey(xxPaySecureKey.Key.ToString())
                ? $"{ xxPaySecureKey.Key.ToString().ToLower()}={dictKeys[xxPaySecureKey.Key.ToString()]}"
                : string.Empty;

            return message;
        }
    }
    #endregion Helper
}
