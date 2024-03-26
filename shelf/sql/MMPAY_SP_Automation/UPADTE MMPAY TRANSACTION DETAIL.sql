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
-- Description:	UPDATE MMPAY TRANSACTION DETAIL
-- =============================================

IF EXISTS(
    SELECT 1 
    FROM information_schema.ROUTINES WITH (NOLOCK)
    WHERE ROUTINE_TYPE = 'PROCEDURE'
    AND ROUTINE_NAME = 'AffiliateInfos_MMPayTransactionDetails_Update'
    AND SPECIFIC_SCHEMA = 'Affiliate'
)
BEGIN
    DROP PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_Update];
END
GO

CREATE PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_Update]
	-- Add the parameters for the stored procedure here
    @MMPayTransactionId BIGINT,
    @AdjustmentTransactionNumber NVARCHAR(MAX),
    @Status INT ,
    @AffiliateCode NVARCHAR(MAX),
    @AffiliateCredentialId BIGINT,
    @AffiliateBalanceBeforeTransaction DECIMAL(20,4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Variable to hold the return value
    DECLARE @ReturnValue INT;

    -- Insert statements for procedure here
	IF EXISTS ( 
        SELECT 1 
        FROM [Affiliate].[MMPayTransactionDetails] WITH (NOLOCK) 
        WHERE MMPayTransactionId = @MMPayTransactionId 
        AND AffiliateCode = @AffiliateCode
        AND Status = 0
    ) 
    BEGIN
        BEGIN TRANSACTION
            BEGIN TRY
                BEGIN

                    DECLARE 
                    @BalanceLogId INT,
                    @AdjustmentAmount DECIMAL(18,6),
                    @UserUpdated NVARCHAR(MAX);

                    -- GET ADJUSTMENT AMOUNT
                    SELECT 
                    @AdjustmentAmount = AmountAfterExchange
                    FROM [Affiliate].[MMPayTransactionDetails] A
                    WHERE A.MMPayTransactionId = @MMPayTransactionId

                    -- GET UPDATE USER
                    SELECT 
                    @UserUpdated = Name
                    FROM [Affiliate].[AffiliateInfos] A
                    WHERE A.CredentialID = @AffiliateCredentialId     

                    -- CREATE CASH LOG AND ADJUSTMENT, GET ADJUSTMENT TRANS NO AND USER BALANCE
                    IF @Status = 1
                    BEGIN
                        EXEC [Affiliate].[AffiliateInfos_MMPayTransactionDetails_InsertAdjustment]
                            @pCredentialID  = @AffiliateCredentialId,
                            @pAdjustAmount  = @AdjustmentAmount,
                            @pActiveMonth  = NULL,
                            @pRemarks  = N'代付回调',
                            @pTransactionType  = '2',
                            @pComments = N'代付回调',
                            @pCreatedBy = @UserUpdated,
                            @oID = @BalanceLogId OUTPUT;
                        
                        SELECT 
                            @AffiliateBalanceBeforeTransaction = OldBalance,
                            @AdjustmentTransactionNumber = TransactionNo
                        FROM [Affiliate].[AffiliateAccountBalanceLog] C
                        WHERE C.CredentialID = @AffiliateCredentialId
                        AND C.AccountBalanceLogId = @BalanceLogId
                    END
                    ELSE
                    BEGIN
                        -- DEFAULT UPDATE VALUE FOR REJECT
                        SET @AdjustmentTransactionNumber = NULL;
                        SET @AffiliateBalanceBeforeTransaction = '0';
                    END

                    UPDATE [Affiliate].[MMPayTransactionDetails]
                    SET
                        AdjustmentTransactionNumber = @AdjustmentTransactionNumber,
                        Status = @Status,
                        AffiliateBalanceBeforeTransaction = @AffiliateBalanceBeforeTransaction,
                        ModifiedDate = GETUTCDATE(),
                        ModifiedBy = @UserUpdated
                    WHERE MMPayTransactionId = @MMPayTransactionId 
                    AND AffiliateCode = @AffiliateCode

                    COMMIT TRANSACTION;
                    SET @ReturnValue = 1; 
                END
            END TRY
            BEGIN CATCH
                ROLLBACK TRANSACTION;
                SET @ReturnValue = 0;
                THROW;
            END CATCH
    END
    ELSE
    BEGIN
        -- Return a specific value if the condition is not met
        SET @ReturnValue = 0; -- Or any other value you want to return
    END
    
    SELECT @ReturnValue AS ReturnValue;
END
GO
