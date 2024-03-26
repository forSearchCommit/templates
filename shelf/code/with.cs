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
    public class AnShengPay : IDPNotificationHandler, IBankingDepositWithdrawal
    {
        #region Declaration

        private static readonly ILog PaymentLogger = LogManager.GetLogger("Payment");

        private const PaymentEnum.PaymentProvider _provider = PaymentEnum.PaymentProvider.AnShengPay;
        public static AnShengPay Instance { get; } = new AnShengPay();
        private static ELKLogger ELKLog { get; } = new ELKLogger(_provider.ToString());
        public string FormSubmitMethod => HttpMethod.Post.ToString();
        public string NotifyMethod => HttpMethod.Post.ToString();
        public string WithdrawalNotifyMethod => HttpMethod.Post.ToString();

        #endregion Declaration

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
        
        public Dictionary<string, string> ParseNotifyBackEnd(out string transactionId, out PaymentEnum.PaymentDepositStatus status, out string referenceNumber, out decimal amount, out string remark)
        {
            throw new NotImplementedException();
        }

        public bool VerifyNotifyRequest(Dictionary<string, string> paramsNotify, PaymentTypeGatewaySettingEntity gateway)
        {
            throw new NotImplementedException();
        }

        #endregion NotImplemented

        #region Process
        //Submit Process
        public PaymentEnum.PaymentWithdrawalStatus SendWithdrawalRequest(PaymentWithdrawalNLBTDetailVo entity, out string requestID, out string message)
        { 
            //initiation
            string url = "";
            bool isSucessStatusCode = true;
            HttpStatusCode responseStatusCode = HttpStatusCode.OK;
            Dictionary<string, string> requestDataDict = null;
            PaymentTypeGatewaySettingEntity gateway = new PaymentTypeGatewaySettingEntity();

            //get required parameters
            gateway = PaymentSettingManager.Instance.GetPaymentTypeGatewaySettingDetails((int)entity.paymentType, entity.PaymentOptionID); //get gateway setting
            Dictionary<string, string> secureKeyDic = gateway.secureKeyList.ToDictionary(x => x.KeyName, x => x.KeyValue); // get secure key

            var withdrawalEntity = PaymentWithdrawalManager.Instance.GetPaymentById(entity.AccountID, entity.TransactionNo);// no bank info
            
            MemberEntity member = MemberManager.Instance.GetMemberByLoginName(entity.LoginName, 2); //columns available balance, memberid, accountid
            
            PaymentProviderBankCodeEntity providerBankCode = PaymentSettingManager.Instance.GetPaymentProviderBankCodeByBankID((int)_provider, withdrawalEntity.bankId); //get provider bank code
            
            ELKLog.LogAction(() =>
            {
                url = gateway.ProviderDepositURL;
                var currentCulture = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-GB");

                var requestData = new AnShengPayWithdrawalSubmissionRequest(
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
                    //withdrawalEntity.ipAddress, //userIp optional for ansheng
                    gateway.secureKey //sign
                    ); ;
                
                //dictionary conversion
                requestDataDict = requestData.AsDictionary();

                //signing
                string signature = requestDataDict[nameof(AnShengPayWithdrawalSubmissionRequest.sign)] = AnShengPayHelper.SignatureGeneration(requestDataDict, secureKeyDic, AnShengPayActionType.WithdrawalRequest);

                System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(entity.TransactionNo);
                _log.SetValue(Actions: nameof(SendWithdrawalRequest) + "-Request", _params: requestDataDict);
            });

            try
            {
                AnShengPayWithdrawalSubmissionResponse returnResult = null;
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

        private AnShengPayWithdrawalSubmissionResponse ConvertWithdrawalResponse(string json)
        {
            AnShengPayWithdrawalSubmissionResponse returnData = new AnShengPayWithdrawalSubmissionResponse();
            FileLogger.Instance.Info($"[{_provider} Withdrawal Response - ] [{json}]");
            try
            {
                returnData = JsonConvert.DeserializeObject<AnShengPayWithdrawalSubmissionResponse>(json);
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
            AnShengPayWithdrawalNotifyModel data = null;
            PaymentWithdrawalEntity paymentEntity = new PaymentWithdrawalEntity();
            status = PaymentEnum.PaymentWithdrawalStatus.Successful;
            string transactionNo = string.Empty;
            bool verifyResult = false;
            string json = string.Empty;

            ELKLog.LogAction(() =>
            {
                //notify request deserialization
                var bodyStream = new StreamReader(HttpContext.Current.Request.InputStream);
                bodyStream.BaseStream.Seek(0, SeekOrigin.Begin);
                json = bodyStream.ReadToEnd();
                data = ConvertWithdrawalNotify(json);

                PaymentLogger.Info($"[{_provider} Withdrawal] WD Notify => Content: {data}");
                FileLogger.Instance.Info($"[{_provider} Withdrawal Notify3 - ] [{data.paidAmount.ToString()}]");

                transactionNo = data.merchantOrderId;
                paymentEntity = PaymentWithdrawalManager.Instance.GetPaymentByPayoutId(0, transactionNo);
                var gatewaySetting = PaymentSettingManager.Instance.GetPaymentTypeGatewaySettingDetails((int)paymentEntity.paymentType, paymentEntity.paymentOptionID);
                dic = data.AsDictionary(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance,
                    translator: AnShengPayHelper.Stringify, Query: (prop) => { return prop; });
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
            string actualSign = paramDict[nameof(AnShengPayWithdrawalNotifyModel.sign)];
            paramDict.Remove(nameof(AnShengPayWithdrawalNotifyModel.sign));
            Dictionary<string, string> secureKeyDic = gateway.secureKeyList.ToDictionary(x => x.KeyName, x => x.KeyValue);

            ELKLog.LogAction(() =>
            {
                orderNo = paramDict[nameof(AnShengPayWithdrawalNotifyModel.payOrderId)];
                string signature = AnShengPayHelper.SignatureGeneration(paramDict, secureKeyDic, AnShengPayActionType.WithdrawalNotify);
                verified = actualSign.Equals(signature);

            }, OnAfterExecution: _log =>
            {
                _log.setLogIdentity(orderNo);
            });

            return verified;
        }

        public AnShengPayWithdrawalNotifyModel ConvertWithdrawalNotify(string jsonString)
        {
            AnShengPayWithdrawalNotifyModel returnData = new AnShengPayWithdrawalNotifyModel();
            FileLogger.Instance.Info($"[{_provider} Withdrawal Notify - ] [{jsonString}]");

            try
            {
                Dictionary<string, string> keyValueDict = new Dictionary<string, string>();
                returnData = JsonConvert.DeserializeObject<AnShengPayWithdrawalNotifyModel>(jsonString);
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
    }

    #region Enum
    internal enum AnShengPaySecureKey
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

    internal enum AnShengPayActionType
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
    //{
    //  "merchantId": 50000,
    //  "merchantOrderId": "23542sdf55252s5w14w",
    //  "payType": 1060,
    //  "payAmount": 100.00,
    //  "bankType": "CMB",
    //  "bankNum": "36954697135656",
    //  "bankAccount": "liudehua",
    //  "bankAddress": "广东省上海市南召县",
    //  "notifyUrl": "http://ptdene.jm/xrdsms",
    //  "userId": "78",
    //  "userIp": "212.139.172.110",
    //  "sign": "d4we5322812e693412"
    //}
    internal class AnShengPayWithdrawalSubmissionRequest
    {
        internal string merchantId { get; set; }
        internal string merchantOrderId { get; set; }
        internal string payType { get; set; }
        internal string payAmount { get; set; }
        internal string bankType { get; set; }
        internal string bankNum { get; set; }
        internal string bankAccount { get; set; }
        internal string bankAddress { get; set; }
        internal string notifyUrl { get; set; }
        internal string userId { get; set; }
        //internal string? userIp { get; set; } optional field
        internal string sign { get; set; }

        private Dictionary<string, string> _dict = new Dictionary<string, string>();
        internal AnShengPayWithdrawalSubmissionRequest(
            string strMerchantId,
            string strMerchantOrderId,
            string strPayType,
            string strPayAmount,
            string strBankType,
            string strBankNum,
            string strBankAccount,
            string strBankAddress,
            string strNotifyUrl,
            string strUserId,
            //string strUserIp, optional field
            string strSign)
        {
            merchantId = strMerchantId;
            merchantOrderId = strMerchantOrderId;
            payType = strPayType;
            payAmount = strPayAmount;
            bankType = strBankType;
            bankNum = strBankNum;
            bankAccount = strBankAccount;
            bankAddress = strBankAddress;
            notifyUrl = strNotifyUrl;
            userId = strUserId;
            //userIp = strUserIp; optional field
            sign = strSign;
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

            return this.AsDictionary(reflectionBindingFlag, PropertyQuery, AnShengPayHelper.Stringify);
        }

        internal Dictionary<string, string> AsDictionary()
        {
            return _dict;
        }
    }

    //Response Models - Withdrawal Submission : 
    //{
    //  "status": 1,
    //  "msg": "提款下单成功",
    //  "data": {
    //    "merchantId": 50000,
    //    "merchantOrderId": "5565e5w6e5rw6er56w",
    //    "payOrderId": "52w653654634",
    //    "orderStatus": 0,
    //    "payAmount": 200.00,
    //    "sign": "d4k5k4l6l4645"
    //  }
    //}

    internal class AnShengPayWithdrawalSubmissionResponse
    {
        public string status { get; set; }
        public string msg { get; set; }
        public AnShengWithdrawalSubmissionResponseData data { get; set; }
    }

    internal class AnShengWithdrawalSubmissionResponseData
    {
        public string merchantId { get; set; }
        public string merchantOrderId { get; set; }

        public string payOrderId { get; set; }

        public string orderStatus { get; set; }

        public string payAmount { get; set; }

        public string sign { get; set; }
    }

    //Acknowledgement/Callback Models : 
    //{
    //  "merchantId": 500000,
    //  "merchantOrderId": "2aBb5d87DbC14C45DfDC466F",
    //  "payOrderId": "XP50000022032301162711220500",
    //  "payAmount": 100,
    //  "orderStatus": 3,
    //  "createTime": "2022-10-10 09:10:20",
    //  "sign": "D3K4L5K6L6L7J6L7676ML4565"
    //}

    public class AnShengPayWithdrawalNotifyModel
    {
        public string merchantId { get; set; }
        public string merchantOrderId { get; set; }
        public string payOrderId { get; set; }
        public decimal payAmount { get; set; }
        public decimal? paidAmount { get; set; }
        public string orderStatus { get; set; }
        public string createTime { get; set; }
        public string sign { get; set; }
    }

    #endregion Models

    #region Helper
    internal static class AnShengPayHelper
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
            AnShengPayActionType actionType)
        {
            string message = string.Empty;
            string signature = string.Empty;

            switch (actionType)
            {
                case AnShengPayActionType.DepositRequest:
                case AnShengPayActionType.WithdrawalRequest:
                    {
                        message = HashMessage(requestDataDict, dictKeys, true, false) ;
                        signature = AppCryptoHelper.GetMd5Hash(message).ToLower();
                        break;
                    }
                case AnShengPayActionType.DepositNotify:
                case AnShengPayActionType.WithdrawalNotify:
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
                        if (!String.IsNullOrEmpty(value.Value)&&value.Value != "0.00")
                        {
                            message += $"{value.Key}={value.Value}&";
                            FileLogger.Instance.Info($"[Message 2- {message}]");
                        }
                    }
                }
                i++;
            }

            message += dictKeys.ContainsKey(AnShengPaySecureKey.Key.ToString())
                ? $"{ AnShengPaySecureKey.Key.ToString().ToLower()}={dictKeys[AnShengPaySecureKey.Key.ToString()]}"
                : string.Empty;
            
            return message;
        }
    }
    #endregion Helper
}
