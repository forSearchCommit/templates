-- AnSheng WITHDRAWAL (AnSheng-Withdrawal)
USE GCT_P003

DECLARE 
	@PaymentTypeId INT = 47,					-- select max(PaymentTypeId) from [PaymentType] where PaymentTypeID < 999
	@ProviderID INT = 38,						-- select max(ProviderID) from Providers 
	@PaymentTypeGatewaySettingID INT = 1047,	-- follow PaymentType ID 1XXX
	@PaymentOptionID INT = 9,					
	@PaymentOptionTypeID INT = 8,
	@TransactionPrefix VARCHAR(50) = 'WASCN',
	@ProviderName NVARCHAR(50) = N'AnShengPay',
	@PaymentTypeDesc NVARCHAR (50) = N'AnSheng-Withdrawal',
	@currencyCode NVARCHAR (10) = N'RMB',
	@userCreated NVARCHAR (10) = N'N8PAY-91';

-- Providers 
IF (NOT EXISTS(SELECT 1 FROM [dbo].[Providers] WITH (NOLOCK) WHERE ProviderID = @ProviderID))
	BEGIN
		INSERT INTO [dbo].[Providers] (ProviderID, ProviderName, [Description], IsRequiredBankCodeMapping) 
		VALUES (@ProviderID, @ProviderName, @ProviderName, 1); 
	END
ELSE
	BEGIN
		PRINT 'Providers Exists'
	END


