#region deposit
[HttpPost]
        [Route("MemberPODetails")]
        [SwitchCultureActionFilter]
        public ResponseResult<V2_MemberPODetailsResponseModel> MemberPODetails(RequestParam<MemberPODetailsRequestModel> param)
        {
            PaymentLogger.InfoFormat("[MemberPODetails] - SSOToken: [{0}], Channel: [{1}]", param.Body.SSoToken, param.Body.ChannelId);

            ResponseResult<V2_MemberPODetailsResponseModel> response = new ResponseResult<V2_MemberPODetailsResponseModel>();
            V2_MemberPODetailsResponseModel responseBody = new V2_MemberPODetailsResponseModel();
            ResponseCode responseCode = ResponseStatusCode.Success;
            SessionInfo userInfo = new SessionInfo();

            if (SSoTokenHelper.Instance.ValidateSsoToken(param.Body.SSoToken, out userInfo, response))
            {
                try
                {
                    int websiteID = AppConfigManager.PartnerSetting.WebsiteId;
                    //DateTime? maintenanceDate = null;

                    MemberEntity memberEntity = MemberManager.Instance.GetMemberById(userInfo.UserID);
                    bool isMemberBankInfoRequired = isMemberBankAccountInfoRequired((PaymentEnum.PaymentOption)param.Body.PaymentOptionID);
                    List<BankAccountMemberEntity> memberBankAccountNumberList = BankingManager.GetBankAccountMemberData(userInfo.UserID).ToList();
                    List<PaymentTypeWithBankEntity> paymentTypeWithBankList = PaymentManagerBLL.GetPaymentTypeWithSupportBanksByPaymentOption(userInfo.UserID, (PaymentEnum.PaymentOption)param.Body.PaymentOptionID, transactionType, _manager.Configuration.WhiteBlackListEnabled);
                    var paymentTypeFilterList = isMemberBankInfoRequired ? paymentTypeWithBankList.Where(x => memberBankAccountNumberList.Select(y => y.bankID).Distinct().Contains(x.BankID)).ToList() : paymentTypeWithBankList;
                    var paymentOptionMaintainInfo = PaymentSettingManager.Instance.GetPaymentOptionMaintenanceByPaymentOptionID(param.Body.PaymentOptionID);
                    var limitSetting = PaymentManagerBLL.GetMemberPaymentLimitByPaymentOptionID(userInfo.UserID, (PaymentEnum.PaymentOption)param.Body.PaymentOptionID, userInfo.CurrencyCode, transactionType);

                   // bool POIsMaintain = paymentOptionMaintainInfo.recurringList.Where(x => x.Status).Count() > 0 && (DateTime.UtcNow.AddHours(ServerTimeZone) >= paymentOptionMaintainInfo.ActiveStartDate && DateTime.UtcNow.AddHours(ServerTimeZone) <= paymentOptionMaintainInfo.ActiveEndDate);
                    //bool CheckingPO = false;
                    //bool POIsMaintain = false;
                    //bool checkRelativeInterval = false;

                    //foreach (var receipt in paymentOptionMaintainInfo.recurringList)
                    //{
                    //    // testmain = receipt.Status == true && (DateTime.UtcNow.AddHours(ServerTimeZone) >= receipt.ActiveStartDate && DateTime.UtcNow.AddHours(ServerTimeZone) <= receipt.ActiveEndDate);
                    //    CheckingPO = false;
                    //    checkRelativeInterval = false;
                    //    int DayofWeek;
                    //    if (receipt.Status == true)
                    //    {
                    //        if (receipt.FrequencyType != 4)
                    //        {
                    //            if (!string.IsNullOrWhiteSpace(receipt.FrequencyRelativeInterval))
                    //            {
                    //                DateTime today = DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT);
                    //                int day = today.Day;       // Current day of the month
                    //                int month = today.Month;   // Current month (numeric value)
                    //                int year = today.Year;     // Current year

                    //                DayOfWeek dayOfWeek = today.DayOfWeek;   // Current day of the week (enum value)
                    //                PaymentEnum.PaymentDayOfWeeks todayday;
                    //                if (Enum.TryParse<PaymentEnum.PaymentDayOfWeeks>(dayOfWeek.ToString(), out todayday))
                    //                {
                    //                    DayofWeek = (int)todayday;

                    //                    string frequencyIntervalStr = receipt.FrequencyRelativeInterval; // Assuming receipt.FrequencyRelativeInterval is of type string

                    //                    // Split the string by commas and convert each part to an integer
                    //                    List<int> intervals = frequencyIntervalStr.Split(',')
                    //                                                              .Select(str => int.Parse(str))
                    //                                                              .ToList();

                    //                    foreach (int number in intervals)
                    //                    {

                    //                        if (number == DayofWeek)
                    //                        {

                    //                            checkRelativeInterval = true;
                    //                        }
                    //                    }
                    //                }
                    //            }
                    //        }
                    //        else
                    //        {
                    //            DateTime today = DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT);
                    //            int day = today.Day;

                    //            string frequencyIntervalStr = receipt.FrequencyRelativeInterval; // Assuming receipt.FrequencyRelativeInterval is of type string

                    //            List<int> intervals = frequencyIntervalStr.Split(',')
                    //                      .Select(str => int.Parse(str))
                    //                      .ToList();

                    //            foreach (int number in intervals)
                    //            {

                    //                if (number == day)
                    //                {

                    //                    checkRelativeInterval = true;
                    //                }
                    //            }
                    //        }


                    //        if (receipt.FrequencyType == 1 && (DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) >= receipt.ActiveStartDate && DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) <= receipt.ActiveEndDate))
                    //        { CheckingPO = true; }
                    //        else if (receipt.FrequencyType == 2 && (DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) >= receipt.ActiveStartDate && DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) <= receipt.ActiveEndDate))
                    //        { CheckingPO = true; }
                    //        else if (receipt.FrequencyType == 3 && (DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) >= receipt.ActiveStartDate && DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) <= receipt.ActiveEndDate) && checkRelativeInterval == true)
                    //        { CheckingPO = true; }
                    //        else if (receipt.FrequencyType == 4 && (DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) >= receipt.ActiveStartDate && DateTime.UtcNow.AddHours(DateUtil.UserTimeZoneGMT) <= receipt.ActiveEndDate) && checkRelativeInterval == true)
                    //        { CheckingPO = true; }

                    //         if (CheckingPO == true)
                    //        {
                    //            responseBody.ErrorMessage = new MessageMaintenance()
                    //            {
                    //                Title = receipt.Title,
                    //                Content = receipt.Message,
                    //                Type = (int)PaymentEnum.MemberDPCategory.INFO
                    //            };
                    //        }
                    //        if (CheckingPO == true)
                    //        {
                    //            POIsMaintain = CheckingPO;
                    //        }
                    //    }
                    //};
                    //bool isMaintain = POIsMaintain || PaymentHelper.IsPaymentTypeUnderPaymentOptionInMaintenance((PaymentEnum.PaymentOption)param.Body.PaymentOptionID, paymentTypeFilterList, memberBankAccountNumberList, out maintenanceDate);

                    var isSupportRoutingRules = PaymentSettingCacheManager.GetPaymentOptionList(websiteID).Where(x => x.PaymentOptionID.Equals(param.Body.PaymentOptionID)).First().IsSupportRoutingRules;

                    responseBody.IsReachedDailyLimit = isReachPOCount(limitSetting);
                    responseBody.IsReachedOverallDailyLimit = isReachOverallCount(limitSetting);
                    responseBody.IsReachedPOAmountLimit = isReachPODailyLimit(limitSetting, 0, true);
                    responseBody.IsReachedOverallAmountLimit = isReachOverallLimit(limitSetting, 0, true);
                    responseBody.IsAbleAddNewBank = memberBankAccountNumberList.Where(x => !x.bankAccountMemberStatus.Equals(BankAccountEnum.BankAccountMemberStatus.Frozen)).ToList().Count < BankingManager.GetMemberBankAccountCountLimit(userInfo.UserID);
                    responseBody.IsMemberBankInfoNeeded = isMemberBankInfoRequired;
                    responseBody.PaymentOptionID = param.Body.PaymentOptionID;
                    responseBody.MemberBankAccountList = getMemberBankAccountList(memberBankAccountNumberList, paymentTypeFilterList, userInfo.UserID, userInfo.AccountID);
                    responseBody.MaxDepositDailyCount = limitSetting.LimitCount;
                    responseBody.TodayDepositRemainCount = limitSetting.LimitCount.HasValue ? ((limitSetting.LimitCount - limitSetting.CurrentCount) > 0 ? (limitSetting.LimitCount - limitSetting.CurrentCount) : 0) : (int?)null;
                    var memberActiveBankAccListForERCTRC = memberBankAccountNumberList.Where(x => x.bankAccountMemberStatus.Equals(BankAccountEnum.BankAccountMemberStatus.Active)).ToList();


                    if (isPOMaintain(param.Body.PaymentOptionID, out MessageMaintenance err))
                    {
                        responseBody.ErrorMessage = err;
                        responseCode = ResponseStatusCode.PONotAvailable;
                    }
                    else if (isMemberBankInfoRequired && memberEntity.currencyCode == CurrencyEnum.CurrencyCode.RMB.ToString() && responseBody.MemberBankAccountList.Count == 0)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_MemberAddNewBankCard_Msg", new CultureInfo(param.Body.LanguageCode)),
                            //Content = Text.ResourceManager.GetString("DP_MemberAddERCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositMemberAddBankCard; 

                    }
                    //TRC member need to add new ERC Bank Card
                    else if (isMemberBankInfoRequired && memberEntity.currencyCode ==CurrencyEnum.CurrencyCode.USDT.ToString() &&
                        memberActiveBankAccListForERCTRC.Where(x => x.bankName.Equals("TRC20")).ToList().Count > 0 && responseBody.MemberBankAccountList.Count == 0)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_MemberAddERCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                            //Content = Text.ResourceManager.GetString("DP_MemberAddERCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositMemberAddUSDTBankCard;

                    }
                    //ERC member need to add new TRC Bank Card  
                    else if (isMemberBankInfoRequired && memberEntity.currencyCode == CurrencyEnum.CurrencyCode.USDT.ToString() &&
                        memberActiveBankAccListForERCTRC.Where(x => x.bankName.Equals("ERC20")).ToList().Count > 0 && responseBody.MemberBankAccountList.Count == 0)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_MemberAddTRCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                            //Content = Text.ResourceManager.GetString("DP_MemberAddTRCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositMemberAddUSDTBankCard;

                    } 
                    else if (isMemberBankInfoRequired && memberEntity.currencyCode == CurrencyEnum.CurrencyCode.USDT.ToString() &&
                            memberActiveBankAccListForERCTRC.Count == 0 && responseBody.MemberBankAccountList.Count == 0) // Handle bank card(s) frozen scenario
                    {
                        if (paymentTypeFilterList.Count > 0)
                        {
                            if (paymentTypeFilterList.First().BankID == 1) // ERC
                            {
                                responseBody.ErrorMessage = new MessageMaintenance()
                                {
                                    Title = Text.ResourceManager.GetString("DP_MemberAddERCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                                    //Content = Text.ResourceManager.GetString("DP_MemberAddTRCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                                    Type = (int)PaymentEnum.MemberDPCategory.ERROR
                                };

                            }
                            else
                            {
                                responseBody.ErrorMessage = new MessageMaintenance()
                                {
                                    Title = Text.ResourceManager.GetString("DP_MemberAddTRCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                                    //Content = Text.ResourceManager.GetString("DP_MemberAddTRCBankList_Msg", new CultureInfo(param.Body.LanguageCode)),
                                    Type = (int)PaymentEnum.MemberDPCategory.ERROR
                                };
                            }
                            responseCode = ResponseStatusCode.DepositMemberAddUSDTBankCard;
                        }
                        else
                        {
                            responseCode = ResponseStatusCode.NoPOisAvailableForDeposit;
                        }


                    }
                    else if (responseBody.IsReachedOverallDailyLimit)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_DailyLimitCount_Title", new CultureInfo(param.Body.LanguageCode)),
                            Content = Text.ResourceManager.GetString("DP_DailyLimitCount_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositDailyLimitCount;
                    }
                    else if (responseBody.IsReachedDailyLimit)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_PODailyLimitCount_Title", new CultureInfo(param.Body.LanguageCode)),
                            Content = Text.ResourceManager.GetString("DP_PODailyLimitCount_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositPODailyLimitCount;
                    }
                    else if (responseBody.IsReachedOverallAmountLimit)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_DailyLimitAmount_Title", new CultureInfo(param.Body.LanguageCode)),
                            Content = Text.ResourceManager.GetString("DP_DailyLimitAmount_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositDailyLimitAmount;
                    }
                    else if (responseBody.IsReachedPOAmountLimit)
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_PODailyLimitAmount_Title", new CultureInfo(param.Body.LanguageCode)),
                            Content = Text.ResourceManager.GetString("DP_PODailyLimitAmount_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.ERROR
                        };
                        responseCode = ResponseStatusCode.DepositPODailyLimitAmount;
                    }
                    else if (BankingManager.CheckIsPendingDeposit(userInfo.AccountID)) //Check Processing Deposit 
                    {
                        responseBody.ErrorMessage = new MessageMaintenance()
                        {
                            Title = Text.ResourceManager.GetString("DP_Pending_Title",new CultureInfo(param.Body.LanguageCode)),
                            Content = Text.ResourceManager.GetString("DP_Pending_Msg", new CultureInfo(param.Body.LanguageCode)),
                            Type = (int)PaymentEnum.MemberDPCategory.NOTICE
                        };
                        responseCode = ResponseStatusCode.DepositInProcessing;
                    }
                    else if (paymentTypeWithBankList.Count > 0 || !isSupportRoutingRules)
                    {
                        
                        if (paymentTypeFilterList.Count > 0)
                        {
                            List<PaymentTypeGatewaySettingEntity> paymentTypeGatewaySettingList = PaymentManagerBLL.GetPaymentTypeGatewaySettingList(paymentTypeFilterList.Select(x => x.PaymentTypeGatewaySettingID).ToList()).Where(y => y.Currency.Equals(userInfo.CurrencyCode)).ToList();
                            decimal? poRemain = limitSetting.LimitAmount.HasValue ? limitSetting.LimitAmount.Value - limitSetting.CurrentAmount : (decimal?)null;
                            decimal? overallRemain = limitSetting.OverallAmountLimit.HasValue ? limitSetting.OverallAmountLimit.Value - limitSetting.CurrentOverallAmount : (decimal?)null;

                            decimal? remain = GetMinDecimal(overallRemain, poRemain);

                            decimal minRangeAmountWithinAllPT = 0; // use to check remain amount quota
                            decimal minCoinValueWithinAllPT = 0; // use to check remain amount quota

                            //if (remain == null)
                            //{
                            //    responseBody.RangeAmount = new RangeAmountModel();
                            //    responseBody.RangeAmount.MinAvailableAmount = 0;
                            //    responseBody.RangeAmount.MaxAvailableAmount = 0;
                            //}
                            List<PaymentTypeGatewaySettingEntity> rangeAmountPTs = paymentTypeGatewaySettingList.Where(x => x.IsAnyAmount).ToList();
                            if (rangeAmountPTs.Count > 0)
                            {
                                responseBody.RangeAmount = new RangeAmountModel();
                                responseBody.RangeAmount.MinAvailableAmount = DecimalUtil.RoundTwoDecimal(rangeAmountPTs.OrderBy(x => x.MinPerTransaction).First().MinPerTransaction).ToDecimalByEnGB();
                                responseBody.RangeAmount.MaxAvailableAmount = DecimalUtil.RoundTwoDecimal(rangeAmountPTs.OrderByDescending(x => x.MaxPerTransaction).First().MaxPerTransaction).ToDecimalByEnGB();

                                minRangeAmountWithinAllPT = responseBody.RangeAmount.MinAvailableAmount;

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

                                responseBody.FixAmount = new FixAmountModel() { FixAmountList = coinValueList.Distinct().OrderBy(x => x).ToList() };

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

                        // Get FTD or ReDeposit
                        List<int> statusList = new List<int>()
                        {
                            (int)PaymentEnum.PaymentDepositStatus.Pending,
                            (int)PaymentEnum.PaymentDepositStatus.Failed,
                            (int)PaymentEnum.PaymentDepositStatus.Cancelled,
                            (int)PaymentEnum.PaymentDepositStatus.Reviewed
                        };

                        List<PaymentDepositEntity> depositList = PaymentDepositManager.Instance.GetPaymentDepositProcessingList(userInfo.AccountID, statusList);
                        bool hasSuccessDP = depositList.Count() == 0 ? false : depositList.Select(x => x.paymentDepositStatus.Equals(PaymentEnum.PaymentDepositStatus.Successful)).Count() > 0 ? true : false;

                        var promotionAvailable = Manager.ModulePromotion.DepositPromotionRecommendation.DepositPromotionRecommendation.Instance.GetDepositPromotionRecommendationList(userInfo.CurrencyCode, hasSuccessDP);

                        if (promotionAvailable != null)
                        {
                            responseBody.AvailablePromotion = promotionAvailable.Select(x => new DepositPromotionRecommendationDetailEntityViewModel()
                            {
                                Amount = x.Amount,
                                Currency = x.Currency,
                                Content = x.Content,
                                FamilyID = x.FamilyID,
                                Title = x.Title,
                                IconPath = Enum.TryParse(x.Currency, out CurrencyEnum.CurrencyCode code) ? getPromoIconPath(code) : getPromoIconPath(null)
                            }).ToList();
                        }

                        responseCode = ResponseStatusCode.Success;
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

        [HttpPost]
        [Route("Submit")]
        public ResponseResult<V2_SubmitDepositResponseModel> Submit(RequestParam<SubmitDepositRequestModel> param)
        {
            ResponseResult<V2_SubmitDepositResponseModel> response = new ResponseResult<V2_SubmitDepositResponseModel>();
            V2_SubmitDepositResponseModel responseBody = new V2_SubmitDepositResponseModel();
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
                        responseBody.relativeRedirectUrl = !(string.IsNullOrEmpty(responseBody.RedirectUrl)) && Uri.IsWellFormedUriString(responseBody.RedirectUrl, UriKind.Absolute) 
                            ? new Uri(responseBody.RedirectUrl).PathAndQuery : string.Empty;
                        responseBody.TransactionContent = constructTransactionContent(deposit, memberEntity, param.Body.PaymentOptionName, param.Body.TimeZone, param.Body.MemberBankAccountNo);
                        responseBody.IsAbleToCancel = IsAbleToCancelDepositTransaction(deposit.paymentDepositStatus);
                        responseBody.IsPopUpProviderPage = paymentSetting.IsPopUpProviderPage;

                        responseCode = ResponseStatusCode.Success;
                    }
                    else if (!success && errorCode != null)
                    {
                        responseBody = new V2_SubmitDepositResponseModel()
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

                        responseBody = new V2_SubmitDepositResponseModel()
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
#endregion

        #region wihdrawal
        
        #endregion