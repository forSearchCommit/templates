-- =============== section =================

-- SELECT * from PaymentType

-- SELECT * from Providers

-- select * from PaymentOption where PaymentOptionTypeID = 18

-- select * from PaymentOptionType where PaymentOptionTypeID = 18

-- SELECT * from PaymentTypeGatewaySetting where PaymentOptionId=20

-- select * from PaymentLimit

-- select * from MemberDepositWithdrawalLimit
-- select * from Currency

-- select * from Bank

-- select COUNT(*)
-- from Bank
-- where CurrencyID = 6

-- select * from Currency

-- UPDATE Currency
-- SET IsCrypto = 1
-- WHERE CurrencyID = 6;

-- DECLARE @BankProvinceFieldName NVARCHAR(30) = ''BankProvince'',
-- 			@BankBranchFieldName NVARCHAR(30) = ''BankBranch'',
-- 			@BankCityFieldName NVARCHAR(30) = ''BankCity''

--     SELECT BankID,
-- 		   WebsiteID,
-- 		   BankCode,
-- 		   BankName,
-- 		   [Description],
-- 		   IsDisplayDeposit,
-- 		   IsDisplayWithdrawal,
-- 		   IsDeleted,
-- 		   BankURL,
-- 		   BankImage,
-- 		   BankImageName,
--            CountryID,
--            CurrencyID,
-- 		   ISNULL(BankStatus, 1) AS BankStatus,
-- 		   IsPopular,
-- 		   ISNULL((SELECT TOP 1 IsEnabled FROM BankTransferInfoField btf (NOLOCK) WHERE btf.BankID = b.BankID AND btf.FieldName = @BankProvinceFieldName),0) AS IsRequireBankProvince,
-- 		   ISNULL((SELECT TOP 1 IsEnabled FROM BankTransferInfoField btf (NOLOCK) WHERE btf.BankID = b.BankID AND btf.FieldName = @BankBranchFieldName),0) AS IsRequireBankBranch,
-- 		   ISNULL((SELECT TOP 1 IsEnabled FROM BankTransferInfoField btf (NOLOCK) WHERE btf.BankID = b.BankID AND btf.FieldName = @BankCityFieldName),0) AS IsRequireBankCity
-- 	FROM dbo.Bank AS b WITH(NOLOCK)

-- 	WHERE b.CountryID = @countryId AND b.CurrencyID = @currencyId AND b.BankURL
-- 	AND b.IsDisplayWithdrawal = 1 AND b.IsDeleted = 0 AND b.BankStatus = 1 ORDER BY b.BankName COLLATE Chinese_PRC_CI_AS


-- SELECT *
-- FROM dbo.BankAccountMember t1
-- LEFT JOIN dbo.MemberAccount t2 ON t2.AccountID = t1.AccountID
-- LEFT JOIN dbo.Bank t3 ON t3.BankID = t1.BankID
-- WHERE 
-- t2.MemberID = '21635'c

-- UPDATE bank
-- SET DisplaySequence = N'EBPay - EB币'
-- WHERE BankID = 215;

-- UPDATE bank
-- SET IsDisplayWithdrawal = 1
-- WHERE BankID = 215;

-- select * from bank
-- AND t3.BankURL IS NOT NULL

--  SELECT * from PaymentLimit

-- select * from MemberDepositWithdrawalLimit where AccountID = '430586'
-- IF EXISTS(
--     SELECT 1 FROM Member M WITH (NOLOCK) 
--     INNER JOIN MemberAccount MA WITH (NOLOCK) ON M.MemberID = MA.MemberID 
--     INNER JOIN MemberDepositWithdrawalLimit MDWL (NOLOCK) ON MA.AccountID = MDWL.AccountID 
--     WHERE M.MemberID = '22054' AND MDWL.IsEdited = 1)
--     BEGIN
--         --SELECT MaxBankAccountSaved AS BankAccountCountLimit FROM Member WITH (NOLOCK) WHERE MemberID = @MemberID
--         SELECT MaxOtherBankAccountSaved AS BankAccountCountLimit 
--         FROM MemberDepositWithdrawalLimit WITH (NOLOCK) 
--         WHERE AccountID = (SELECT AccountID FROM MemberAccount WITH(NOLOCK) WHERE MemberID ='22054')
--     END
-- ELSE
--     BEGIN
--         SELECT OtherAccountCountLimit AS BankAccountCountLimit 
--         FROM PaymentLimit PL WITH (NOLOCK) 
--         INNER JOIN MemberAccount MA ON PL.CurrencyCode = MA.CurrencyCode 
--         WHERE MA.MemberID = '22054'
--     END
-- UPDATE PaymentLimit
-- SET OtherAccountCountLimit = 20
-- WHERE PaymentLimitID = 7;
-- select *  from PaymentLimit
-- select * from MemberAccount
-- where MemberID = '21635'

