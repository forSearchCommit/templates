-- MMPay  WITHDRAWAL
USE GCT_P003

DECLARE 
	@PaymentTypeId INT = 47,
	@ProviderID INT = 0,					
	@PaymentTypeGatewaySettingID INT = 1047,	-- follow PaymentType ID 1XXX
	@PaymentOptionID INT = 18,					-- Bank Transfer
	@PaymentOptionTypeID INT = 16,
	@TransactionPrefix VARCHAR(50) = 'WMMA';

-- Providers
IF (NOT EXISTS(SELECT 1 FROM [dbo].[Providers] WITH (NOLOCK) WHERE ProviderID = @ProviderID))
BEGIN
	INSERT INTO [dbo].[Providers] (ProviderID, ProviderName, [Description], IsRequiredBankCodeMapping) 
	VALUES (@ProviderID, N'MMPay', N'MMPay', 1); 
END

-- PaymentType
IF (NOT EXISTS (SELECT * FROM [PaymentType] WHERE [PaymentTypeID] = @PaymentTypeID))
BEGIN
	INSERT INTO [dbo].[PaymentType] (PaymentTypeID, Name, [Description], ProviderID, IsAutoReviewWithdrawal, IsRequiredBankCodeMapping) 
		VALUES (@PaymentTypeID, N'MMPay-WD A', N'MMPay-WD A', @ProviderID, 1, 1); 
END


ALTER TABLE [dbo].[PaymentTypeGatewaySetting] DISABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;
INSERT INTO [dbo].[PaymentTypeGatewaySetting]
(
    PaymentTypeGatewaySettingID, PaymentTypeID, PaymentOptionID, TransactionPrefix, MerchantID,
    ProviderDepositURL, ProxyDepositURL, ProxyNotifyURL, ProxyRedirectURL,
    DateCreated, UserCreated, DateUpdated, UserUpdated, InternalAuditID,
    TransRejectInterval, IsAutoRejectActivated, MerchantAccountNo, Status, MinPerTransaction , MaxPerTransaction,Currency
)
VALUES
(
    @PaymentTypeGatewaySettingID, @PaymentTypeId, @PaymentOptionID, @TransactionPrefix, '',
    '', N'', N'', N'', 
    GETDATE(), N'BP-136', GETDATE(), N'BP-136', 0,
    0, 0, '', 1,0,0,'RMB'
);
ALTER TABLE [dbo].[PaymentTypeGatewaySetting] ENABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;

INSERT INTO [dbo].[PaymentTypeControlStatus]
(
    [PaymentTypeControlStatus], [PaymentOptionTypeID], [PaymentTypeID], [PaymentOptionID], [TransactionTypeID]
)
VALUES
(
    1, @PaymentOptionTypeID, @PaymentTypeId, @PaymentOptionID, 3020
);


IF (NOT EXISTS (SELECT * FROM [PaymentOptionRoutingRulesSetting] WITH(NOLOCK) WHERE [PaymentTypeGatewaySettingID] = @PaymentTypeGatewaySettingID))
BEGIN
	INSERT INTO PaymentOptionRoutingRulesSetting
	(
		PaymentTypeGatewaySettingID, CurrencyCode, DailyVolume, MonthlyVolume, AmountRangeFrom,
		AmountRangeTo, [Status], DateCreated, UserCreated
	)
	VALUES (@PaymentTypeGatewaySettingID, 'RMB', 0, 0, 0, 0, 1, GETDATE(), 'BP-136');
END