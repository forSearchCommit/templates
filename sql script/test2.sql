DECLARE
@Provider INT = 38, 
@PaymentTypeGatewaySettingID INT = 1103

SELECT * FROM ProviderBankCode a 
CROSS JOIN Bank b
WHERE a.code ='TACCB'
and a.ProviderID = @Provider 
AND b.BankCode ='TACCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) 
WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)


INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID 
FROM ProviderBankCode a 
CROSS JOIN Bank b 
WHERE a.code = 'TACCB' 
and a.ProviderID = @Provider 
AND b.BankCode ='TACCB'