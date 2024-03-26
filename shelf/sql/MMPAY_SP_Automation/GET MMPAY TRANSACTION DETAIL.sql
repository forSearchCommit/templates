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
-- Description:	GET MMPAY TRANSACTION DETAIL
-- =============================================

IF EXISTS(
    SELECT 1 
    FROM information_schema.ROUTINES WITH (NOLOCK)
    WHERE ROUTINE_TYPE = 'PROCEDURE'
    AND ROUTINE_NAME = 'AffiliateInfos_MMPayTransactionDetails_Get'
    AND SPECIFIC_SCHEMA = 'Affiliate'
)
BEGIN
    DROP PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_Get];
END
GO

CREATE PROCEDURE [Affiliate].[AffiliateInfos_MMPayTransactionDetails_Get]
	-- Add the parameters for the stored procedure here
    --@MMPayTransactionId BIGINT,
    @TransactionNumber NVARCHAR(MAX),
    @MemberCode NVARCHAR(MAX),
    @AffiliateCode NVARCHAR(MAX),
    @MemberCurrency NVARCHAR(10) ,
    @Status INT ,
    @ModifiedDateFrom DATETIME ,
    @ModifiedDateTo DATETIME ,
    @TransactionDateFrom DATETIME ,
    @TransactionDateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRANSACTION
    BEGIN TRY
        SELECT
            * 
        FROM [Affiliate].[MMPayTransactionDetails] B WITH (NOLOCK)
        WHERE
            (@TransactionNumber IS NOT NULL AND B.TransactionNumber = @TransactionNumber OR @TransactionNumber IS NULL)
            AND
            (@MemberCode IS NOT NULL AND B.MemberCode LIKE @MemberCode OR @MemberCode IS NULL)
            AND
            (@MemberCurrency IS NOT NULL AND B.MemberCurrency = @MemberCurrency OR @MemberCurrency IS NULL)
            AND
            (@Status IS NOT NULL AND B.Status = @Status OR @Status IS NULL)
            AND
            (@ModifiedDateFrom IS NOT NULL AND B.ModifiedDate >= @ModifiedDateFrom OR @ModifiedDateFrom IS NULL)
            AND
            (@ModifiedDateTo IS NOT NULL AND B.ModifiedDate <= @ModifiedDateTo OR @ModifiedDateTo IS NULL)
            AND
            (@TransactionDateFrom IS NOT NULL AND B.TransactionDate >= @TransactionDateFrom OR @TransactionDateFrom IS NULL)
            AND
            (@TransactionDateTo IS NOT NULL AND B.TransactionDate <= @TransactionDateTo OR @TransactionDateTo IS NULL)
            AND B.AffiliateCode = @AffiliateCode
        ORDER BY B.TransactionDate DESC

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO
