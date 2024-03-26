DECLARE 
@ProxyURL as VARCHAR(50) = 'https://localhost:44325/',
@NotifyURL as VARCHAR(50) = 'http://localhost:60328/';
	
ALTER TABLE [dbo].[PaymentTypeGatewaySetting] DISABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;

UPDATE [dbo].[PaymentTypeGatewaySetting]
SET
	ProviderDepositURL		= @ProxyURL + 'api/v1/Payment/mmpaywithdrawalsubmission',
	ProxyNotifyUrl			= @NotifyURL + 'Common/NotifyWithdrawal/MMPay'
WHERE PaymentTypeGatewaySettingID = 1047;

ALTER TABLE [dbo].[PaymentTypeGatewaySetting] ENABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;


