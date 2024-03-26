-- SELECT t1.*
-- FROM dbo.fn_tbl_PaymentWithdrawal_new('430167', null,null,3) t1
-- WHERE t1.PaymentTransactionNo = 'W2023092195113311';
-- SELECT t1.*
-- 		FROM dbo.fn_tbl_PaymentWithdrawal_new('430167', null,null,3) t1
-- 		WHERE t1.PayoutTransactionNo = 'WASCN2309245405763';

-- SELECT  t1.ProviderBankCodeID,t1.ProviderID,t1.Code,t1.Name,t1.Icon
-- FROM ProviderBankCode t1
-- INNER JOIN ProviderBankCodeMapping t2 ON t1.ProviderBankCodeID = t2.ProviderBankCodeID
-- WHERE t2.BankID = 12 AND t1.ProviderID = 38

-- SELECT T2.AccountBalance - T2.OutstandingBalance AS AvailableBalance, 
-- 			T2.MemberID AS MemberID, 
-- 			T2.AccountID AS AccountID
-- 	FROM Member T1
-- 	INNER JOIN MemberAccount T2 ON T2.MemberID = T1.MemberID 
--     WHERE T1.MemberName = 'kcUserR01' AND T1.WebsiteID = 2;

-- SELECT t1.*, t14.MemberName as AssignedDepositor, DepositorBank, DepositorName, 
-- DepositorAccountNumber AS DepositorAccountNo, T13.AssignedDate
-- FROM dbo.fn_tbl_PaymentWithdrawal() t1
-- left join PaymentC2CDetail t13 ON t13.PaymentTransactionNo = t1.PaymentTransactionNo
-- left join(select a.AccountID , b.MemberName from MemberAccount a with (nolock)
--             LEFT JOIN Member b with (nolock) on  a.MemberId = b.MemberID) t14 on t13.DepositorAccountID = t14.AccountID 
-- WHERE t1.PaymentTransactionNo = @paymentTransNo;


-- SELECT t1.PaymentTransactionDetailMapID, t1.PaymentDetailID, t1.PaymentTransactionNo, ISNULL(t1.Value,'') Value 
-- FROM dbo.PaymentWithdrawalDetail (NOLOCK) t1
-- WHERE t1.PaymentTransactionNo = @paymentTransNo;

-- SELECT t1.* 
-- FROM dbo.fn_tbl_Document() t1
-- WHERE t1.ReferenceNo = @paymentTransNo AND t1.IsDelete = 0;
DECLARE @accountId int;
SET @accountId= 0;
-- -- SELECT t1.*, ISNULL (T1.BankName,'''') COLLATE DATABASE_DEFAULT AS DepositDetails --WCR-663
-- -- 		FROM dbo.fn_tbl_PaymentDeposit() t1
-- -- 		WHERE t1.AccountID = CASE WHEN @accountId = 0 THEN t1.AccountID ELSE @accountId END
-- 		-- AND t1.PaymentTransactionNo = 'WASCN2309245405763';


SELECT t1.PaymentTypeID
FROM dbo.fn_tbl_PaymentWithdrawal() t1
WHERE t1.AccountID = CASE WHEN @accountId = 0 THEN t1.AccountID ELSE @accountId END 
AND t1.PayoutTransactionNo = 'WASCN2309245405763';

select * from PaymentType where PaymentTypeID=103