Adjustment - credential id
affiliateinfo - credential id

USE [Affiliate_P003]


BEGIN
	DECLARE @CredentailIDSub BIGINT = @CredentialID; -- this Credentail ID may possible is a subUser Credentail ID
	SET @CredentialID = (SELECT CredentialID FROM Affiliate.AffiliateCodes WITH (NOLOCK) WHERE AffiliateCode = @AffiliateCode);

	DECLARE @TransactionPrefix NVARCHAR(5) = CASE WHEN @RemarkType = 2 THEN 'MMDC' ELSE 'MMADJ' END,
			@TimeStamp NVARCHAR(8) = (SELECT CONVERT(nvarchar(8), GETDATE(), 112)),
			@RandomNum NVARCHAR(6) = REPLACE(SUBSTRING(CAST(CAST(CAST(NEWID() AS BINARY(5)) AS BIGINT) AS NVARCHAR(13)), 1, 6), ' ', 0),
			@TransactionNumber NVARCHAR(50),
			@AffiliateBalanceBeforeTransaction DECIMAL(20,4),
			@CommissionRate DECIMAL(20,4) = (SELECT CommissionRate FROM Affiliate.MMPaySetting WITH (NOLOCK) WHERE AffCode = @AffiliateCode),
			@ExchangeRate DECIMAL(18,6) = 1,
			@AmountAfterExchange DECIMAL(20,4) = 0,
			@AffiliateCurrency NVARCHAR(5) = (SELECT TOP 1 Currency FROM Affiliate.AffiliateInfos WITH (NOLOCK) WHERE CredentialID = @CredentialID),
			@TransactionDate DATETIME2 = (DATEADD(HOUR, 8, GETUTCDATE()))

	SET @ExchangeRate = [dbo].[fn_GetExchangeRateByCurrency](@MemberCurrency, @AffiliateCurrency, @TransactionDate);
	
	SET @AmountAfterExchange = (@Amount * @ExchangeRate)
	SET @TransactionNumber = @TransactionPrefix + @TimeStamp + @RandomNum
		
	WHILE EXISTS(SELECT 1 FROM Affiliate.MMPayHistory WITH (NOLOCK) WHERE TransactionNumber = @TransactionNumber) BEGIN
		SET	@RandomNum = REPLACE(SUBSTRING(CAST(CAST(CAST(NEWID() AS BINARY(5)) AS BIGINT) AS NVARCHAR(13)), 1, 6), ' ', 0);
		SET @TransactionNumber = @TransactionPrefix + @TimeStamp + @RandomNum;
	END

	SET @AffiliateBalanceBeforeTransaction = ISNULL((SELECT TOP 1 Balance FROM Affiliate.AffiliateInfos WITH (NOLOCK) WHERE CredentialID = @CredentialID),0);
	UPDATE Affiliate.AffiliateInfos SET Balance = (ISNULL(Balance,0) - @AmountAfterExchange), OutstandingBalance = (ISNULL(OutstandingBalance,0) + @AmountAfterExchange) WHERE CredentialID = @CredentialID

	IF(@MemberCurrency = 'RMB')
	BEGIN
		DECLARE @reverseRate DECIMAL(18,6)= [dbo].[fn_GetExchangeRateByCurrency](@AffiliateCurrency, @MemberCurrency, @TransactionDate);

		INSERT INTO Affiliate.MMPayHistory (TransactionNumber, AffiliateCode, CredentialID, SubCredentialID, AffiliateBalanceBeforeTransaction, CommissionRate, MemberCode, MemberCurrency, Amount, AmountAfterExchange, CurrencyExchangeRate, ReverseExchangeRate, Churn, RemarkType, Remark, CreatedBy, ModifiedBy)
		OUTPUT INSERTED.[TransactionNumber], INSERTED.[AffiliateBalanceBeforeTransaction], INSERTED.AmountAfterExchange, INSERTED.[CreatedDateUTC]
		VALUES (@TransactionNumber, @AffiliateCode, @CredentialID, @CredentailIDSub, @AffiliateBalanceBeforeTransaction, @CommissionRate, @MemberCode, @MemberCurrency, @Amount, @AmountAfterExchange, @ExchangeRate, @reverseRate, @Churn, @RemarkType, @Remark, @CreatedBy, @CreatedBy)
	END
	ELSE IF(@MemberCurrency = 'USDT')
	BEGIN
		DECLARE @reverseExchangeRate DECIMAL(18,6)= [dbo].[fn_GetExchangeRateByCurrency](@AffiliateCurrency, @MemberCurrency, @TransactionDate);

		INSERT INTO Affiliate.MMPayHistory (TransactionNumber, AffiliateCode, CredentialID, SubCredentialID, AffiliateBalanceBeforeTransaction, CommissionRate, MemberCode, MemberCurrency, Amount, AmountAfterExchange, CurrencyExchangeRate, ReverseExchangeRate, Churn, RemarkType, Remark, CreatedBy, ModifiedBy)
		OUTPUT INSERTED.[TransactionNumber], INSERTED.[AffiliateBalanceBeforeTransaction], INSERTED.AmountAfterExchange, INSERTED.[CreatedDateUTC]
		VALUES (@TransactionNumber, @AffiliateCode, @CredentialID, @CredentailIDSub, @AffiliateBalanceBeforeTransaction, @CommissionRate, @MemberCode, @MemberCurrency, @AmountAfterExchange, @Amount, @reverseExchangeRate, @ExchangeRate, @Churn, @RemarkType, @Remark, @CreatedBy, @CreatedBy)
	END
END