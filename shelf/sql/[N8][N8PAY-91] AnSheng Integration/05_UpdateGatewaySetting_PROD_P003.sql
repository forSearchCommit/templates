DECLARE 
@ProxyURL as VARCHAR(50) = 'https://pay.n8pg01.org/',
@NotifyURL as VARCHAR(50) = 'https://ppay.n8pg01.org/';
	
ALTER TABLE [dbo].[PaymentTypeGatewaySetting] DISABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;

UPDATE [dbo].[PaymentTypeGatewaySetting]
SET
    MerchantID				= '80001', 
	ProviderDepositURL		= 'http://api3852.888mail.co/hpay/wd/ct',
	ProxyNotifyUrl			= @ProxyURL + 'Common/NotifyWithdrawal/AnShengPay',
	DateUpdated             = GETDATE(),
	PaymentGatewayServerIP	= '52.196.100.53',
	MinPerTransaction		= '2000',
	MaxPerTransaction		= '5000'
WHERE PaymentTypeGatewaySettingID = 1103;

ALTER TABLE [dbo].[PaymentTypeGatewaySetting] ENABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;