-- select * from Member where Memberid = '21635'

-- select * from otp

-- SELECT MaxOtherBankAccountSaved AS BankAccountCountLimit 
-- FROM MemberDepositWithdrawalLimit WITH (NOLOCK) 
-- WHERE AccountID = (SELECT AccountID FROM MemberAccount WITH(NOLOCK) WHERE MemberID ='21635')

-- SELECT OtherAccountCountLimit AS BankAccountCountLimit 
-- FROM PaymentLimit PL WITH (NOLOCK) 
-- INNER JOIN MemberAccount MA ON PL.CurrencyCode = MA.CurrencyCode 
-- WHERE MA.MemberID = '22054'

-- SELECT Top 1 * FROM Member M WITH (NOLOCK) 
-- INNER JOIN MemberAccount MA WITH (NOLOCK) ON M.MemberID = MA.MemberID 
-- INNER JOIN MemberDepositWithdrawalLimit MDWL (NOLOCK) ON MA.AccountID = MDWL.AccountID 
-- WHERE M.MemberID = '21635' AND MDWL.IsEdited = 1
-- select * from member
-- where MemberName = 'motest002'
-- 21635 rmb
-- 22054 usdt 430586
-- declare @BankAccountNumber NVARCHAR(500)
-- set @BankAccountNumber = '1032556548708523632'
-- SELECT TOP 1 * FROM dbo.BankCardPattern T1 WITH(NOLOCK) WHERE @BankAccountNumber LIKE (T1.BinNumber+''%'') AND T1.[Length] = LEN(@BankAccountNumber) AND T1.BankCode IS NOT NULL;

-- where BankURL is not NULL

-- SELECT 
--     T1.BankID, 
--     T1.WebsiteID, 
--     T1.BankCode, 
--     T1.BankName, 
--     T1.Description, 
--     T1.IsDisplayDeposit, 
--     T1.IsDisplayWithdrawal, 
--     T1.IsDeleted, 
--     T1.BankURL, 
--     T1.BankImage, 
--     T1.BankImageName, 
--     T1.BankStatus, 
--     T1.CountryID, 
--     T3.Code, 
--     T3.Name, 
--     T1.CurrencyID, 
--     T2.Code AS CurrencyCode, 
--     T2.Name AS CountryCode, 
--     T1.IsPopular
-- FROM   dbo.Bank AS T1 INNER JOIN
--         dbo.Currency AS T2 ON T1.CurrencyID = T2.CurrencyID INNER JOIN
--         dbo.Country AS T3 ON T1.CountryID = T3.CountryID
-- WHERE  T2.Code = 'RMB' AND T1.BankStatus != 0  AND T1.WebsiteID = 2 AND T1.BankURL IS NULL


-- select * from Bank where BankURL is NULL
-- select * from PaymentType

-- select * from member where MemberName = 'kcUserR01'

-- SELECT b.* FROM Bank b 
-- where b.BankURL IS NULL

-- select * from memeb
-- Declare @MemberID int;
-- SET @MemberID = 21635;
-- BEGIN
-- 	IF EXISTS(SELECT 1 FROM Member M WITH (NOLOCK) INNER JOIN MemberAccount MA WITH (NOLOCK) ON M.MemberID = MA.MemberID INNER JOIN MemberDepositWithdrawalLimit MDWL (NOLOCK) ON MA.AccountID = MDWL.AccountID WHERE M.MemberID = @MemberID AND MDWL.IsEdited = 1)
-- 		BEGIN
-- 			--SELECT MaxBankAccountSaved AS BankAccountCountLimit FROM Member WITH (NOLOCK) WHERE MemberID = @MemberID
-- 			SELECT * FROM MemberDepositWithdrawalLimit WITH (NOLOCK) WHERE AccountID = (SELECT AccountID FROM MemberAccount WITH(NOLOCK) WHERE MemberID = @MemberID)
-- 		END
-- 	ELSE
-- 		BEGIN
-- 			SELECT CurrencyAccountCountLimit AS BankAccountCountLimit FROM PaymentLimit PL WITH (NOLOCK) INNER JOIN MemberAccount MA ON PL.CurrencyCode = MA.CurrencyCode WHERE MA.MemberID = @MemberID
-- 		END
-- END


