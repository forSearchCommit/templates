using GCT.Common.Logger;
using GCT.Common.Utilities;
using GCT.Entities.Entities;
using GCT.Entities.Enum;
using GCT.Manager.Integration.Configuration;
using GCT.Manager.MemberManagement.Manager;
using GCT.Manager.PaymentManagement.Entities;
using GCT.Manager.PaymentManagement.Manager;
using GCT.Manager.PaymentManagement.Utilities;
using log4net;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net.Http;
using System.Web;
namespace GCT.Manager.PaymentManagement.Vendor
{
    public class FTPay : IDPNotificationHandler, IDPResponseHandler, IDPSubmitThenHandle
    {
        #region Declaration

        private static readonly ILog PaymentLogger = LogManager.GetLogger("Payment");

        private const PaymentEnum.PaymentProvider _provider = PaymentEnum.PaymentProvider.FTPay;
        public static FTPay Instance { get; } = new FTPay();
        private static ELKLogger ELKLog { get; } = new ELKLogger(_provider.ToString());
        public string FormSubmitMethod => HttpMethod.Post.ToString();
        public string NotifyMethod => HttpMethod.Post.ToString();
        public string WithdrawalNotifyMethod => HttpMethod.Post.ToString();
        bool IDPSubmitThenHandle.IsNeedProxy => AppConfiguration.Instance.casinoConfig.PaymentGatewayIsUseProxy;
        #endregion Declaration

        #region NotImplemenmted
        public Dictionary<string, string> ParseNotifyFrontEnd(out string transactionId)
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Process

