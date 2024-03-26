-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
USE Affiliate_P003
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FW
-- Create date: 19/02/204
-- Description:	INSERT MMPAY TRANSACTION DETAIL
-- =============================================

IF EXISTS(
    SELECT 1 
    FROM information_schema.ROUTINES WITH (NOLOCK)
    WHERE ROUTINE_TYPE = 'PROCEDURE'
    AND ROUTINE_NAME = 'AffiliateInfos_MMPayTransactionDetails_Insert'
    AND SPECIFIC_SCHEMA = 'Affiliate'
)
BEGIN
    DROP PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_Insert];
END
GO

CREATE PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_Insert]
	-- Add the parameters for the stored procedure here
    --@MMPayTransactionId BIGINT,
    @TransactionNumber NVARCHAR(MAX),
    @PayoutTransactionNumber NVARCHAR(MAX),
    @AdjustmentTransactionNumber NVARCHAR(MAX),
    @MemberCode NVARCHAR(MAX),
    @AffiliateCode NVARCHAR(MAX),
    @CredentialID BIGINT,
    @SubCredentialID BIGINT ,
    @MemberCurrency NVARCHAR(10) ,
    @Status INT ,
    @Active INT ,
    @AffiliateBalanceBeforeTransaction DECIMAL(20, 4) ,
    @Amount DECIMAL(20, 4) ,
    @AmountAfterExchange DECIMAL(20, 4) ,
    @CurrencyExchangeRate DECIMAL(18, 6) ,
    @ReverseExchangeRate DECIMAL(18, 6) ,
    @CommissionRate DECIMAL(20, 4) ,
    @Churn INT ,
    @RemarkType INT ,
    @Remark NVARCHAR(MAX) ,
    @CreatedDate DATETIME ,
    @CreatedBy NVARCHAR(MAX) ,
    @ModifiedDate DATETIME ,
    @ModifiedBy NVARCHAR(MAX) ,
    @NotifyUrl NVARCHAR(MAX) ,
    @TransactionType INT ,
    @TransactionDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRANSACTION
    BEGIN TRY
	IF NOT EXISTS ( SELECT 1 FROM [Affiliate].[MMPayTransactionDetails] WITH (NOLOCK) WHERE TransactionNumber = @TransactionNumber)
    BEGIN
        INSERT INTO [Affiliate].[MMPayTransactionDetails](
            -- MMPayTransactionId,
            TransactionNumber,
            PayoutTransactionNumber,
            AdjustmentTransactionNumber,
            MemberCode,
            AffiliateCode,
            CredentialID,
            SubCredentialID,
            MemberCurrency,
            Status,
            Active,
            AffiliateBalanceBeforeTransaction,
            Amount,
            AmountAfterExchange,
            CurrencyExchangeRate,
            ReverseExchangeRate,
            CommissionRate,
            Churn,
            RemarkType,
            Remark,
            CreatedDate,
            CreatedBy,
            ModifiedDate,
            ModifiedBy,
            NotifyUrl,
            TransactionType,
            TransactionDate
        )
        OUTPUT
            INSERTED.MMPayTransactionId,
            INSERTED.TransactionNumber,
            INSERTED.PayoutTransactionNumber,
            INSERTED.AdjustmentTransactionNumber,
            INSERTED.MemberCode,
            INSERTED.AffiliateCode,
            INSERTED.CredentialID,
            INSERTED.SubCredentialID,
            INSERTED.MemberCurrency,
            INSERTED.Status,
            INSERTED.Active,
            INSERTED.AffiliateBalanceBeforeTransaction,
            INSERTED.Amount,
            INSERTED.AmountAfterExchange,
            INSERTED.CurrencyExchangeRate,
            INSERTED.ReverseExchangeRate,
            INSERTED.CommissionRate,
            INSERTED.Churn,
            INSERTED.RemarkType,
            INSERTED.Remark,
            INSERTED.CreatedDate,
            INSERTED.CreatedBy,
            INSERTED.ModifiedDate,
            INSERTED.ModifiedBy,
            INSERTED.NotifyUrl,
            INSERTED.TransactionType,
            INSERTED.TransactionDate
        VALUES(
            --@MMPayTransactionId,
            @TransactionNumber,
            @PayoutTransactionNumber,
            @AdjustmentTransactionNumber,
            @MemberCode,
            @AffiliateCode,
            @CredentialID,
            @SubCredentialID,
            @MemberCurrency,
            @Status,
            @Active,
            @AffiliateBalanceBeforeTransaction,
            @Amount,
            @AmountAfterExchange,
            @CurrencyExchangeRate,
            @ReverseExchangeRate,
            @CommissionRate,
            @Churn,
            @RemarkType,
            @Remark,
            @CreatedDate,
            @CreatedBy,
            @ModifiedDate,
            @ModifiedBy,
            @NotifyUrl,
            @TransactionType,
            @TransactionDate
        )

        COMMIT TRANSACTION
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO
