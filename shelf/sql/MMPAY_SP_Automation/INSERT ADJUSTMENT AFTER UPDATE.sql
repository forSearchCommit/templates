USE [Affiliate_P003]
GO
/****** Object:  StoredProcedure [Affiliate].[AffiliateInfos_MMPayTransactionDetails_InsertAdjustment]    Script Date: 2/23/2024 9:53:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Feng Wei
-- Create date: 2024-02-23
-- Description: Edited cloned from he insert operation spx for table [Affiliate].[Adjustments]
-- Revision:
-- =============================================


IF EXISTS(
    SELECT 1 
    FROM information_schema.ROUTINES WITH (NOLOCK)
    WHERE ROUTINE_TYPE = 'PROCEDURE'
    AND ROUTINE_NAME = 'AffiliateInfos_MMPayTransactionDetails_InsertAdjustment'
    AND SPECIFIC_SCHEMA = 'Affiliate'
)
BEGIN
    DROP PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_InsertAdjustment];
END
GO

CREATE PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_InsertAdjustment]
@oID INT = NULL OUTPUT,
@pCredentialID BIGINT = NULL,
@pAdjustAmount DECIMAL(18, 6) = NULL,
@pActiveMonth DATE = NULL,
@pRemarks NVARCHAR(500) = NULL,
@pTransactionType INTEGER = NULL,
@pComments NVARCHAR(500) = NULL,
@pCreatedBy VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
    BEGIN TRANSACTION
    BEGIN TRY
    BEGIN
        DECLARE @NewAdjustment TABLE
        (
            CredentialID BIGINT,
            AdjustmentAmount DECIMAL(18,6),
            CreatedAt DATETIME,
            AdjustmentTransactionNo NVARCHAR(20),
            Remarks NVARCHAR(500),
            CreatedBy NVARCHAR(50)
        );

        /* Create Adjustment */
        INSERT INTO [Affiliate].[Adjustments](
            [CredentialID],
            [AdjustAmount],
            [ActiveMonth],
            [Remarks],
            [Comments],
            [CreatedBy],
            [LastModifiedBy],
            [AdjustmentTransactionNo])
        OUTPUT  INSERTED.CredentialID,
                INSERTED.AdjustAmount,
                INSERTED.CreatedAt,
                INSERTED.AdjustmentTransactionNo,
                INSERTED.Remarks,
                INSERTED.CreatedBy
        INTO @NewAdjustment
        VALUES(
            ISNULL(@pCredentialID, 0),
            ISNULL(@pAdjustAmount, 0),
            ISNULL(@pActiveMonth, CONVERT(VARCHAR(10), GETDATE(), 120)),
            ISNULL(@pRemarks, ''),
            ISNULL(@pComments, ''),
            ISNULL(@pCreatedBy, ''),
            ISNULL(@pCreatedBy, ''),
            dbo.Generic_GenerateDatedTransactionID('ADJ'))

        SET @oID = SCOPE_IDENTITY();

        DECLARE @nCredentialID BIGINT,
                @nAdjustmentAmount DECIMAL(18,6),
                @nCreatedAt DATETIME,
                @nAdjustmentTransactionNo NVARCHAR(20),
                @nRemarks NVARCHAR(500),
                @nCreatedBy NVARCHAR(50),
                @nAffOldBalance DECIMAL(18, 4),
                @nAffNewBalance DECIMAL(18, 4);

        SELECT 
        @nCredentialID = CredentialID, 
        @nAdjustmentAmount = AdjustmentAmount, 
        @nCreatedAt = CreatedAt, 
        @nAdjustmentTransactionNo = AdjustmentTransactionNo, 
        @nRemarks = Remarks, 
        @nCreatedBy = CreatedBy 
        FROM @NewAdjustment 

        /* Update Member Balance */
        SELECT 
        @nAffOldBalance = ISNULL(Balance, 0) 
        FROM Affiliate.AffiliateInfos WITH (NOLOCK) WHERE CredentialID = @nCredentialID;

        UPDATE Affiliate.AffiliateInfos 
        SET Balance = ISNULL(Balance, 0) + @nAdjustmentAmount 
        WHERE CredentialID = @nCredentialID;

        SELECT 
        @nAffNewBalance = ISNULL(Balance, 0) 
        FROM Affiliate.AffiliateInfos WITH (NOLOCK) WHERE CredentialID = @nCredentialID;
        /* Update Member Balance */

        /* Add Cash Log */
        INSERT INTO [Affiliate].[AffiliateAccountBalanceLog]
        (  
            CredentialID,
            AmountChange,
            OldBalance,
            NewBalance,
            TransactionNo,
            TransactionTypeID,
            TransactionDateTimeUTC,
            Remarks,
            MemberCode,
            UserCreated,
            DateUpdated
        )
        VALUES
        (
            @nCredentialID,
            (@nAffNewBalance - @nAffOldBalance),
            @nAffOldBalance,
            @nAffNewBalance,
            @nAdjustmentTransactionNo,
            ISNULL(@pTransactionType, 2),
            DATEADD(HOUR,4,@nCreatedAt),
            ISNULL(@nRemarks, ''),
            null,
            ISNULL(@nCreatedBy, ''),
            GETDATE()
        )
        /* Add Cash Log */
        SET @oID = SCOPE_IDENTITY();
        --SELECT @oID AS ADJNO

        COMMIT TRANSACTION;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