-- USE [GCT_P003]
-- GO
-- /****** Object:  StoredProcedure [dbo].[Payment_GetMemberPaymentLimit]    Script Date: 2/3/2023 2:43:42 PM ******/
-- IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Payment_GetMemberPaymentLimit]') AND type IN (N'P', N'PC'))
-- DROP PROCEDURE [dbo].[Payment_GetMemberPaymentLimit]

-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO



-- CREATE PROCEDURE [dbo].[Payment_GetMemberPaymentLimit]
-- 	@MemberId INT,
-- 	@PaymentOptionId INT,
-- 	@Currency NVARCHAR(10),
-- 	@TransactionType INT
-- AS
-- BEGIN
-- 	-- SET NOCOUNT ON added to prevent extra result sets from
-- 	-- interfering with SELECT statements.
-- 	SET NOCOUNT ON;

-- 	DECLARE @AccountId INT  = ISNULL((SELECT TOP 1 AccountID FROM MemberAccount WITH (NOLOCK) WHERE MemberID = @MemberId),0) ;
-- 	DECLARE @MemberLimit AS TABLE (BankcardCount INT, CountLimit INT, AmountLimit DECIMAL(18,2), FromMemberSetting BIT)
-- 	DECLARE @DPTransactionType AS INT = 3010;
-- 	DECLARE @WDTransactionType AS INT = 3020;
-- 	DECLARE @MemberLimitPO AS TABLE ( PaymentOptionId INT,CountLimitPO INT, AmountLimitPO DECIMAL(18,2) , IncludeFailed BIT);

-- 	INSERT INTO @MemberLimit
-- 	SELECT 
-- 		MaxBankAccountSaved, 
-- 		CASE WHEN @TransactionType = @DPTransactionType AND DepositStatusID = 1 THEN DepositLimit 
-- 		WHEN @TransactionType = @WDTransactionType  AND WithdrawalStatusID = 1 THEN WithdrawalLimit 
-- 		ELSE NULL END,
-- 		CASE WHEN @TransactionType = @DPTransactionType AND OverallDailyDPAmountStatus = 1 THEN OverallDailyDPAmountLimit 
-- 		WHEN @TransactionType = @WDTransactionType  AND OverallDailyWDAmountStatus = 1 THEN OverallDailyWDAmountLimit 
-- 		ELSE NULL END,
-- 		1
-- 	FROM 
-- 		MemberDepositWithdrawalLimit WITH(NOLOCK)  
-- 	--left join MemberDepositWithdrawalLimit with (nolock) on c.AccountID  = @AccountId
-- 	WHERE 
-- 		AccountID = @AccountId and IsEdited = 1 

-- 	--Member a with (nolock)  
-- 	--left join MemberDepositWithdrawalLimit c with (nolock) on c.AccountID  = @AccountId
-- 	--where a.MemberID = @MemberId and c.IsEdited = 1 

-- 	IF NOT EXISTS(SELECT 1 FROM @MemberLimit)
-- 		BEGIN
-- 			INSERT INTO @MemberLimit
-- 			SELECT 
-- 				a.CurrencyAccountCountLimit,
-- 				CASE WHEN @TransactionType = @DPTransactionType AND a.OverallDailyDPCountStatus = 1 THEN a.OverallDailyDPCountLimit 
-- 				WHEN @TransactionType = @WDTransactionType  AND a.OverallDailyWDCountStatus = 1 THEN a.OverallDailyWDCountLimit
-- 				ELSE NULL END,
-- 				CASE WHEN @TransactionType = @DPTransactionType AND a.OverallDailyDPAmountStatus = 1 THEN a.OverallDailyDPAmountLimit
-- 				WHEN @TransactionType = @WDTransactionType  AND a.OverallDailyWDAmountStatus = 1 THEN a.OverallDailyWDAmountLimit
-- 				ELSE NULL END,
-- 				0
-- 			FROM 
-- 				PaymentLimit a WITH(NOLOCK) 
-- 			WHERE 
-- 				a.CurrencyCode= @Currency 
-- 		END

