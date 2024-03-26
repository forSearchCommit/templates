use GCT_P003

DECLARE 
	@ProviderID INT = 0,
	@PaymentOptionTypeID INT = 17,
	@PaymentOptionID INT = 19,
	@PaymentTypeID INT = 48,
	@PaymentTypeGatewaySettingID INT = 1048, -- follow PaymentType ID 1XXX
	@ProxyURL as VARCHAR(50) = 'http://172.25.14.33:800/', 
	@TransactionPrefix VARCHAR(50) = 'DVIP';

	
IF (NOT EXISTS(SELECT 1 FROM [dbo].[Providers] WITH (NOLOCK) WHERE ProviderID = @ProviderID))
BEGIN
	INSERT INTO [dbo].[Providers] (ProviderID, ProviderName, [Description], IsRequiredBankCodeMapping) 
	VALUES (@ProviderID, N'MMPay', N'MMPay', 1); 
END

INSERT INTO [dbo].[PaymentType] (PaymentTypeID, Name, [Description], ProviderID, IsAutoReviewWithdrawal, IsRequiredBankCodeMapping) 
VALUES (@PaymentTypeID, N'VIP-OBT', N'VIP-OBT', @ProviderID, 0, 1); 


ALTER TABLE [dbo].[PaymentTypeGatewaySetting] DISABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;
INSERT INTO [dbo].[PaymentTypeGatewaySetting]
(
    PaymentTypeGatewaySettingID, PaymentTypeID, PaymentOptionID, TransactionPrefix, MerchantID,
    ProviderDepositURL, ProxyDepositURL, ProxyNotifyURL, ProxyRedirectURL,
    DateCreated, UserCreated, DateUpdated, UserUpdated, InternalAuditID,
    TransRejectInterval, IsAutoRejectActivated, SecureKey2,
    SecureKey3, MerchantAccountNo , Status, MinPerTransaction , MaxPerTransaction
	,Currency
)
VALUES
(
    @PaymentTypeGatewaySettingID, @PaymentTypeId, @PaymentOptionID, @TransactionPrefix, N'',
    N'', @ProxyURL + 'Common/SubmitDepositThenHandle.aspx', @ProxyURL + 'Common/NotifyDeposit/MMPay', @ProxyURL + 'Common/ResponseDeposit/MMPay',
    GETDATE(), N'BP-135', GETDATE(), N'BP-135', 0,
    0, 0, null,
    NULL, NULL , 1,0,0
	,'RMB'
);
ALTER TABLE [dbo].[PaymentTypeGatewaySetting] ENABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;


--INSERT INTO [dbo].[PaymentTransactionDetailMap]
--(
--    PaymentTransactionDetailMapID, PaymentTypeID, PaymentTransactionDetailAttributeID, TransactionTypeID
--)
--VALUES
--(990768, @PaymentTypeId, 1, 3010),
--(990769, @PaymentTypeId, 2, 3010),
--(990770, @PaymentTypeId, 5, 3010),
--(990771, @PaymentTypeId, 18, 3010);
 

INSERT INTO [dbo].[PaymentTypeControlStatus]
(
    [PaymentTypeControlStatus], [PaymentOptionTypeID], [PaymentTypeID], [PaymentOptionID], [TransactionTypeID]
)
VALUES
(
    1, @PaymentOptionTypeID, @PaymentTypeId, @PaymentOptionID, 3010
);


INSERT INTO PaymentOptionRoutingRulesSetting
(
	PaymentTypeGatewaySettingID, CurrencyCode, DailyVolume, MonthlyVolume, AmountRangeFrom,
	AmountRangeTo, [Status], DateCreated, UserCreated
)
VALUES 
(
	@PaymentTypeGatewaySettingID, 'RMB', 0, 0, 0, 
	0, 0, GETDATE(), 'BP-135'
);