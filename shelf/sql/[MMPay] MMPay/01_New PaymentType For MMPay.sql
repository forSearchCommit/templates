USE GCT_P003
GO 

DECLARE @PaymentTypeId INT = 999, -- MMPay
		@PaymentTypeGatewaySettingID INT = 999,
		@PaymentOptionID INT = 999, --MMPay
		@PaymentOptionTypeID INT = 999 --MMPay

INSERT INTO PaymentOptionType (PaymentOptionTypeID, PaymentOptionType, [Description])
VALUES (@PaymentOptionTypeID, N'MMPay', N'Affiliate MMPay Deposit');

INSERT INTO PaymentOption (PaymentOptionID, PaymentOptionTypeID, TransactionTypeID, WebsiteID,	DateCreated, UserCreated, IsSupportRoutingRules, IsRecommended, [Status])
VALUES (@PaymentOptionID, @PaymentOptionTypeID, 3010, 2, GETDATE(), 'N8 StartUp', 0, 0, 0);

INSERT INTO dbo.PaymentType (PaymentTypeID, Name, Description, ProviderID, IsAutoReviewWithdrawal, IsRequiredBankCodeMapping) VALUES (@PaymentTypeId,'MMPay','MMPay', 0, 0, 0);

ALTER TABLE [dbo].[PaymentTypeGatewaySetting] DISABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;
INSERT INTO [dbo].[PaymentTypeGatewaySetting]
(
    PaymentTypeGatewaySettingID, PaymentTypeID, PaymentOptionID, TransactionPrefix, MerchantID,
    SecureKey, ProviderDepositURL, ProxyDepositURL, ProxyNotifyURL, ProxyRedirectURL,
    DateCreated, UserCreated, DateUpdated, UserUpdated, InternalAuditID,
    TransRejectInterval, IsAutoRejectActivated, SecureKey2,
    SecureKey3, MerchantAccountNo, Currency
)
VALUES
(
    @PaymentTypeGatewaySettingID, @PaymentTypeId, @PaymentOptionID, 'DMMP', '',
    'Hj2b5@D9', N'', '', '', '',
    GETDATE(), N'MMPay', GETDATE(), N'MMPay', 0,
    0, 0, 'Dms2hJ1d04nD',
    '', '', NULL
);
ALTER TABLE [dbo].[PaymentTypeGatewaySetting] ENABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;