-- 	IF EXISTS(SELECT 1 FROM @MemberLimit WHERE FromMemberSetting = 1)
-- 		BEGIN
-- 			INSERT INTO @MemberLimitPO
-- 			SELECT 
-- 				PaymentOptionId,
-- 				CASE WHEN DailyCountLimitStatus IS NOT NULL AND DailyCountLimitStatus = 1 THEN DailyCountLimit
-- 				ELSE NULL END,
-- 				CASE WHEN DailyAmountLimitStatus IS NOT NULL AND DailyAmountLimitStatus = 1 THEN DailyAmountLimit
-- 				ELSE NULL END, 
-- 				CASE WHEN IncludeFailedTransaction IS NOT NULL AND IncludeFailedTransaction = 1 THEN 1 
-- 				ELSE 0 END
-- 			FROM 
-- 				PaymentOptionDailyLimitMember WITH(NOLOCK) 
-- 			WHERE 
-- 				AccountID = @AccountId 
-- 		END 
-- 	ELSE
-- 		BEGIN
-- 			INSERT INTO @MemberLimitPO
-- 			SELECT 
-- 				PaymentOptionId,
-- 				CASE WHEN DailyCountLimitStatus IS NOT NULL AND DailyCountLimitStatus = 1 THEN DailyCountLimit
-- 				ELSE NULL END,
-- 				CASE WHEN DailyAmountLimitStatus IS NOT NULL AND DailyAmountLimitStatus = 1 THEN DailyAmountLimit
-- 				ELSE NULL END, 
-- 				CASE WHEN IncludeFailedTransaction IS NOT NULL AND IncludeFailedTransaction = 1 THEN 1 
-- 				ELSE 0 END 
-- 			FROM 
-- 				PaymentOptionDailyLimit 
-- 			WHERE 
-- 				CurrencyCode = @Currency AND PaymentOptionID = @PaymentOptionId
-- 		END

-- 	DECLARE @FailedAmount AS DECIMAL(18,2);
-- 	DECLARE @FailedCount AS INT;
-- 	DECLARE @SuccessCount AS INT;
-- 	DECLARE @SuccessAmount AS DECIMAL(18,2);
-- 	DECLARE @POFailedAmount AS DECIMAL(18,2);
-- 	DECLARE @POFailedCount AS INT;
-- 	DECLARE @POSuccessCount AS INT;
-- 	DECLARE @POSuccessAmount AS DECIMAL(18,2);
-- 	DECLARE @fromDate AS DATETIME = CAST(GETDATE() AS DATE);
-- 	DECLARE @toDate AS DATETIME = DATEADD(MILLISECOND , -3 ,DATEADD(DAY , 1 , @fromDate));

-- 	SELECT @fromDate = StartDate, @toDate = EndDate FROM dbo.[fn_GetGMTStartEndDate](8)