        //Deposit
        RequestEntity IDPSubmitThenHandle.CreateRequest(PaymentDepositEntity entity, PaymentTypeGatewaySettingEntity gateway)
        {
            var submitEntity = new RequestEntity() {
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
                    "211.24.62.57",       //userip
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


        #region Utility
        private FTPayDepositSubmissionResponse ConvertDepositResponse(string json)
        {
            FTPayDepositSubmissionResponse returnData = new FTPayDepositSubmissionResponse();
            PaymentLogger.Info($"[Response - {_provider}] [{json}]");

            try
            {
                returnData = JsonConvert.DeserializeObject<FTPayDepositSubmissionResponse>(json);
            }
            catch (Exception ex)
            {
                PaymentLogger.Error($"[Response - {_provider}] [ERROR] [Failed To Deserialize - {json}]");
                FileLogger.Instance.Exception(ex);
            }

            return returnData;
        }

        private FTPayDepositNotifyModel ConvertDepositNotify(NameValueCollection content)
        {
            FTPayDepositNotifyModel returnData = new FTPayDepositNotifyModel();
            FileLogger.Instance.Info($"[{_provider} Deposit Notify - ] [{content}]");

            try
            {
                var data = content.AllKeys.ToDictionary(k => k, v => content[v]);
                var jsonString = JsonConvert.SerializeObject(data);
                returnData = JsonConvert.DeserializeObject<FTPayDepositNotifyModel>(jsonString);
            }
            catch (Exception ex)
            {
                FileLogger.Instance.Info($"[{_provider} Deposit Notify] [ERROR] [Failed To Deserialize - {content}]");
                FileLogger.Instance.Exception(ex);
            }

            return returnData;

        }
        #endregion

        #region Helper
        internal static class FTPayHelper
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
                FTPayActionType actionType)
            {
                string message = string.Empty;
                string signature = string.Empty;

                switch (actionType)
                {
                    case FTPayActionType.DepositRequest:
                        {
                            message = HashMessage(requestDataDict, dictKeys, true, false);
                            signature = AppCryptoHelper.GetMd5Hash(message).ToLower();
                            break;
                        }

                    case FTPayActionType.DepositNotify:
                        {
                            message = HashMessage(requestDataDict, dictKeys, false, true);
                            signature = AppCryptoHelper.GetMd5Hash(message).ToLower();
                            break;
                        }
                    case FTPayActionType.DepositResponse:
                    case FTPayActionType.WithdrawalRequest:
                    case FTPayActionType.WithdrawalNotify:
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
                bool DPSubmitRequest, bool DPNotifyRequest)
            {
                string message = string.Empty;
                string secondhalf = string.Empty;
                int i = 0;
                foreach (KeyValuePair<string, string> value in requestDataDict)
                {
                    if (DPSubmitRequest)
                    {
                        if (Enum.TryParse(value.Key, out FTPDPMessageRequest checkEnum))
                        {
                            message += $"{value.Value}";
                        }
                    }
                    if (DPNotifyRequest)
                    {
                        if (Enum.TryParse(value.Key, out FTPDPFHNotifyRequest checkEnum))
                        {
                            if (!String.IsNullOrEmpty(value.Value) && value.Value != "0.00")
                            {
                                message += $"{value.Value}";
                            }
                        }

                        if (Enum.TryParse(value.Key, out FTPDPSHNotifyRequest checkEnum2))
                        {
                            if (!String.IsNullOrEmpty(value.Value) && value.Value != "0.00")
                            {
                                secondhalf += $"{value.Value}";
                            }
                        }
                    }
                    i++;
                }
                message += secondhalf;
                message += dictKeys.ContainsKey(FTPaySecureKey.Key.ToString())
                    ? $"{dictKeys[FTPaySecureKey.Key.ToString()]}"
                    : string.Empty;
                return message;
            }
            internal static Dictionary<string, string> StatusCode = new Dictionary<string, string>
            {
                { "0", "未付款" }, { "1", "已支付" }
            };
        }
        #endregion Helper

        #region Models

        //Request Models - Deposit Submission
        internal class FTPayDepositSubmissionRequest
        {
            internal string userid { get; set; }
            internal string orderno { get; set; }
            internal string desc { get; set; }
            internal string amount { get; set; }
            internal string notifyurl { get; set; }
            internal string backurl { get; set; }
            internal string paytype { get; set; }
            //internal string bankstyle { get; set; } //optional
            internal string acname { get; set; } //optional
            //internal string notifystyle { get; set; } //optional, 1 = form, 2 = json
            internal string attach { get; set; } 
            internal string userip { get; set; }
            //internal string bankname { get; set; } //optional
            internal string currency { get; set; }
            internal string sign { get; set; }

            private Dictionary<string, string> _dict = new Dictionary<string, string>();
            internal FTPayDepositSubmissionRequest(
                string strUserid,
                string strOrderno,
                string strDesc,
                string strAmount,
                string strNotifyurl,
                string strBackurl,
                string strPaytype,
                //string strBankstyle, //optional
                string strAcname, //optional
                //string strNotifystyle, //optional, 1 = form, 2 = json
                string strAttach,
                string strUserip,
                //string strBankname, //optional
                string strCurrency,
                string strSign)
            {
                userid = strUserid;
                orderno = strOrderno;
                desc = strDesc;
                amount = strAmount;
                notifyurl = strNotifyurl;
                backurl = strBackurl;
                paytype = strPaytype;
                //bankstyle = strBankstyle; //optional
                acname = strAcname; //optional
                //notifystyle = strNotifystyle; //optional =  ; 1 = form =  ; 2 = json
                attach = strAttach;
                userip = strUserip;
                //bankname = strBankname; //optional
                currency = strCurrency;
                sign = strSign;
                _dict = GenerateDictionary();
            }

            private Dictionary<string, string> GenerateDictionary()
            {
                var reflectionBindingFlag = System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic;
                Func<System.Reflection.PropertyInfo[], IEnumerable<System.Reflection.PropertyInfo>> PropertyQuery = (props) =>
                {
                    List<string> ignoredParams = new List<string> { nameof(_dict), nameof(sign) };
                    var final = props.Where(prop => !ignoredParams.Contains(prop.Name));

                    return final;
                };

                return this.AsDictionary(reflectionBindingFlag, PropertyQuery, FTPayHelper.Stringify);
            }

            internal Dictionary<string, string> AsDictionary()
            {
                return _dict;
            }
        }

        //Response Models - Deposit Submission

        internal class FTPayDepositSubmissionResponse
        {
            public string status { get; set; }
            public string payurl { get; set; }
            public string error { get; set; }
        }

        //Acknowledgement/Callback Models 

        public class FTPayDepositNotifyModel
        {
            public string currency { get; set; }
            public string userid { get; set; }
            public string orderno { get; set; }
            public string outorder { get; set; }
            public string desc { get; set; }
            public string amount { get; set; }
            public string realamount { get; set; }
            public string attch { get; set; }
            public string acname { get; set; }
            public string status { get; set; }
            public string paytime { get; set; }
            public string sign { get; set; }
        }

        #endregion Models

        #region Enum
        internal enum FTPaySecureKey
        {
            Key
        }

        internal enum FTPDPMessageRequest
        {
            userid,
            orderno,
            amount,
            notifyurl
        }

        internal enum FTPDPFHNotifyRequest //first half string
        {
            currency,
            status
        }

        internal enum FTPDPSHNotifyRequest // second half string
        {
            userid,
            orderno,
            amount
        }

        internal enum FTPayActionType
        {
            DepositRequest,
            DepositResponse,
            DepositNotify,
            WithdrawalRequest,
            WithdrawalNotify
        }
        #endregion Enum

        #region Status Response Return

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
}
