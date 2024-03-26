SELECT name 
FROM sys.columns 
WHERE object_id = OBJECT_ID('dbo.PaymentWithdrawal') 
FOR JSON AUTO