-- 	-- if PO did enable include failed transaction will not calculate as valid count during overall count 
-- 	IF(@TransactionType = @DPTransactionType)
-- 		BEGIN
-- 			SELECT  
-- 				@FailedAmount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID IN( 3,11) AND b.AmountLimitPO IS NOT NULL AND b.IncludeFailed =1 THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@FailedCount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID IN( 3,11) AND b.CountLimitPO IS NOT NULL AND b.IncludeFailed =1 THEN 1 ELSE 0 END ) ,0),
-- 				@SuccessAmount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID =4 THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@SuccessCount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID =4 THEN 1 ELSE 0 END) ,0),
-- 				@POFailedAmount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID IN( 3,11) AND a.PaymentOptionID = @PaymentOptionId AND b.AmountLimitPO IS NOT NULL AND b.IncludeFailed =1   THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@POFailedCount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID IN( 3,11) AND a.PaymentOptionID = @PaymentOptionId AND b.CountLimitPO IS NOT NULL AND b.IncludeFailed =1  THEN 1 ELSE 0 END ) ,0),
-- 				@POSuccessAmount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID =4 AND a.PaymentOptionID = @PaymentOptionId THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@POSuccessCount = ISNULL(SUM( CASE WHEN PaymentDepositStatusID =4 AND a.PaymentOptionID = @PaymentOptionId THEN 1 ELSE 0 END ) ,0)
-- 			FROM 
-- 				PaymentDeposit a WITH(NOLOCK)  
-- 				LEFT JOIN @MemberLimitPO b on a.PaymentOptionID = b.PaymentOptionID
-- 			WHERE 
-- 				AccountID = @AccountId 
-- 				AND DateCreated BETWEEN @fromDate AND @toDate
-- 		END
-- 	ELSE
-- 		BEGIN
-- 			SELECT 
-- 				@FailedAmount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID IN( 4,9) AND b.AmountLimitPO IS NOT NULL AND b.IncludeFailed =1 THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@FailedCount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID IN( 4,9) AND b.CountLimitPO IS NOT NULL AND b.IncludeFailed =1 THEN 1 ELSE 0 END ) ,0),
-- 				@SuccessAmount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID =5 THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@SuccessCount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID =5 THEN 1 ELSE 0 END ) ,0),
-- 				@POFailedAmount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID IN( 4,9)AND b.AmountLimitPO IS NOT NULL AND a.PaymentOptionID = @PaymentOptionId AND b.IncludeFailed =1 THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@POFailedCount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID IN( 4,9)AND b.CountLimitPO IS NOT NULL AND a.PaymentOptionID = @PaymentOptionId AND b.IncludeFailed =1 THEN 1 ELSE 0 END ) ,0),
-- 				@POSuccessAmount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID =5 AND a.PaymentOptionID = @PaymentOptionId THEN (GrossAmount+AdjustmentAmount+ReimbursementAmount) ELSE 0 END ) ,0),
-- 				@POSuccessCount = ISNULL(SUM( CASE WHEN PaymentWithdrawalStatusID =5 AND a.PaymentOptionID = @PaymentOptionId THEN 1 ELSE 0 END ) ,0)
-- 			FROM 
-- 				paymentwithdrawal a WITH(NOLOCK)
-- 				LEFT JOIN @MemberLimitPO b ON a.PaymentOptionID = b.PaymentOptionID
-- 			WHERE 
-- 				AccountID = @AccountId 
-- 				AND DateCreated BETWEEN @fromDate AND @toDate
-- 		END

-- 	DECLARE @TotalCount INT = @FailedCount + @SuccessCount; -- Use to Block 

-- 	SELECT 
-- 		BankcardCount as CardCount, 
-- 		CASE WHEN CountLimitPO IS NOT NULL THEN CountLimitPO ELSE CountLimit END AS 'LimitCount', 
-- 		CASE WHEN AmountLimitPO IS NOT NULL THEN AmountLimitPO ELSE AmountLimit END AS 'LimitAmount', 
-- 		CASE WHEN CountLimitPO IS NOT NULL THEN @POSuccessCount +  @POFailedCount
-- 		ELSE @FailedCount + @SuccessCount END AS 'CurrentCount', 
-- 		CASE WHEN AmountLimitPO IS NOT NULL THEN @POSuccessAmount +  @POFailedAmount
-- 		ELSE @SuccessAmount + @FailedAmount END AS 'CurrentAmount', 
-- 		AmountLimit AS 'OverallAmountLimit' , (@SuccessAmount + @FailedAmount) AS 'CurrentOverallAmount', 
-- 		CountLimit AS 'OverallCountLimit' , (@SuccessCount + @FailedCount) AS 'CurrentOverallCount'
-- 	FROM 
-- 		@MemberLimit a
-- 		LEFT JOIN @MemberLimitPO b ON b.PaymentOptionID = @PaymentOptionId
 
-- END
-- =============== section =================

