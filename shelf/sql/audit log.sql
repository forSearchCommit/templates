select top 10 * FROM AuditLogBankAccountMember order BY AuditLogID DESC
select top 1 * FROM LogAction where ActionID = 5000
SELECT top 1 * from ModuleType where ModuleTypeID = 28
-- select * from AuditLogTypeID = Null
-- NewValue = Active/Inactive


SELECT * from AuditLogAttribute where AuditLogAttributeID = 5048 
select top 1 * from BankAccountMember order by MemberBankAccountID DESC 
-- or AuditLogAttributeID = 5050
-- SELECT * from BankAccountMember where MemberBankAccountID = 2100
-- SELECT * from AuditLogAttributeDetail

-- param = newvalue oldvalue datecreated referenceno usercreated

-- DECLARE 
-- 	@PaymentTypeId INT = 47,					-- select max(PaymentTypeId) from [PaymentType] where PaymentTypeID < 999
-- 	@ProviderID INT = 38,						-- select max(ProviderID) from Providers 
-- 	@PaymentTypeGatewaySettingID INT = 1047,	-- follow PaymentType ID 1XXX
-- 	@PaymentOptionID INT = 9,					
-- 	@PaymentOptionTypeID INT = 8,
-- 	@TransactionPrefix VARCHAR(50) = 'WASCN',
-- 	@ProviderName NVARCHAR(50) = N'AnShengPay',
-- 	@PaymentTypeDesc NVARCHAR (50) = N'AnSheng-Withdrawal',
-- 	@currencyCode NVARCHAR (10) = N'RMB',
-- 	@userCreated NVARCHAR (10) = N'N8PAY-91';

SELECT * from providers





