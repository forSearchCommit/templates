using System.Threading;
using System.Threading.Tasks;
using System.Transactions;
using System.Web;
using System.Web.Hosting;
using System.Web.Http;
using PaymentManagerBLL = GCT.Web.Member.BLL.PaymentManager;

namespace GCT.Web.Member.WebSite._Partners.V9BetAPI.API
{
    public class DepositController : ApiController
    {
        private readonly PaymentTypeControlManager _manager = new PaymentTypeControlManager();
        private readonly AccountEnum.TransactionType transactionType = AccountEnum.TransactionType.PaymentDeposit;
        private readonly int ServerTimeZone = -4; // currently Server is GMT -4

        private static readonly string BankIconPath = "images/bank/";
        private static readonly string PO_IconPath = "images/paymentoption/";

        internal ILog Log { get; set; }
        private static readonly ILog PaymentLogger = LogManager.GetLogger("Payment");
        private static readonly ILog PaymentReceiptLogger = LogManager.GetLogger("PaymentReceipt");

        /// <summary>
        /// Get Member Current Processing Deposit Transaction
        /// </summary>
        /// <remarks>
        /// - Call this endpoint when member navigate to deposit page
        /// langCode  : string, member langauge code
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        /// 
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("GetProcessingDeposit")]
        [SwitchCultureActionFilter]
        public ResponseResult<GetPendingDepositResponseModel> GetProcessingDeposit(RequestParam<GetPendingDepositRequestModel> param)
        {
            ResponseResult<GetPendingDepositResponseModel> response = new ResponseResult<GetPendingDepositResponseModel>();
            GetPendingDepositResponseModel responseBody = new GetPendingDepositResponseModel();
            ResponseCode responseCode = ResponseStatusCode.Fail;
            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                //PaymentDepositEntity lastDeposit = PaymentDepositManager.Instance.GetLastPaymentTransaction(userInfo.AccountID);

                try
                {
                    List<int> statusList = new List<int>()
                    {
                        (int)PaymentEnum.PaymentDepositStatus.Successful,
                        (int)PaymentEnum.PaymentDepositStatus.Failed,
                        (int)PaymentEnum.PaymentDepositStatus.Cancelled,
                    };
                    List<PaymentDepositEntity> pendingDepositList = PaymentDepositManager.Instance.GetPaymentDepositProcessingList(userInfo.AccountID, statusList);

                    if (pendingDepositList != null && pendingDepositList.Count > 0)
                    {
                        PaymentDepositEntity lastDeposit = pendingDepositList.First();
                        PaymentOptionSettingEntity setting = PaymentSettingCacheManager.GetPaymentOptionSettingDetails(lastDeposit.paymentOptionID);
                        var displayLanguageSetting = setting.DisplayLanguageSetting.Where(m => m.LanguageCode == param.Body.LanguageCode);
                        var detailVo = PaymentDepositManager.Instance.GetPaymentTransactionDetail(lastDeposit.transactionNo);
                        var bank = BankingManager.GetBankById(lastDeposit.bankId);
                        string paymentOptionName = displayLanguageSetting.Select(m => m.DisplayName).FirstOrDefault() ?? lastDeposit.paymentOptionID.ToString();

                        responseBody.ProcessingTransaction = new PendingDepositTransactionContent()
                        {
                            TransactionNumber = lastDeposit.transactionNo,
                            Currency = lastDeposit.currencyCode,
                            TransactionDate = lastDeposit.dateCreated.AddHours(ServerTimeZone * -1).AddMinutes(DateUtil.ConvertTimeZoneToMinutes(param.Body.TimeZone)),
                            Amount = lastDeposit.grossAmount,
                            BankName = userInfo.CurrencyCode.Equals("USDT") ? bank.BankCode : (lastDeposit.bankName ?? string.Empty),
                            TransactionStatusID = (int)lastDeposit.paymentDepositStatus,
                            TransactionStatusName = lastDeposit.paymentDepositStatus.Equals(PaymentEnum.PaymentDepositStatus.Pending) ? "Pending" : "Processing",
                            PaymentType = (int)lastDeposit.paymentType,
                            DepositMethod = userInfo.CurrencyCode.Equals("USDT") ? string.Format("{0}-{1}", paymentOptionName, bank.BankCode) : paymentOptionName,
                            IsAbleToCancel = IsAbleToCancelDepositTransaction(lastDeposit.paymentDepositStatus),
                        };

                        if (detailVo.LstPaymentGatewayDetailVO != null && detailVo.LstPaymentGatewayDetailVO.Count > 0)
                        {
                            var url = HttpContext.Current.Request.Url;
                            string receiptPath = AppConfigManager.SystemSetting.UploadReceiptPath;

                            responseBody.Receipts = new List<ReceiptViewModel>();

                            var receiptList = detailVo.LstPaymentGatewayDetailVO.Where(x =>
                                x.PaymentTransDetailMapId.Equals(PaymentTransactionDetailConstant.DP_RECEIPT_IMAGE_NAME_1) ||
                                x.PaymentTransDetailMapId.Equals(PaymentTransactionDetailConstant.DP_RECEIPT_IMAGE_NAME_2) ||
                                x.PaymentTransDetailMapId.Equals(PaymentTransactionDetailConstant.DP_RECEIPT_IMAGE_NAME_3));

                            foreach (var receipt in receiptList)
                            {
                                if (!string.IsNullOrEmpty(receipt.value) && receipt.value.Split('|').Length >= 2)
                                {
                                    string originalFileName = receipt.value.Split('|')[0];
                                    string fileName = receipt.value.Split('|')[1];

                                    responseBody.Receipts.Add(new ReceiptViewModel()
                                    {
                                        FileOriginalName = receipt.value.Split('|')[0],
                                        FileName = receipt.value.Split('|')[1],
                                        Base64Content = getBase64ContentForAttachment(receiptPath, fileName),
                                    });
                                }
                            }
                        }
                    }

                    responseBody.Result = true;
                    responseCode = ResponseStatusCode.Success;
                }
                catch (Exception ex)
                {
                    PaymentLogger.Error(string.Format("[GetProcessingDeposit][Error] UserInfo : [{0}]", JsonConvert.SerializeObject(userInfo)), ex);
                    responseCode = ResponseStatusCode.ExceptionError;
                }

                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
                PaymentLogger.InfoFormat("[GetProcessingDeposit] - Result [{0}] - Message: {1}, Body: {2}", userInfo.LoginName, response.Message, JsonConvert.SerializeObject(response.Body.ProcessingTransaction));
            }