-- =============== section =================
-- -- SELECT
-- --     t0.*, t7.BankID,BankAccountNo,BankProvince,BankCity,BankBranch,ReferenceNo,DPStatus,WDStatus,MemberBankAccountID,MemberBankAccountStatus, t7.BankName, t7.BankAccountMemberRemarks, t7.VerificationStatus, t7.OTPStatus
-- -- FROM dbo.fn_tbl_Member() t0
-- -- LEFT JOIN
-- -- (
-- --     SELECT t1.BankID,BankAccountNo,BankProvince,BankCity,BankBranch,ReferenceNo,DPStatus,WDStatus,MemberBankAccountID,MemberBankAccountStatus, t6.BankName, t1.AccountID, t1.Remarks as BankAccountMemberRemarks, t1.VerificationStatus, t1.OTPStatus
-- --     FROM dbo.BankAccountMember t1 
-- --     LEFT JOIN dbo.Bank t6 ON t6.BankID = t1.BankID
-- -- )
-- -- t7 ON t0.AccountID = t7.AccountID
-- -- WHERE t7.MemberBankAccountID = '4632463223642364000'
-- CREATE TABLE #tmpMemberList   
--  (  
--   Row int IDENTITY(1,1) PRIMARY KEY,  
--   MemberID int,  
--   BankID int,  
--   BankAccountNo NVarchar(500),  
--   BankName NVarchar(100),  
--   BankProvince NVarchar(500),  
--   BankCity NVarchar(500),  
--   BankBranch NVarchar(500),  
--   ReferenceNo NVarchar(100),  
--   DPStatus int,  
--   WDStatus int,  
--   MemberBankAccountID int,  
--   MemberBankAccountStatus int,  
--   BankAccountMemberRemarks NVarchar(500),  
--   VerificationStatus int,  
--   OTPStatus int  
--  ) 

-- INSERT INTO #tmpMemberList   
-- (MemberID, BankID,BankAccountNo,BankName,BankProvince,BankCity,BankBranch,ReferenceNo,DPStatus,WDStatus,MemberBankAccountID,MemberBankAccountStatus,BankAccountMemberRemarks,VerificationStatus,OTPStatus)  

-- SELECT   
-- t2.MemberID, t1.BankID, t1.BankAccountNo, t6.BankName, t1.BankProvince, t1.BankCity, t1.BankBranch, t1.ReferenceNo, t1.DPStatus, t1.WDStatus, t1.MemberBankAccountID, t1.MemberBankAccountStatus, t1.Remarks as BankAccountMemberRemarks,  
-- t1.VerificationStatus, t1.OTPStatus  
-- FROM dbo.BankAccountMember t1  
-- LEFT JOIN  dbo.MemberAccount t2 ON t2.AccountID =  t1.AccountID  
-- LEFT JOIN dbo.MemberLogin t3 ON t3.MemberID = t2.MemberID   
-- LEFT JOIN dbo.Member t4 ON t4.MemberID = t3.MemberID   
-- LEFT JOIN dbo.Website t5 ON t5.WebsiteID = t4.WebsiteID   
-- LEFT JOIN dbo.Bank t6 ON t6.BankID = t1.BankID  
-- LEFT JOIN dbo.Currency C ON C.Code = t2.CurrencyCode
-- LEFT JOIN  
-- (  
-- SELECT   
--     CASE ISNULL(MAX(CONVERT(TINYINT, h1.IsActive)), 0)  
--     WHEN 0 THEN 1  
--     ELSE 2   
--     END AS MemberPaymentStatusID  
--     ,h1.MemberID  
-- FROM PaymentHoldWithdrawal h1 WITH(NOLOCK)  
-- WHERE IsActive = 1  
--     AND (  
--     (HoldLimitDate >= GETDATE() AND HoldLimitDate IS NOT NULL)  
--     OR  
--     (HoldLimitDate IS NULL)  
--     )  
-- GROUP BY h1.MemberID  
-- ) AS holdWithdrawal  
-- ON t3.MemberID = holdWithdrawal.MemberID  

-- WHERE t4.IsDelete = 0
-- AND t5.WebsiteID = 2
-- AND t2.CurrencyCode = 'RMB'
-- AND t6.BankURL IS NULL

-- select * from #tmpMemberList  
-- Drop TABLE #tmpMemberList  
-- =============== section =================
-- =============== section =================
-- -- select * from Bank
-- DECLARE @BankAccountNumber NVARCHAR(500)
-- -- ,        @BankID NVARCHAR(500)
-- -- SET @BankAccountNumber = '0xc0d9da090194d62b2027e4009d9123de399ea7bt'
-- SET @BankAccountNumber = '1032556548708523632'
-- -- select  @BankID = BankID 
-- -- From BankAccountMember WHERE BankAccountNo = '0xc0d9da090194d62b2027e4009d9123de399ea7bt'

-- -- SELECT TOP 1 * FROM Bank WHERE BankID = @BankID ;
-- select * from MemberDepositWithdrawalLimit where AccountID = '430586'
-- SELECT TOP 1 B.*
-- FROM Bank B
-- WHERE B.BankID = (
--     SELECT BAM.BankID
--     FROM BankAccountMember BAM
--     WHERE BAM.BankAccountNo = @BankAccountNumber
-- );

