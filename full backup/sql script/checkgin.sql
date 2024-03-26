select * from PaymentTypeGatewaySetting
-- select * from Member where membername = 'kcUserR01'
-- select * from PaymentOption where PaymentOptionTypeID = 14
-- select * from paymentoptiontype
-- SELECT * from Providers
-- select * from paymenttype
-- select * from PaymentTypeGatewaySecureKey

-- select * from PaymentDeposit where PaymentTypeID=39 and bankid = 12

-- select * from PaymentDepositDetail where PaymentTransactionNo='DFTUPCN2310011048683'

-- select * from PaymentDeposit where PaymentTransactionNo='DFTUPCN2310011048683'


-- select * from


-- =============================================

-- DECLARE @accountId INTEGER
-- Set @accountId = 430167

-- SELECT t1.*, ISNULL (T1.BankName,'''') COLLATE DATABASE_DEFAULT AS DepositDetails --WCR-663
-- FROM dbo.fn_tbl_PaymentDeposit() t1
-- WHERE t1.AccountID = CASE WHEN @accountId = 0 THEN t1.AccountID ELSE @accountId END
-- AND t1.PaymentTransactionNo = 'DFTUPCN2310026562116';

select * from ProviderBankCodeMapping where bankid = 73
SELECT * From bank where bankid = 73