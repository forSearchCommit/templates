DECLARE @accountId INTEGER
Set @accountId = 430167

SELECT t1.*, ISNULL (T1.BankName,'''') COLLATE DATABASE_DEFAULT AS DepositDetails --WCR-663
FROM dbo.fn_tbl_PaymentDeposit() t1
WHERE t1.AccountID = CASE WHEN @accountId = 0 THEN t1.AccountID ELSE @accountId END
AND t1.PaymentTransactionNo = 'DFTUPCN2310026562116';