-- -- select * from dbo.BankCardPattern
-- select * from BankCardPattern
-- select * from bank where BankCode = 'ABC'

-- select * from BankAccountMember where BankAccountNo = '0x9a4Ef1A723A7Caaa99643C075E9216687B5c68E9'

-- SELECT TOP 1 * FROM dbo.BankCardPattern T1 WITH(NOLOCK) WHERE @BankAccountNumber LIKE (T1.BinNumber+'%') AND T1.[Length] = LEN(@BankAccountNumber) AND T1.BankCode IS NOT NULL;
-- select * from dbo.BankCardPattern where bankcode = 'CITIC'
-- select * from MemberAccount where MemberID = '22054'

-- select * from BankAccountMember where BankAccountNo = '0xc0d9da090194d62b2027e4009d9123de399ea7bt'

-- SELECT *
-- FROM dbo.BankAccountMember t1
-- LEFT JOIN dbo.MemberAccount t2 ON t2.AccountID = t1.AccountID
-- LEFT JOIN dbo.Bank t3 ON t3.BankID = t1.BankID
-- WHERE 
-- t2.MemberID = '22054' AND
-- t3.BankURL IS NULL;


-- select * from Bank

-- IF EXISTS(
-- 		SELECT *
-- 		FROM dbo.BankAccountMember t1(NOLOCK)		
-- 		WHERE 
-- 		t1.BankAccountNo = @BankAccountNumber
-- 	)
-- BEGIN
--     SELECT 0
-- END
-- ELSE
-- BEGIN
--     SELECT 1
-- END
-- =============== section =================
-- =============== section =================


-- DECLARE @memberId Integer  
-- SET @memberId = 22054

