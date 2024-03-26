--select TOP 3 * FROM Providers ORDER BY ProviderID DESC
--select TOP 3 * from ProviderBankCode ORDER BY ProviderBankCodeID DESC
-- SELECT * from PaymentType
-- select * from PaymentOptionRoutingRulesSetting where PaymentTypeGatewaySettingID=1011
-- select *  FROM PaymentTypeGatewaySetting WHERE PaymentTypeGatewaySettingID = 1103

-- select * from Currency
-- SELECT * FROM Member WHERE Member.MemberName = 'kcUserR01'
-- select * FROM MemberAccount WHERE MemberAccount.MemberID=21635
-- select  MemberBankAccountId, AccountID, BankAccountName, BankAccountNo, BankProvince, BankCity, BankBranch, BankID from BankAccountMember WHERE AccountID = 430167
-- select * from Bank where Bank.BankID = 12

-- select * from MemberAccount
-- select * from PaymentWithdrawal where PaymentTypeID = 37

--select *  from ProviderBankCode where ProviderBankCodeID=3226
--select * from Providers

-- select * from bank WHERE Bank.BankID = 61
-- select * from bank WHERE Bank.BankID = 198
-- select * from ProviderBankCodeMapping

-- select TOP 3 * FROM PaymentWithdrawal
-- select * from Bank where BankName = N'中信银行'
-- select * from PaymentTypeGatewaySupportBankSetting
-- select * from PaymentWithdrawal where PaymentTransactionNo = 'W2023092111180198'
-- INSERT INTO ProviderBankCodeMapping (ProviderBankCodeID, BankID)
-- SELECT a.ProviderBankCodeID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b
-- -- WHERE a.code = 'CNCB' and a.ProviderID = 38 AND b.BankCode = 'CITIC'
--  SELECT * from bank WHERE bankid=12
-- select * from Providers where ProviderID=38
-- select * from ProviderBankCode where providerid = 38 and Name=N'中信银行'
--  select *  from ProviderBankCodeMapping where bankid=12 and ProviderBankCodeID=3128
-- SELECT * from BankAccount
-- select * from PaymentWithdrawal where AccountID='430642'
-- select * from patym
-- select * from PaymentTypeGatewaySecureKey




DECLARE @accountId INT ;
DECLARE @payoutTransNo NVARCHAR(MAX);  

SET @accountId = 0     ;  
SET @payoutTransNo = 'WASCN2309229848231';
SELECT t1.*
FROM dbo.fn_tbl_PaymentWithdrawal() t1
WHERE t1.AccountID = CASE WHEN @accountId = 0 THEN t1.AccountID ELSE @accountId END 
AND t1.PayoutTransactionNo = @payoutTransNo;