            return response;
        }

        /// <summary>
        /// Get Member Deposit Page Info for First Load
        /// </summary>
        /// <remarks>
        /// - Call this endpoint when member did not have any processing transaction
        /// langCode  : string, member langauge code
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        /// 
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// GNR00003 Exeception Error
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("GetDepositInfo")]
        [SwitchCultureActionFilter]
        public ResponseResult<DepositInfoResponseModel> GetDepositInfo(RequestParam<DepositInfoRequestModel> param)
        {
            PaymentLogger.InfoFormat("[GetDepositInfo] - SSOToken: [{0}], Channel: [{1}]", param.Body.SSoToken, param.Body.ChannelId);
            ResponseResult<DepositInfoResponseModel> response = new ResponseResult<DepositInfoResponseModel>();
            DepositInfoResponseModel responseBody = new DepositInfoResponseModel();
            ResponseCode responseCode = ResponseStatusCode.Fail;
            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                try
                {
                    MemberEntity memberEntity = MemberManager.Instance.GetMemberById(userInfo.UserID);
                    int websiteID = AppConfigManager.PartnerSetting.WebsiteId;
                    int accountID = memberEntity.memberAccount.accountId;
                    UserManager.UpdateMemberActivity(userInfo.LoginName ?? memberEntity.memberName, (int)GCT.Entities.Enum.MemberEnum.MemberSiteActivity.Deposit);

                    double memberTimeZoneInMin = DateUtil.ConvertTimeZoneToMinutes(param.Body.TimeZone);

                    responseBody.PaymentOptionList = new List<PaymentOptionViewModel>();

                    List<BankAccountMemberEntity> memberBankAccountNumberList = BankingManager.GetBankAccountMemberData(memberEntity.memberId).ToList();
                    List<PaymentOptionWithMaintainInfoEntity> paymentOptionList = PaymentSettingManager.Instance.GetActivePaymentOptionByCurrencyAndCountry(memberEntity.currencyCode, memberEntity.countryCode, (int)MemberEnum.RegisteredChannel.Mobile).Where(x => x.TransactionTypeID.Equals(transactionType)).ToList();
                    List<PaymentOptionBankAccountGroupBlacklistVO> PaymentOptionBlacklist = PaymentSettingCacheManager.GetPaymentOptionBankAccountGroupBlacklist(websiteID);
                    PaymentOptionBlacklist = PaymentOptionBlacklist.Where(x => x.BankAccountGroupID == memberEntity.bankAccountGroupID && x.IsForMobile == true).ToList();
                    List<PaymentOptionDisplaySequenceSettingEntity> displaySequenceList = PaymentSettingCacheManager.GetPaymentOptionDisplaySequenceSetting(websiteID, userInfo.CurrencyCode);

                    //Filter Bank Account Group BlackList
                    paymentOptionList = paymentOptionList.Where(x => !PaymentOptionBlacklist.Select(y => y.PaymentOptionID).Contains((int)x.PaymentOptionID)).ToList();

                    var lastUsedRawInfo = PaymentDepositManager.Instance.GetLastPaymentTransaction(accountID);
                    //var lastUsedRawInfo = BankingManager.GetDepositTransactionAndDetailsBySearchCriteria(SessionData.MemberEntity.memberId, websiteID, PaymentEnum.PaymentType.NA, PaymentEnum.PaymentDepositStatus.NA).OrderByDescending(x => x.paymentTrans.dateCreated).FirstOrDefault();

                    foreach (var paymentOption in paymentOptionList)
                    {
                        var isPaymentOptionActivateByChannel = PaymentSettingCacheManager.GetPaymentOptionChannelSetting(websiteID).Where(s => s.RegisteredChannelID == userInfo.Channel && s.Status && s.PaymentOptionID == (int)paymentOption.PaymentOptionID).Any();
                        List<PaymentTypeWithBankEntity> paymentTypeWithBankList = PaymentManagerBLL.GetPaymentTypeWithSupportBanksByPaymentOption(memberEntity.memberId, paymentOption.PaymentOptionID, transactionType, _manager.Configuration.WhiteBlackListEnabled);

                        if (paymentTypeWithBankList.Count > 0 && isPaymentOptionActivateByChannel)
                        {
                            var item = new PaymentOptionViewModel();
                            DateTime? maintenanceDate = null;

                            PaymentOptionSettingEntity setting = PaymentSettingCacheManager.GetPaymentOptionSettingDetails((int)paymentOption.PaymentOptionID);
                            var displayLanguageSetting = setting.DisplayLanguageSetting.Where(m => m.LanguageCode == param.Body.LanguageCode);
                            var icon = displayLanguageSetting.Select(m => m.Icon).FirstOrDefault();
                            var iconName = string.IsNullOrEmpty(displayLanguageSetting.Select(m => m.IconName).FirstOrDefault()) ? "default-paymentgateway.jpg" : displayLanguageSetting.Select(m => m.IconName).FirstOrDefault();
                            var iconPath = getPO_IconPath(icon, iconName);
                            var displaySequenceSetting = displaySequenceList.Where(x => x.CurrencyCode.Equals(userInfo.CurrencyCode) && x.PaymentOptionID.Equals((int)paymentOption.PaymentOptionID)).FirstOrDefault();

                            item.PaymentOptionName = displayLanguageSetting.Select(m => m.DisplayName).FirstOrDefault();
                            item.PaymentOptionID = (int)paymentOption.PaymentOptionID;
                            item.OrderSequence = lastUsedRawInfo != null && paymentOption.PaymentOptionID.Equals((PaymentEnum.PaymentOption)lastUsedRawInfo.paymentOptionID) ? 0 : displaySequenceSetting == null ? 1 : displaySequenceSetting.DisplaySequence + 1;
                            item.IconName = iconName;
                            item.IconPath = iconPath;

                            if (paymentOption.IsMaintain)
                            {
                                item.IsMaintenance = true;
                                item.MaintenanceEndDate = paymentOption.MaintainEndDate.Value.AddHours(ServerTimeZone * -1).AddMinutes(memberTimeZoneInMin);
                            }
                            else if (PaymentHelper.IsPaymentTypeUnderPaymentOptionInMaintenance(paymentOption.PaymentOptionID, paymentTypeWithBankList, memberBankAccountNumberList, out maintenanceDate))
                            {
                                item.IsMaintenance = true;
                                item.MaintenanceEndDate = maintenanceDate.Value.AddHours(ServerTimeZone * -1).AddMinutes(memberTimeZoneInMin);
                            }

                            responseBody.PaymentOptionList.Add(item);
                        }
                    }

                    responseBody.CurrencyCode = memberEntity.currencyCode;
                    responseBody.PaymentOptionList = responseBody.PaymentOptionList.OrderBy(x => x.OrderSequence).ToList();
                    responseBody.LastUsed = lastUsedRawInfo == null ? null : responseBody.PaymentOptionList.Where(x => x.PaymentOptionID.Equals(lastUsedRawInfo.paymentOptionID)).FirstOrDefault();
                    responseCode = ResponseStatusCode.Success;

                    if (responseBody.PaymentOptionList.Count <= 0)
                        responseCode = ResponseStatusCode.NoPOisAvailableForDeposit;

                    if (memberEntity.memberStatus.Equals(MemberEnum.MemberStatus.Suspended))
                        responseCode = ResponseStatusCode.InvalidMemberStatusForDeposit;

                    ServiceLogUtilities.ServiceMemberPaymentActivityLogger(userInfo.LoginName, transactionType.ToString(), nameof(GetDepositInfo), param.Body.ChannelId, responseCode.Code.Equals(ResponseStatusCode.Success.Code), responseCode.Message, string.Empty, JsonConvert.SerializeObject(responseBody));
                }
                catch (PaymentException ex)
                {
                    PaymentLogger.Error(string.Format("[GetDepositInfo][Error] UserInfo : [{0}], langCode : [{1}]", JsonConvert.SerializeObject(userInfo), param.Body.LanguageCode), ex);
                    ServiceLogUtilities.ServiceMemberPaymentActivityLogger(userInfo.LoginName, transactionType.ToString(), nameof(GetDepositInfo), param.Body.ChannelId, ex);
                    responseCode = ResponseStatusCode.ExceptionError;
                }

                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
                PaymentLogger.InfoFormat("[GetDepositInfo] - Result [{0}] - Message: {1}, Body: {2}", userInfo.LoginName, response.Message, JsonConvert.SerializeObject(response.Body));
            }

            return response;
        }

        /// <summary>
        ///  Get Payment Option Details
        /// </summary>
        /// <remarks>
        /// - Call this endpoint when member navigate to deposit page
        /// paymentOptionID : int, the payment method which user selected , get from endpoint /getdepositinfo
        /// langCode  : string, member langauge code
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        /// 
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// GNR00003 Exeception Error
        /// PAY10003 Deposit Reached Daily Limit Amount
        /// PAY10004 Payment Option Not Available
        /// PAY10006 Deposit Payment Option Reached Daily Limit Amount
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("MemberPODetails")]
        [SwitchCultureActionFilter]
        public ResponseResult<MemberPODetailsResponseModel> MemberPODetails(RequestParam<MemberPODetailsRequestModel> param)
        {
            PaymentLogger.InfoFormat("[MemberPODetails] - SSOToken: [{0}], Channel: [{1}]", param.Body.SSoToken, param.Body.ChannelId);

            ResponseResult<MemberPODetailsResponseModel> response = new ResponseResult<MemberPODetailsResponseModel>();
            MemberPODetailsResponseModel responseBody = new MemberPODetailsResponseModel();
            ResponseCode responseCode = ResponseStatusCode.Success;
            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                try
                {
                    int websiteID = AppConfigManager.PartnerSetting.WebsiteId;
                    DateTime? maintenanceDate = null;

                    bool isMemberBankInfoRequired = isMemberBankAccountInfoRequired((PaymentEnum.PaymentOption)param.Body.PaymentOptionID);
                    List<BankAccountMemberEntity> memberBankAccountNumberList = BankingManager.GetBankAccountMemberData(userInfo.UserID).ToList();
                    List<PaymentTypeWithBankEntity> paymentTypeWithBankList = PaymentManagerBLL.GetPaymentTypeWithSupportBanksByPaymentOption(userInfo.UserID, (PaymentEnum.PaymentOption)param.Body.PaymentOptionID, transactionType, _manager.Configuration.WhiteBlackListEnabled);
                    var paymentTypeFilterList = isMemberBankInfoRequired ? paymentTypeWithBankList.Where(x => memberBankAccountNumberList.Select(y => y.bankID).Distinct().Contains(x.BankID)).ToList() : paymentTypeWithBankList;
                    var paymentOptionMaintainInfo = PaymentSettingManager.Instance.GetPaymentOptionMaintenanceByPaymentOptionID(param.Body.PaymentOptionID);
                    var limitSetting = PaymentManagerBLL.GetMemberPaymentLimitByPaymentOptionID(userInfo.UserID, (PaymentEnum.PaymentOption)param.Body.PaymentOptionID, userInfo.CurrencyCode, transactionType);
                    bool POIsMaintain = paymentOptionMaintainInfo.recurringList.Where(x => x.Status).Count() > 0 && (DateTime.UtcNow.AddHours(ServerTimeZone) >= paymentOptionMaintainInfo.ActiveStartDate && DateTime.UtcNow.AddHours(ServerTimeZone) <= paymentOptionMaintainInfo.ActiveEndDate);
                    bool isMaintain = POIsMaintain && PaymentHelper.IsPaymentTypeUnderPaymentOptionInMaintenance((PaymentEnum.PaymentOption)param.Body.PaymentOptionID, paymentTypeFilterList, memberBankAccountNumberList, out maintenanceDate);
                    var isSupportRoutingRules = PaymentSettingCacheManager.GetPaymentOptionList(websiteID).Where(x => x.PaymentOptionID.Equals(param.Body.PaymentOptionID)).First().IsSupportRoutingRules;

                    responseBody.IsReachedDailyLimit = isReachPOCount(limitSetting);
                    responseBody.IsReachedOverallDailyLimit = isReachOverallCount(limitSetting);
                    responseBody.IsReachedPOAmountLimit = isReachPODailyLimit(limitSetting, 0, true);
                    responseBody.IsReachedOverallAmountLimit = isReachOverallLimit(limitSetting, 0, true);

                    //if (responseBody)
                    if (!isMaintain && (paymentTypeWithBankList.Count > 0 || !isSupportRoutingRules))
                    {
                        responseBody.IsMemberBankInfoNeeded = isMemberBankInfoRequired;
                        responseBody.PaymentOptionID = param.Body.PaymentOptionID;
                        responseBody.MemberBankAccountList = getMemberBankAccountList(memberBankAccountNumberList, paymentTypeFilterList, userInfo.UserID, userInfo.AccountID);
                        responseBody.MaxDepositDailyCount = limitSetting.LimitCount;
                        responseBody.TodayDepositRemainCount = limitSetting.LimitCount.HasValue ? ((limitSetting.LimitCount - limitSetting.CurrentCount) > 0 ? (limitSetting.LimitCount - limitSetting.CurrentCount) : 0) : (int?)null;

                        if (paymentTypeFilterList.Count > 0)
                        {
                            List<PaymentTypeGatewaySettingEntity> paymentTypeGatewaySettingList = PaymentManagerBLL.GetPaymentTypeGatewaySettingList(paymentTypeFilterList.Select(x => x.PaymentTypeGatewaySettingID).ToList()).Where(y => y.Currency.Equals(userInfo.CurrencyCode)).ToList();
                            decimal? poRemain = limitSetting.LimitAmount.HasValue ? limitSetting.LimitAmount.Value - limitSetting.CurrentAmount : (decimal?)null;
                            decimal? overallRemain = limitSetting.OverallAmountLimit.HasValue ? limitSetting.OverallAmountLimit.Value - limitSetting.CurrentOverallAmount : (decimal?)null;

                            decimal? remain = GetMinDecimal(overallRemain, poRemain);

                            decimal minRangeAmountWithinAllPT = 0; // use to check remain amount quota
                            decimal minCoinValueWithinAllPT = 0; // use to check remain amount quota

                            List<PaymentTypeGatewaySettingEntity> rangeAmountPTs = paymentTypeGatewaySettingList.Where(x => x.IsAnyAmount).ToList();
                            if (rangeAmountPTs.Count > 0)
                            {
                                responseBody.RangeAmount = new RangeAmountModel();
                                responseBody.RangeAmount.MinAvailableAmount = DecimalUtil.RoundTwoDecimal(rangeAmountPTs.OrderBy(x => x.MinPerTransaction).First().MinPerTransaction).ToDecimalByEnGB();
                                responseBody.RangeAmount.MaxAvailableAmount = DecimalUtil.RoundTwoDecimal(rangeAmountPTs.OrderByDescending(x => x.MaxPerTransaction).First().MaxPerTransaction).ToDecimalByEnGB();

                                minRangeAmountWithinAllPT = responseBody.RangeAmount.MinAvailableAmount;

                                //if (limitSetting.OverallAmountLimit.HasValue && limitSetting.OverallAmountLimit.Value < responseBody.RangeAmount.MaxAvailableAmount)
                                //    responseBody.RangeAmount.MaxAvailableAmount = limitSetting.OverallAmountLimit.Value;

                                //if (limitSetting.LimitAmount.HasValue && limitSetting.LimitAmount.Value < responseBody.RangeAmount.MaxAvailableAmount)
                                //    responseBody.RangeAmount.MaxAvailableAmount = limitSetting.LimitAmount.Value;

                                //if (remain.HasValue && responseBody.RangeAmount.MaxAvailableAmount > remain.Value)
                                //    responseBody.RangeAmount.MaxAvailableAmount = remain.Value;

                                responseBody.RangeAmount.MaxAvailableAmount = (decimal)GetMinDecimal(limitSetting.OverallAmountLimit, limitSetting.LimitAmount, remain, responseBody.RangeAmount.MaxAvailableAmount);

                                if (responseBody.RangeAmount.MinAvailableAmount > responseBody.RangeAmount.MaxAvailableAmount)
                                {
                                    responseBody.RangeAmount.MinAvailableAmount = 0;
                                    responseBody.RangeAmount.MaxAvailableAmount = 0;
                                }
                            }

                            List<PaymentTypeGatewaySettingEntity> fixedAmountPTs = paymentTypeGatewaySettingList.Where(x => x.IsFixedAmount).ToList();
                            if (fixedAmountPTs.Count > 0)
                            {
                                List<decimal> coinValueList = new List<decimal>();
                                foreach (var coinValues in fixedAmountPTs.Select(x => x.CoinValue.Split(',').Select(y => Convert.ToDecimal(y)).ToList()))
                                {
                                    coinValueList.AddRange(coinValues);
                                }

                                responseBody.FixAmount = new FixAmountModel() { FixAmountList = coinValueList.Distinct().OrderBy(x=>x).ToList() };

                                minCoinValueWithinAllPT = coinValueList.Min();

                                if (remain.HasValue)
                                {
                                    responseBody.FixAmount.FixAmountList = coinValueList.Where(x => x <= remain).Distinct().OrderBy(x => x).ToList();
                                }
                            }

                            //Reached Daily Limit if remain amount quota is less than all PT min available amount
                            if (remain.HasValue && responseBody.RangeAmount != null && responseBody.FixAmount != null)
                            {
                                responseBody.IsReachedPOAmountLimit = (remain.Value < minRangeAmountWithinAllPT && remain.Value < minCoinValueWithinAllPT) || responseBody.IsReachedPOAmountLimit;
                            }
                            else if (remain.HasValue && responseBody.RangeAmount != null && responseBody.FixAmount == null)
                            {
                                responseBody.IsReachedPOAmountLimit = remain.Value < minRangeAmountWithinAllPT || responseBody.IsReachedPOAmountLimit;
                            }
                            else if (remain.HasValue && responseBody.FixAmount != null && responseBody.RangeAmount == null)
                            {
                                responseBody.IsReachedPOAmountLimit = remain.Value < minCoinValueWithinAllPT || responseBody.IsReachedPOAmountLimit;
                            }
                        }

                        //Check At least one amount type not be null
                        if (responseBody.RangeAmount == null && responseBody.FixAmount == null)
                        {
                            responseBody.RangeAmount = new RangeAmountModel() { MinAvailableAmount = 0, MaxAvailableAmount = 0 };
                        }

                        responseCode = ResponseStatusCode.Success;
                    }
                    else if (isMaintain)
                    {
                        responseCode = ResponseStatusCode.PONotAvailable;
                    }

                    ServiceLogUtilities.ServiceMemberPaymentActivityLogger(userInfo.LoginName, transactionType.ToString(), nameof(MemberPODetails), param.Body.ChannelId, responseCode.Code.Equals(ResponseStatusCode.Success.Code), responseCode.Message, string.Empty, JsonConvert.SerializeObject(responseBody));
                }
                catch (Exception ex)
                {
                    PaymentLogger.Error(string.Format("[MemberPODetails][Error] UserInfo : [{0}], ReqParam : [{1}]", JsonConvert.SerializeObject(userInfo), JsonConvert.SerializeObject(param.Body)), ex);
                    ServiceLogUtilities.ServiceMemberPaymentActivityLogger(userInfo.LoginName, transactionType.ToString(), nameof(MemberPODetails), param.Body.ChannelId, ex);
                    responseCode = ResponseStatusCode.ExceptionError;
                }

                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
                PaymentLogger.InfoFormat("[MemberPODetails] - Result [{0}] - Message: {1}, Body: {2}", userInfo.LoginName, response.Message, JsonConvert.SerializeObject(response.Body));
            }

            return response;
        }

        /// <summary>
        /// Submit Deposit
        /// </summary>
        /// <remarks>
        /// - Submit Deposit
        /// bankID : int, get from endpoint /MemberPODetails
        /// memberBankAccountNo : string, get from endpoint /MemberPODetails
        /// paymentOptionID : int, the payment method which user selected , get from endpoint /getdepositinfo
        /// paymentOptionName : string, the name of payment method which user selected , get from endpoint /getdepositinfo
        /// amount : decimal, user input
        /// blackBox : string, blackBox value
        /// langCode  : string, member langauge code
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        /// 
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// GNR00003 Exeception Error
        /// MEM00004 Full Name Incomplete
        /// ALL PAY1XXXX
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("Submit")]
        public ResponseResult<SubmitDepositResponseModel> Submit(RequestParam<SubmitDepositRequestModel> param)
        {
            ResponseResult<SubmitDepositResponseModel> response = new ResponseResult<SubmitDepositResponseModel>();
            SubmitDepositResponseModel responseBody = new SubmitDepositResponseModel();
            ResponseCode responseCode = ResponseStatusCode.Fail;
            SessionInfo userInfo = new SessionInfo();

            PaymentLogger.Info(string.Format("[SubmitDeposit] - ReqUrl : [{0}]", Request.RequestUri.Host));

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                PaymentLogger.Info(string.Format("[SubmitDeposit] - ReqParam : [{0}]", JsonConvert.SerializeObject(param.Body)));

                try
                {
                    MemberEntity memberEntity = MemberManager.Instance.GetMemberById(userInfo.UserID);

                    // Current MemberBankAccountNo from frontend is BankAccountID , get MemberBankAccountNo by BankAccountID
                    if (isMemberBankAccountInfoRequired((PaymentEnum.PaymentOption)param.Body.PaymentOptionID) && int.TryParse(param.Body.MemberBankAccountNo, out int bankaccId))
                    {
                        BankAccountMemberEntity memberBankAccountTemp = BankAccountManager.Instance.GetBankAccountMemberByID(Convert.ToInt32(param.Body.MemberBankAccountNo));
                        param.Body.MemberBankAccountNo = memberBankAccountTemp.bankAccountNo;
                    }

                    int websiteID = AppConfigManager.PartnerSetting.WebsiteId;
                    string transactionNo = string.Empty;

                    BlackBoxService(param.Body.BlackBox, userInfo.LoginName, userInfo.IPAddress, GZSevenActionEnum.Deposit);

                    bool success = false;
                    ResponseCode errorCode = submitDepositValidationCheck(param.Body, memberEntity);

                    try
                    {
                        MemberBankAccountEntity memberBankAccount = isMemberBankAccountInfoRequired((PaymentEnum.PaymentOption)param.Body.PaymentOptionID) ? BankAccountManager.Instance.GetBankAccountMemberByMemberBankAccountNo(param.Body.MemberBankAccountNo) : null;
                        param.Body.BankID = isMemberBankAccountInfoRequired((PaymentEnum.PaymentOption)param.Body.PaymentOptionID) ? param.Body.BankID : 0; // bank id = 0 when no need bank info

                        //Submit Deposit
                        if (errorCode == null)
                        {
                            var model = new CreateDepositModel()
                            {
                                AccountID = memberEntity.memberAccount.accountId,
                                PaymentOption = (PaymentEnum.PaymentOption)param.Body.PaymentOptionID,
                                PaymentOptionType = BLL.PaymentManager.GetPaymentOptionList(websiteID).Where(x => x.PaymentOptionID.Equals(param.Body.PaymentOptionID)).First().PaymentOptionType,
                                BankID = param.Body.BankID,
                                Amount = param.Body.Amount,
                                Currency = memberEntity.currencyCode
                            };

                            var transactionResult = BankingManager.CreateDeposit(userInfo.IPAddress, userInfo.Channel, model, memberEntity, memberBankAccount);
                            transactionNo = transactionResult.Id;
                            success = !string.IsNullOrEmpty(transactionResult.Id);
                        }
                    }
                    catch (PaymentException ex)
                    {
                        responseBody.IsSuccess = false;
                        responseCode = PaymentHelper.PaymentErrorCodeMapping(ex, transactionType, "SubmitDeposit", memberEntity.memberName);

                        if (!string.IsNullOrEmpty(ex.ErrorCode) && !Enum.TryParse(ex.ErrorCode.ToString(), true, out ErrorEnum.ErrCode err))
                        {
                            PaymentLogger.Error(string.Format("[SubmitDeposit][Error] CreateTransaction - MemberName : [{0}] ReqParam : [{1}]", userInfo.LoginName, JsonConvert.SerializeObject(param.Body)), ex);
                        }
                    }
                    finally
                    {
                        PaymentLogger.InfoFormat("[SubmitDeposit] CreateTransaction - MemberName : [{0}] TransactionNo : [{1}] Result : [{2}]", userInfo.LoginName, transactionNo ?? string.Empty, success.Equals(true) ? "Success" : "Fail");
                    }

                    if (success)
                    {
                        var deposit = PaymentManagerBLL.GetPaymentDepositByTransactionNo(memberEntity.memberAccount.accountId, transactionNo);
                        //var paymentTypeDic = PaymentManagerBLL.GetPaymentTypeList(websiteID).ToDictionary(x => x.paymentTypeID, x => x);

                        PaymentTypeGatewaySettingEntity paymentSetting = PaymentSettingCacheManager.GetPaymentTypeGatewaySetting(deposit.paymentType, deposit.paymentOptionID);

                        responseBody.IsSuccess = success;
                        responseBody.RedirectUrl = constructRedirectUrl(deposit.paymentType, (PaymentEnum.PaymentOption)deposit.paymentOptionID, deposit.transactionNo);
                        responseBody.TransactionContent = constructTransactionContent(deposit, memberEntity, param.Body.PaymentOptionName, param.Body.TimeZone);
                        responseBody.IsAbleToCancel = IsAbleToCancelDepositTransaction(deposit.paymentDepositStatus);
                        responseBody.IsPopUpProviderPage = paymentSetting.IsPopUpProviderPage;

                        responseCode = ResponseStatusCode.Success;
                    }
                    else if (!success && errorCode != null)
                    {
                        responseBody = new SubmitDepositResponseModel()
                        {
                            IsSuccess = false,
                            RedirectUrl = string.Empty,
                            TransactionContent = null
                        };

                        responseCode = errorCode;
                    }
                    else
                    {
                        PaymentLogger.Error(string.Format("[SubmitDeposit] Unexpected error ocurred. MemberCode : [{0}] , Request Content : [{1}]", memberEntity.memberName, JsonConvert.SerializeObject(param.Body)));

                        responseBody = new SubmitDepositResponseModel()
                        {
                            IsSuccess = false,
                            RedirectUrl = string.Empty,
                            TransactionContent = null
                        };

                        responseCode = ResponseStatusCode.DepositError;
                    }

                    ServiceLogUtilities.ServiceMemberPaymentActivityLogger(userInfo.LoginName, transactionType.ToString(), nameof(Submit), param.Body.ChannelId, responseCode.Code.Equals(ResponseStatusCode.Success.Code), responseCode.Message, transactionNo ?? string.Empty, JsonConvert.SerializeObject(responseBody));
                }
                catch (Exception ex)
                {
                    PaymentLogger.Error(string.Format("[SubmitDeposit][Error] UserInfo : [{0}], ReqParam : [{1}]", JsonConvert.SerializeObject(userInfo), JsonConvert.SerializeObject(param.Body)), ex);
                    ServiceLogUtilities.ServiceMemberPaymentActivityLogger(userInfo.LoginName, transactionType.ToString(), nameof(Submit), param.Body.ChannelId, ex, "RequestParam-" + JsonConvert.SerializeObject(param));
                    FileLogger.Instance.Exception(ex);
                    responseCode = ResponseStatusCode.DepositError;
                }

                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
            }

            PaymentLogger.InfoFormat("[SubmitDeposit] - Result [{0}] - Message: {1}, Body: {2}", userInfo.LoginName, response.Message, JsonConvert.SerializeObject(response.Body));
            return response;
        }

        /// <summary>
        /// Upload Transaction Receipt After Deposit
        /// </summary>
        /// <remarks>
        /// - Upload transaction receipts after submit deposit
        /// transactionNumber : string, get from endpoint /submit
        /// receipts : object array, an array of base64Content and fileName
        /// base64Content  : string, convert image file to base64
        /// fileName  : string, the file name with extension, ex : Receipt1.jpg
        /// langCode  : string, language code
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        /// 
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// GNR00003 Exeception Error
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("UploadReceipt")]
        [SwitchCultureActionFilter]
        public ResponseResult<UploadReceiptResponseModel> UploadReceipt(RequestParam<UploadReceiptRequestModel> param)
        {
            ResponseResult<UploadReceiptResponseModel> response = new ResponseResult<UploadReceiptResponseModel>();
            UploadReceiptResponseModel responseBody = new UploadReceiptResponseModel();
            ResponseCode responseCode = ResponseStatusCode.Success;
            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                try
                {
                    #region ValidationCheck

                    if (param.Body == null || string.IsNullOrEmpty(param.Body.TransactionNumber))
                    {
                        response.SetByResponseCode(ResponseStatusCode.Fail);
                        PaymentReceiptLogger.InfoFormat("[UploadReceipt] - Result [{0}] - Message: {1}, Body: {2}", param.Body == null ? string.Empty : param.Body.TransactionNumber, response.Message, JsonConvert.SerializeObject(response.Body));
                        return response;
                    }

                    if (param.Body.Receipts == null)
                    {
                        response.SetByResponseCode(ResponseStatusCode.Fail);
                        PaymentReceiptLogger.InfoFormat("[UploadReceipt] - Result [{0}] - Message: {1}, Body: {2}", param.Body.TransactionNumber, response.Message, JsonConvert.SerializeObject(response.Body));
                        return response;
                    }

                    #endregion

                    //List<ReceiptModel> receiptsList = JsonConvert.DeserializeObject<List<ReceiptModel>>(param.Body.Receipts);

                    List<Task> subTaskList = new List<Task>();

                    foreach (var receipt in param.Body.Receipts)
                    {
                        if (string.IsNullOrEmpty(receipt.FileName) || string.IsNullOrEmpty(receipt.Base64Content))
                        {
                            responseCode = ResponseStatusCode.Fail;
                            break;
                        }

                        if (receipt.Base64Content.StartsWith("data:image/") || receipt.Base64Content.StartsWith("data:application/pdf;"))
                        {
                            var prefix = receipt.Base64Content.Substring(0, receipt.Base64Content.IndexOf(',') + 1);
                            receipt.Base64Content = receipt.Base64Content.Replace(prefix, string.Empty);
                        }

                        byte[] ImageData = Convert.FromBase64String(receipt.Base64Content);
                        ImageData = getCompressImage(ImageData);
                        var task = new Task(() =>
                        {
                            try
                            {
                                PaymentDepositManager.Instance.DepositGateway().CdcTransfer2.UploadReceiptImage(param.Body.TransactionNumber, ImageData, receipt.FileName, AppConfigManager.SystemSetting.UploadReceiptPath, userInfo.LoginName);
                            }
                            catch (Exception ex)
                            {
                                PaymentReceiptLogger.Error(string.Format("[UploadReceipt][Error] Task Transaction No : [{0}], ReqParam : [{1}]", param.Body.TransactionNumber, JsonConvert.SerializeObject(param.Body)), ex);
                            }
                        });

                        subTaskList.Add(task);

                        responseBody.IsSuccess = true;
                        responseCode = ResponseStatusCode.Success;
                    }

                    Task mainTask = Task.Run(() =>
                    {
                        foreach (var task in subTaskList)
                        {
                            task.Start();
                            task.Wait();
                        }
                    });
                    mainTask.Wait();
                    //Thread.Sleep(3000);
                }
                catch (Exception ex)
                {
                    PaymentReceiptLogger.Error(string.Format("[UploadReceipt][Error] Transaction No : [{0}], ReqParam : [{1}]", param.Body.TransactionNumber, JsonConvert.SerializeObject(param.Body)), ex);
                    responseBody.IsSuccess = false;
                    responseCode = ResponseStatusCode.ExceptionError;
                }


                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
            }

            PaymentReceiptLogger.InfoFormat("[UploadReceipt] - Transaction No [{0}] - Message: {1}, Body: {2}", param.Body.TransactionNumber, response.Message, JsonConvert.SerializeObject(response.Body));
            return response;
        }

        /// <summary>
        /// Get all the bank that supported by the payment option
        /// </summary>
        /// <remarks>
        /// - Get all the bank that supported by the payment option
        /// paymentOptionID : int, the payment method which user selected , get from endpoint /getdepositinfo
        /// currency : string, get from endpoint /getdepositinfo
        /// langCode  : string, member langauge code
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        /// 
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("GetSupportedBankList")]
        [SwitchCultureActionFilter]
        public ResponseResult<GetDepositSupportedBankListResponse> GetSupportedBankList(RequestParam<GetDepositSupportedBankListRequest> param)
        {
            LogHelper.CommonLog.InfoFormat("[GetMemberBankCard] - SSOToken: [{0}], Channel: [{1}]", param.Body.SSoToken, param.Body.ChannelId);
            ResponseResult<GetDepositSupportedBankListResponse> response = new ResponseResult<GetDepositSupportedBankListResponse>();
            GetDepositSupportedBankListResponse responseBody = new GetDepositSupportedBankListResponse();
            ResponseCode responseCode = ResponseStatusCode.Fail;

            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {

                var isSupportRoutingRule = PaymentSettingCacheManager.GetPaymentOptionList(AppConfigManager.PartnerSetting.WebsiteId)
                        .Where(x => x.PaymentOptionID.Equals(param.Body.PaymentOptionID) && x.TransactionTypeID.Equals((int)transactionType)).FirstOrDefault().IsSupportRoutingRules;

                if (isSupportRoutingRule)
                {
                    var supportedBank = PaymentManagerBLL.GetPaymentTypeWithSupportBanksByPaymentOption(userInfo.UserID, (PaymentEnum.PaymentOption)param.Body.PaymentOptionID, transactionType, _manager.Configuration.WhiteBlackListEnabled);

                    responseBody.BankList = supportedBank.Select(x => new BankDetails()
                    {
                        BankId = x.BankID,
                        BankName = x.BankName,
                        IconName = x.BankImageName,
                        IsMaintain = x.IsBankMaintain
                    }).ToList();
                }
                else
                {
                    CurrencyEntity currency = MemberCacheManager.GetCurrencyByCode(param.Body.Currency);
                    CountryEntity country = MemberCacheManager.GetCountryByCode(userInfo.CountryCode);
                    var supportedBank = PaymentSettingCacheManager.GetBankListMemberByCountryIdAndCurrencyId(country.CountryId, currency.currencyId)
                        .Where(x => x.IsDeleted.Equals(false) && x.Status.Equals(BankAccountEnum.BankAccountStatus.Active)).ToList();
                    responseBody.BankList = supportedBank.Select(x => new BankDetails()
                    {
                        BankId = x.BankID,
                        BankName = x.BankName,
                        IconName = x.BankImageName,
                        IsMaintain = false
                    }).ToList();
                }

                responseCode = ResponseStatusCode.Success;

                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
            }

            return response;
        }

        /// <summary>
        /// Cancel pending deposit transaction
        /// </summary>
        /// <remarks>
        /// - Cancel pending deposit transaction 
        /// transactionNumber : string, get from endpoint /Submit
        /// transactionStatus : int, get from endpoint /Submit
        /// paymentType": int, get from endpoint /Submit
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// channelId : int, refer to enumChannel, Example : Website = 1, Mobile = 2, Android = 3, IOS = 4
        /// timezone  : double, Example : 8 OR -6
        ///
        /// - Possible return response Code 
        /// GNR00001 Success
        /// GNR00002 Fail
        /// </remarks>
        /// <param name="param"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("CancelPending")]
        [SwitchCultureActionFilter]
        public ResponseResult<ResponseBase> CancelPending(RequestParam<CancelDepositTransactionRequestModel> param)
        {
            PaymentLogger.InfoFormat("[CancelDeposit] - SSOToken: [{0}], Channel: [{1}]", param.Body.SSoToken, param.Body.ChannelId);
            ResponseResult<ResponseBase> response = new ResponseResult<ResponseBase>();
            ResponseBase responseBody = new ResponseBase();
            ResponseCode responseCode = ResponseStatusCode.Fail;

            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                var deposit = PaymentDepositManager.Instance.GetPaymentById(userInfo.AccountID, param.Body.TransactionNumber);
                if (deposit.paymentDepositStatus.Equals(PaymentEnum.PaymentDepositStatus.Pending))
                {
                    //MemberEntity memberEntity = MemberManager.Instance.GetMemberById(userInfo.UserID);
                    responseBody.Result = BankingManager.CancelDeposit(userInfo.AccountID, param.Body.TransactionNumber, (PaymentEnum.PaymentType)param.Body.PaymentType, (PaymentEnum.PaymentDepositStatus)param.Body.TransactionStatus);

                    if (responseBody.Result)
                    {
                        PaymentLogger.Info(string.Format("[CancelDeposit] MemberName : [{0}] ReqParam : [{1}]", userInfo.LoginName, JsonConvert.SerializeObject(param.Body)));
                        responseCode = ResponseStatusCode.Success;
                    }
                }
                else if (deposit.paymentDepositStatus.Equals(PaymentEnum.PaymentDepositStatus.Successful))
                {
                    responseCode = ResponseStatusCode.DepositSucceeded;
                }
                else if (deposit.paymentDepositStatus.Equals(PaymentEnum.PaymentDepositStatus.Failed))
                {
                    responseCode = ResponseStatusCode.DepositFailed;
                }
                else
                {
                    PaymentLogger.Info(string.Format("[CancelDeposit] MemberName : [{0}] TransNo : [{1}] Deposit Status : [{2}]", userInfo.LoginName, param.Body.TransactionNumber, deposit.paymentDepositStatus));
                    responseCode = ResponseStatusCode.Fail;
                }

                response.SetByResponseCode(responseBody, responseCode, param.Body.ChannelId, param.Body.TimeZone);
            }

            return response;
        }

        /// <summary>
        /// Download Receipt Image
        /// </summary>
        /// <remarks>
        /// - Download Receipt Image
        /// originalName : string, get from endpoint /Submit
        /// fileName  : string, get from endpoint /GetProcessingDeposit
        /// ssotoken  : string, retrieve once success login, refer to /memberloginwithpassword OR /memberloginwithotp
        /// </remarks>
        /// <returns></returns>
        [HttpGet]
        [Route("GetImageFile")]
        public HttpResponseMessage GetImageFile(string fileName, string originalName)
        {
            HttpResponseMessage result = new HttpResponseMessage();

            PaymentReceiptLogger.Info(string.Format("[GetImageFile] - GetFile, Content : [{0}]", JsonConvert.SerializeObject(new { fileName, originalName })));

            string attachmentPath = AppConfigManager.SystemSetting.UploadReceiptPath;

            try
            {
                byte[] byteString = null;
                byteString = Manager.Common.FileManager.FileManagerHelper.ReadFileData(attachmentPath, fileName);

                if (byteString != null)
                {
                    var stream = new MemoryStream(byteString);
                    // processing the stream.

                    result = new HttpResponseMessage(HttpStatusCode.OK)
                    {
                        Content = new ByteArrayContent(stream.ToArray())
                    };
                    result.Content.Headers.ContentDisposition =
                        new System.Net.Http.Headers.ContentDispositionHeaderValue(System.Net.Mime.DispositionTypeNames.Inline)
                        {
                            FileName = originalName
                        };

                    result.Content.Headers.ContentType = new MediaTypeHeaderValue(getMIME_TypesByFileName(fileName));

                    return result;
                }
                else
                {
                    PaymentReceiptLogger.Error(string.Format("[GetImageFile][ERROR] - Content No Found, DirectoryName :[{0}], Content : [{1}]", attachmentPath ?? string.Empty, JsonConvert.SerializeObject(new { fileName, originalName })));

                    result = Request.CreateResponse(HttpStatusCode.NoContent);
                }
            }
            catch (Exception ex)
            {
                PaymentReceiptLogger.Error(string.Format("[GetImageFile][ERROR] - Fail to Get File , DirectoryName :[{0}] Content : [{1}]", attachmentPath ?? string.Empty, JsonConvert.SerializeObject(new { fileName, originalName })), ex);
                result = Request.CreateResponse(HttpStatusCode.InternalServerError);
            }

            PaymentReceiptLogger.InfoFormat("[GetImageFile] - Result StatusCode [{0}] - DirectoryName: {1}, FileName: {2}", result.StatusCode, attachmentPath ?? string.Empty, fileName);

            return result;
        }

        #region Private

        private bool IsAbleToCancelDepositTransaction(PaymentEnum.PaymentDepositStatus status)
        {
            switch (status)
            {
                case PaymentEnum.PaymentDepositStatus.Pending:
                    return true;
                case PaymentEnum.PaymentDepositStatus.NA:
                case PaymentEnum.PaymentDepositStatus.Processed:
                case PaymentEnum.PaymentDepositStatus.Failed:
                case PaymentEnum.PaymentDepositStatus.Successful:
                case PaymentEnum.PaymentDepositStatus.ReadyToSubmitNLBT:
                case PaymentEnum.PaymentDepositStatus.SubmittedToNLBT:
                case PaymentEnum.PaymentDepositStatus.NLBTReviewed:
                case PaymentEnum.PaymentDepositStatus.SuccessfulPendingWallet:
                case PaymentEnum.PaymentDepositStatus.Reviewed:
                case PaymentEnum.PaymentDepositStatus.Cancelled:
                default:
                    return false;
            }
        }

        private List<MemberBankAccountEntityViewModel> getMemberBankAccountList(List<BankAccountMemberEntity> memberBankAccountList, List<PaymentTypeWithBankEntity> supportedBankList, int memberID, int accountID)
        {
            List<MemberBankAccountEntityViewModel> MemberBankAccountData = new List<MemberBankAccountEntityViewModel>();

            var memberActiveBankAccList = memberBankAccountList.Where(x => x.bankAccountMemberStatus.Equals(BankAccountEnum.BankAccountMemberStatus.Active)).ToList();
            var autoFillUpBankInfo = BankingManager.GetAutoFillUpMemberBankAccountInfo(memberID, accountID, transactionType);

            if (supportedBankList.Count > 0 && memberActiveBankAccList.Count > 0)
            {
                foreach (var item in memberActiveBankAccList)
                {
                    foreach (var bank in supportedBankList)
                    {
                        if (item.bankID == bank.BankID)
                        {
                            var bankAccount = new MemberBankAccountEntityViewModel()
                            {
                                BankAccountNumber = item.memberBankAccountID.ToString(), //use bank account id instead of real bankcard number
                                BankAccountName = item.bankAccountName,
                                BankID = bank.BankID,
                                BankCode = bank.BankCode,
                                BankAccountNumberDisplay = bank.Currency.ToUpper().Equals("USDT") ? item.bankAccountNo : PaymentHelper.BankAccountNumberMasking(item.bankAccountNo),
                                BankName = bank.BankName,
                                BankIconName = item.BankImageName,
                                BankIconPath = getBankIconPath(item.BankImage, item.BankImageName),
                                IsMaintain = bank.IsBankMaintain,
                                IsSelectedBank = item.bankAccountNo.Equals(autoFillUpBankInfo.bankAccountNo) ? true : false
                            };

                            MemberBankAccountData.Add(bankAccount);

                            break;
                        }
                    }
                }
            }

            if (MemberBankAccountData.Count > 0 && !MemberBankAccountData.Any(x => x.IsSelectedBank))
                MemberBankAccountData.First().IsSelectedBank = true;

            return MemberBankAccountData;
        }

        private ResponseCode submitDepositValidationCheck(SubmitDepositRequestModel req, MemberEntity memberEntity)
        {
            ResponseCode errorMessage = null;

            var paymentOptionMaintainInfo = PaymentSettingManager.Instance.GetPaymentOptionMaintenanceByPaymentOptionID(req.PaymentOptionID);
            List<PaymentTypeWithBankEntity> paymentTypeWithBankList = PaymentManagerBLL.GetPaymentTypeWithSupportBanksByPaymentOption(memberEntity.memberId, (PaymentEnum.PaymentOption)req.PaymentOptionID, transactionType, _manager.Configuration.WhiteBlackListEnabled);
            var memberBankAcc = BankAccountManager.Instance.GetBankAccountMemberData(memberEntity.memberId).Where(x => x.bankAccountNo.Equals(req.MemberBankAccountNo)).SingleOrDefault();

            bool POIsMaintain = paymentOptionMaintainInfo.recurringList.Where(x => x.Status).Count() > 0 && (DateTime.UtcNow.AddHours(ServerTimeZone) >= paymentOptionMaintainInfo.ActiveStartDate && DateTime.UtcNow.AddHours(ServerTimeZone) <= paymentOptionMaintainInfo.ActiveEndDate);
            bool isMaintain = POIsMaintain || PaymentHelper.IsPaymentTypeUnderPaymentOptionInMaintenance((PaymentEnum.PaymentOption)req.PaymentOptionID, paymentTypeWithBankList, memberBankAcc == null ? new List<BankAccountMemberEntity>() : new List<BankAccountMemberEntity>() { memberBankAcc }, out DateTime? maintenanceDate);

            //Check Processing Deposit
            if (BankingManager.CheckIsPendingDeposit(memberEntity.memberAccount.accountId))
            {
                return errorMessage = ResponseStatusCode.DepositInProcessing;
            }

            //Check Bank Account Info
            if (isMemberBankAccountInfoRequired((PaymentEnum.PaymentOption)req.PaymentOptionID) && string.IsNullOrEmpty(req.MemberBankAccountNo))
            {             
                //Check Bank Acc Status
                if (memberBankAcc == null || !memberBankAcc.bankAccountMemberStatus.Equals(BankAccountEnum.BankAccountMemberStatus.Active))
                {
                    PaymentLogger.InfoFormat("[SubmitDeposit] Member Bank Account Invalid Status, MemberCode - [{0}] Bank Account Number : [{1}]", memberEntity.memberName, req.MemberBankAccountNo);
                    return errorMessage = ResponseStatusCode.DepositError;
                }

                //Set PT by Member Bank Account For Check Amount
                paymentTypeWithBankList = paymentTypeWithBankList.Where(x => x.BankID.Equals(memberBankAcc.bankID)).ToList();
            }

            //Check Amount
            List<PaymentTypeGatewaySettingEntity> paymentTypeGatewaySettingList = PaymentManagerBLL.GetPaymentTypeGatewaySettingList(paymentTypeWithBankList.Where(x => x.Currency.Equals(memberEntity.currencyCode)).Select(x => x.PaymentTypeGatewaySettingID).Distinct().ToList()).ToList();
            List<PaymentTypeGatewaySettingEntity> rangeAmountPTs = paymentTypeGatewaySettingList.Where(x => x.IsAnyAmount).ToList();
            List<PaymentTypeGatewaySettingEntity> fixedAmountPTs = paymentTypeGatewaySettingList.Where(x => x.IsFixedAmount).ToList();
            List<decimal> coinValue = new List<decimal>();
            foreach (var coinValueString in fixedAmountPTs.Select(x => x.CoinValue))
                coinValue.AddRange(coinValueString.Split(',').Select(x => Convert.ToDecimal(x)).ToList());

            if (rangeAmountPTs.Count > 0 && (req.Amount < DecimalUtil.RoundTwoDecimal(paymentTypeWithBankList.OrderBy(x => x.MinAmount).First().MinAmount).ToDecimalByEnGB() || req.Amount > DecimalUtil.RoundTwoDecimal(paymentTypeWithBankList.OrderByDescending(x => x.MaxAmount).First().MaxAmount).ToDecimalByEnGB()))
            {
                return errorMessage = ResponseStatusCode.DepositAmountNotInRange;
            }
            else if (rangeAmountPTs.Count <= 0 && fixedAmountPTs.Count > 0 && !coinValue.Contains(req.Amount))
            {
                return errorMessage = ResponseStatusCode.DepositAmountNotInRange;
            }
            else if (rangeAmountPTs.Count <= 0 && fixedAmountPTs.Count <= 0)
            {
                PaymentLogger.Error(string.Format("[SubmitDeposit] MemberName : [{0}] Request Not Support Range And Fixed Amount, ReqParam : [{1}]", memberEntity.memberName, JsonConvert.SerializeObject(req)));
                return errorMessage = ResponseStatusCode.DepositError;
            }

            //Check Deposit Count and Amount Limit
            var limitSetting = PaymentManagerBLL.GetMemberPaymentLimitByPaymentOptionID(memberEntity.memberId, (PaymentEnum.PaymentOption)req.PaymentOptionID, memberEntity.currencyCode, transactionType);
            if (isReachPOCount(limitSetting) || isReachOverallCount(limitSetting))
            {
                return errorMessage = ResponseStatusCode.DepositDailyLimitCount;
            }

            if (isReachOverallLimit(limitSetting, req.Amount, false) || isReachOverallLimit(limitSetting, 0, true))
            {
                return errorMessage = ResponseStatusCode.DepositDailyLimitAmount;
            }

            if (isReachPODailyLimit(limitSetting, req.Amount, false) || isReachPODailyLimit(limitSetting, 0, true))
            {
                return errorMessage = ResponseStatusCode.DepositPODailyLimitAmount;
            }

            //Update Profile
            if (string.IsNullOrEmpty(memberEntity.givenName))
            {
                PaymentLogger.Error(string.Format("[SubmitDeposit] MemberName : [{0}] Member Profile Still Invalid, Content : [{1}]", memberEntity.memberName, JsonConvert.SerializeObject(new { memberEntity.givenName })));
                return errorMessage = ResponseStatusCode.FullNameIncomplete;
            }

            //Check Member Status
            if (memberEntity.memberStatus.Equals(MemberEnum.MemberStatus.Suspended))
            {
                return errorMessage = ResponseStatusCode.InvalidMemberStatusForDeposit;
            }

            //Check PO is Maintain
            if (isMaintain)
            {
                PaymentLogger.Error(string.Format("[SubmitDeposit] MemberName : [{0}] PO in Maintain, ReqParam : [{1}]", memberEntity.memberName, JsonConvert.SerializeObject(req)));
                return errorMessage = ResponseStatusCode.PONotAvailable;
            }

            return errorMessage;
        }

        private string constructRedirectUrl(PaymentEnum.PaymentType paymentType, PaymentEnum.PaymentOption paymentOption, string transactionNo)
        {
            PaymentTypeGatewaySettingEntity paymentSetting = PaymentSettingCacheManager.GetPaymentTypeGatewaySetting(paymentType, (int)paymentOption);

            string proxyUrl = paymentSetting.proxyDepositURL;

            #region Calling PaymentGateWay

            if (!string.IsNullOrEmpty(proxyUrl))
            {
                Uri url = HttpContext.Current.Request.Url;
                PaymentLogger.Info($"[{paymentType} BASE URL] - [{JsonConvert.SerializeObject(url)}]");
                string responseURL = url.Scheme + "://" + url.Authority + url.Segments[0] + url.Segments[1] +
                                     "Deposit/GenericSuccessful/" + transactionNo;
                string failURL = url.Scheme + "://" + url.Authority + url.Segments[0] + url.Segments[1] +
                                 "Deposit/GenericError/";
                proxyUrl = proxyUrl + "?transno=" + transactionNo + "&responseurl=" + responseURL +
                           "&failurl=" + failURL;
            }

            #endregion

            return proxyUrl;

        }

        private bool isMemberBankAccountInfoRequired(PaymentEnum.PaymentOption paymentOption)
        {
            return PaymentSettingCacheManager.GetPaymentOptionList(AppConfigManager.PartnerSetting.WebsiteId).Where(x => x.PaymentOptionID.Equals((int)paymentOption)).First().IsBankAccountInfoRequired;
        }

        private void BlackBoxService(string blackbox, string loginName, string ipAddress, GZSevenActionEnum gZSevenAction)
        {
            var task = Task.Run(() =>
            {
                if (Manager.GZSeven.Configuration.AppConfiguration.Instance.GZSevenConfig.IsGZOn && !string.IsNullOrEmpty(blackbox))
                {
                    Manager.GZSeven.Manager.GZSevenManager.Instance.CheckTransactionDetail(loginName, ipAddress, blackbox, gZSevenAction.ToString());
                }
            }).ConfigureAwait(false);
        }

        private object constructTransactionContent(PaymentDepositEntity depositEntity, MemberEntity memberEntity, string paymentOptionName, string timeZone)
        {
            object transactionContent = new object();

            if (memberEntity.currencyCode.Equals("USDT", StringComparison.InvariantCultureIgnoreCase))
            {
                var bank = BankingManager.GetBankById(depositEntity.bankId); //USDT Network

                transactionContent = new CryptoDepositTransactionViewModel() {
                    Amount = depositEntity.grossAmount,
                    DepositMethod = string.Format("{0}-{1}", paymentOptionName, bank.BankCode),
                    TransactionDate = depositEntity.dateCreated.AddHours(ServerTimeZone * -1).AddMinutes(DateUtil.ConvertTimeZoneToMinutes(timeZone)),
                    TransferProtocol = bank.BankCode,
                    TransactionNumber = depositEntity.transactionNo,
                    TransactionStatusID = (int)depositEntity.paymentDepositStatus,
                    PaymentType = (int)depositEntity.paymentType,

                    Currency = memberEntity.currencyCode,
                };
            }
            else
            {
                transactionContent = new BankDepositTransactionViewModel()
                {
                    Amount = depositEntity.grossAmount,
                    DepositMethod = paymentOptionName,
                    TransactionDate = depositEntity.dateCreated.AddHours(ServerTimeZone * -1).AddMinutes(DateUtil.ConvertTimeZoneToMinutes(timeZone)),
                    TransactionNumber = depositEntity.transactionNo,
                    TransactionStatusID = (int)depositEntity.paymentDepositStatus,
                    PaymentType = (int)depositEntity.paymentType,

                    Currency = memberEntity.currencyCode,
                };
            }

            return transactionContent;
        }

        private string getBankIconPath(byte[] icon, string iconName)
        {
            string path = Path.Combine(BankIconPath, icon != null && icon.Length > 0 && !string.IsNullOrEmpty(iconName) ? iconName : "default-bankicon.jpg");
            string version = BankingManager.GetBankIconVersionNumber();
            return path + "?v=" + version;

            //string cdnRoot = "/CDN/N8-API/";
            //string returnPath = cdnRoot + BankIconPath;
            //if (icon != null && icon.Length > 0 && !string.IsNullOrEmpty(iconName))
            //{
            //    try
            //    {
            //        string path = System.Web.Hosting.HostingEnvironment.MapPath(returnPath);

            //        string imagePath = Path.Combine(path, iconName);

            //        if (!Directory.Exists(path))
            //        {
            //            Directory.CreateDirectory(path);
            //        }

            //        FileStream fileStream = new FileStream(imagePath, FileMode.Create, FileAccess.ReadWrite);
            //        fileStream.Write(icon, 0, icon.Length);
            //        fileStream.Close();

            //        return returnPath + iconName;
            //    }
            //    catch
            //    {
            //        return returnPath + "default-bankicon.jpg";
            //    }
            //}
            //else return returnPath + "default-bankicon.jpg";
        }

        private string getPO_IconPath(byte[] icon, string iconName)
        {
            string path = Path.Combine(PO_IconPath, icon != null && icon.Length > 0 && !string.IsNullOrEmpty(iconName) ? iconName : "default-paymentgateway.jpg");
            string version = PaymentManagerBLL.GetPaymentOptionIconVersionNumber();
            return path + "?v=" + version;

            //string cdnRoot = "/CDN/N8-API/";
            //string returnPath = cdnRoot + PO_IconPath;
            //if (icon != null && icon.Length > 0 && !string.IsNullOrEmpty(iconName))
            //{
            //    try
            //    {
            //        string path = System.Web.Hosting.HostingEnvironment.MapPath(returnPath);

            //        string imagePath = Path.Combine(path, iconName);

            //        if (!Directory.Exists(path))
            //        {
            //            Directory.CreateDirectory(path);
            //        }

            //        FileStream fileStream = new FileStream(imagePath, FileMode.Create, FileAccess.ReadWrite);
            //        fileStream.Write(icon, 0, icon.Length);
            //        fileStream.Close();

            //        return returnPath + iconName;
            //    }
            //    catch
            //    {
            //        return returnPath + "default-paymentgateway.jpg";
            //    }
            //}
            //else return returnPath + "default-paymentgateway.jpg";
        }

        private string getBase64ContentForAttachment(string attachmentPath, string fileName)
        {
            byte[] byteString = null;
            string base64Content = string.Empty;

            try
            {
                byteString = Manager.Common.FileManager.FileManagerHelper.ReadFileData(attachmentPath, fileName);
                if (byteString != null)
                {
                    if (ImageUtility.IsValidImage(byteString))
                    {
                        base64Content = Convert.ToBase64String(ImageUtility.GetThumbnailImageByByteArray(byteString, fileName, 100));
                    }
                    else
                    {
                        base64Content = Convert.ToBase64String(byteString);
                    }
                }
                else
                {
                    PaymentReceiptLogger.Error(string.Format("[Get Attachment File][ERROR] - Content No Found, DirectoryName :[{0}], Content : [{1}]", attachmentPath ?? string.Empty, JsonConvert.SerializeObject(new { fileName })));
                }
            }
            catch (Exception ex)
            {
                PaymentReceiptLogger.Error(string.Format("[Get Attachment File][ERROR] - Fail to Get File , DirectoryName :[{0}] Content : [{1}]", attachmentPath ?? string.Empty, JsonConvert.SerializeObject(new { fileName })), ex);
            }

            return base64Content;
        }

        private string getMIME_TypesByFileName(string fileName)
        {
            fileName = fileName.Trim();
            var format = StringComparison.InvariantCultureIgnoreCase;

            #region Image

            if (fileName.EndsWith(".jpe", format) || fileName.EndsWith(".jpeg", format) || fileName.EndsWith(".jpg", format))
                return "image/jpeg";
            else if (fileName.EndsWith(".png", format))
                return "image/png";
            else if (fileName.EndsWith(".gif", format))
                return "image/gif";

            #endregion

            else
                return "application/octet-stream";
        }

        private byte[] getCompressImage(byte[] byteImageIn)
        {
            byte[] currentByteImageArray = byteImageIn;
            double scale = 1f;
            long targetByte = AppConfigManager.BankingSetting.ReceiptFileSize * 1000;

            if (!ImageUtility.IsValidImage(byteImageIn) || byteImageIn.Length <= targetByte)
            {
                return byteImageIn;
            }

            MemoryStream inputMemoryStream = new MemoryStream(byteImageIn);
            Image fullsizeImage = Image.FromStream(inputMemoryStream);

            while (currentByteImageArray.Length > targetByte)
            {
                Bitmap fullSizeBitmap = new Bitmap(fullsizeImage, new Size((int)(fullsizeImage.Width * scale), (int)(fullsizeImage.Height * scale)));
                MemoryStream resultStream = new MemoryStream();

                fullSizeBitmap.Save(resultStream, fullsizeImage.RawFormat);

                currentByteImageArray = resultStream.ToArray();
                resultStream.Dispose();
                resultStream.Close();

                scale -= 0.05f;
            }

            return currentByteImageArray;
        }

        private bool isReachPODailyLimit(MemberPaymentLimit paymentLimit, decimal depositAmount, bool caterEqual)
        {
            return caterEqual ? (paymentLimit.LimitAmount.HasValue && (paymentLimit.CurrentAmount + depositAmount) >= paymentLimit.LimitAmount.Value)
                : paymentLimit.LimitAmount.HasValue && (paymentLimit.CurrentAmount + depositAmount) > paymentLimit.LimitAmount.Value;
        }

        private bool isReachOverallLimit(MemberPaymentLimit paymentLimit, decimal depositAmount, bool caterEqual)
        {
            return caterEqual ? (paymentLimit.OverallAmountLimit.HasValue && (paymentLimit.CurrentOverallAmount + depositAmount) >= paymentLimit.OverallAmountLimit.Value)
                : (paymentLimit.OverallAmountLimit.HasValue && (paymentLimit.CurrentOverallAmount + depositAmount) > paymentLimit.OverallAmountLimit.Value);
        }

        private bool isReachPOCount(MemberPaymentLimit paymentLimit)
        {
            return paymentLimit.LimitCount.HasValue && paymentLimit.CurrentCount >= paymentLimit.LimitCount.Value;
        }

        private bool isReachOverallCount(MemberPaymentLimit paymentLimit)
        {
            return paymentLimit.OverallCountLimit.HasValue && paymentLimit.CurrentOverallCount >= paymentLimit.OverallCountLimit.Value;
        }

        private decimal? GetMinDecimal(params decimal?[] decimalArray)
        {
            decimal[] decimals = decimalArray.Where(x => x.HasValue).Select(y => y.Value).ToArray();
            return decimals.Count() > 0 ? (decimal?)decimals.Min() : (decimal?)null;
        }

        #endregion
    }

    
}