-- SELECT t1.MemberID, t1.MemberStatusID, t1.Salutation, t1.GivenName, t1.LastName, t1.MemberName, t1.CountryCode, t1.AddressLine1, t1.AddressLine2, t1.AffiliateID, t1.SelfAffiliateID, t1.City,   
--            t1.ContactNo, t1.ContactStatus, t1.DateOfBirth, t1.Email, t1.Gender, t1.NewsletterSubscrition, t1.PostalCode, t1.PreferedLanguageCode, t1.SecurityAnswer, t1.SecurityQuestion,   
--            t1.SecurityNumber, t1.TimeZone, t1.WebsiteID, t2.Name AS WebsiteName, t1.UserCreated, t1.DateCreated, t1.UserUpdated, t1.DateUpdated, t3.LoginName, t1.PromotionCode,  
--            t3.IsUserLock, t3.IsForceChangePassword, t3.LastSuccessLogin, t3.LoginFailAttempt, t3.LastFailLogin, t4.AccountID, t4.MemberAccountStatusID, [dbo].[fn_GetMemberPaymentStatusID](t1.MemberID) AS MemberPaymentStatusID, t4.CurrencyCode, t3.Password
-- ,  
--            t4.AccountBalance, t4.OutstandingBalance, t4.Remarks, t5.SeflExclusion, t5.SelfExclusionAdmin, t5.SelfExclusionDateUpdated,  
--            t1.BankAccountGroupID , t1.QQID,t1.WingAccountID,   
--      t1.MemberLevel,  
--      t1.deliveryAddress, t1.deliveryCity, t1.deliveryProvince, t1.deliveryPostalCode,  
--      t1.WechatID,t1.ReceiverName,t1.ReceiverNo,t1.Province,  
--            ISNULL(t6.BankAccountGroupCode, '') BankAccountGroup ,  
--    ISNULL(t7.WingAccountNo , '') WingAccountNo ,  
--    t1.PartnerAffiliateCode AS Affiliate,  
--    t8.AffiliateCode ReferralCode,  
--    t1.PhoneCallSubscription,  
--    t1.NewsletterSubscriptionReasonID,  
--    t1.PhoneCallSubscriptionReasonID,   
--    t1.IsFirstTimeMigration,t1.IsMigratedMember,   
--    t10.DepositLimit, isnull(t10.DepositStatusID,0) as DepositStatusID, t10.WithdrawalLimit,isnull(t10.WithdrawalStatusID,0) AS WithdrawalStatusID, t10.IsEdited, t1.IpAddress, t1.AccountType,  
--    d1.Name AS DefaultLevelName,  
--    V1.Name AS ENGLevelName,  
--    V2.Name AS THALevelName,  
--    V3.Name AS KHMLevelName,  
--    V4.Name AS VIELevelName,  
--    V5.Name AS IDNLevelName,  
--    d1.VIPLevel,  
--    d1.VIPLevelID,  
--    (t11.ChurnCurrentMonth - t11.ChurnReduced) AccumulatedEligibleStake,  
--    (d2.Amount) RequiredNextLevelAmount,  
--    d2.Name AS NextDefaultLevelName,  
--    d1.IconName VIPIconName,  
--    d1.Icon VIPIcon,  
--    (((t11.ChurnCurrentMonth - t11.ChurnReduced)*100 /d2.Amount)) as VIPPercentage,  
--    t1.RegisteredChannel,  
--    CASE WHEN t12.MemberID IS NULL THEN 0  
--     ELSE 1   
--    END AS HasRegisteredDevice,  
--    t1.Nationality Nationality,  
--    t1.PlaceOfBirth PlaceOfBirth,  
--    t1.isHasOTP isHasOTP,  
--    t1.TriggerOTPCount TriggerOTPCount,  
--    t1.MaxBankAccountSaved,  
--    t1.NickName,  
--    t1.Avatar  
--  FROM   dbo.Member(NOLOCK) t1   
--            INNER JOIN dbo.Website(NOLOCK) t2 ON t2.WebsiteID = t1.WebsiteID   
--            INNER JOIN dbo.MemberLogin(NOLOCK) t3 ON t3.MemberID = t1.MemberID   
--            INNER JOIN dbo.MemberAccount(NOLOCK) t4 ON t4.MemberID = t1.MemberID   
--            INNER JOIN dbo.MemberCompliance(NOLOCK) t5 ON t5.MemberID = t1.MemberID  
--      OUTER APPLY (select TOP 1 MemberId from MemberDevice a where a.MemberID = t1.memberId) t12   
--            LEFT JOIN BankAccountGroup (NOLOCK) t6 ON t6.BankAccountGroupID = t1.BankAccountGroupID  
--      LEFT JOIN WingAccount (NOLOCK) t7 ON t7.WingAccountID = t1.WingAccountID  
--      LEFT JOIN Affiliate (NOLOCK) t8 ON t8.AffiliateID = t1.SelfAffiliateID  
--      LEFT JOIN Affiliate (NOLOCK) t9 ON t9.AffiliateID = t1.AffiliateID  
--      LEFT JOIN MemberDepositWithdrawalLimit(NOLOCK) t10 ON t10.AccountID = t4.AccountID  
--      LEFT JOIN VIPMember (nolock) t11 on t11.MemberID = t1.MemberID  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,V2.[Language] AS LanguageName,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = 'ENG') V1 ON V1.VIPLevelID = t11.VIPLevelID AND V1.Currency = t4.CurrencyCode  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,V2.[Language] AS LanguageName,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = 'THA') V2 ON V2.VIPLevelID = t11.VIPLevelID AND V2.Currency = t4.CurrencyCode  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,V2.[Language] AS LanguageName,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = 'KHM') V3 ON V3.VIPLevelID = t11.VIPLevelID AND V3.Currency = t4.CurrencyCode  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,V2.[Language] AS LanguageName,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = 'VIE') V4 ON V4.VIPLevelID = t11.VIPLevelID AND V4.Currency = t4.CurrencyCode  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,V2.[Language] AS LanguageName,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = 'IDN') V5 ON V5.VIPLevelID = t11.VIPLevelID AND V5.Currency = t4.CurrencyCode  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = V1.[Language]) d1 ON d1.VIPLevelID = t11.VIPLevelID AND d1.Currency = t4.CurrencyCode  
--      LEFT JOIN (SELECT V1.VIPLevelID,VIPLevel,Name,Amount,V1.[Language], Currency,Icon,IconName,UserCreated,DateCreated,UserUpdated,DateUpdated  
--      FROM VIPLevel (NOLOCK) V1 INNER JOIN VIPLevelName (NOLOCK) V2 ON V1.VIPLevelID = V2.VIPLevelID WHERE V2.[Language] = V1.[Language]) d2 ON d2.VIPLevel = d1.VIPLevel + 1 AND d2.Currency = t4.CurrencyCode  
--     WHERE t1.MemberID = @memberId 
-- =============== section =================