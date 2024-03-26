USE [GCT_P003]
GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:              <Feng Wei>
-- Create date: <4/1/2024>
-- Description: <Campaign_Insert Vip Bonus>
-- =============================================

CREATE PROCEDURE [dbo].[VIPExperience_CreateVIPBonus_Campaign]
    @TransactionDate DATETIME2 = null,
    @BonusDate DATETIME2,
    @ExpiredDate DATETIME2 = null,
    @MemberID INTEGER,
    @MemberName NVARCHAR(100),
    @MemberVIPLevel INTEGER,
    @VIPBonusType INTEGER,
    @VIPBonusEventId NVARCHAR(100) = null,
    @Status INTEGER,
    @BonusAmount NUMERIC(20, 4),
    @ChurnRequired NUMERIC(20, 4),
    @AdjustmentTransactionNo NVARCHAR(20) = null,
    @ClaimDateUTC DATETIME2 = null,
    @ClaimBy NVARCHAR(100)= null,
    @DateCreated DATETIME2 = null,
    @CreatedBy NVARCHAR(100),
    @DateUpdated DATETIME2 = null,
    @UpdatedBy NVARCHAR(100) = null,
    @Remark NVARCHAR(350)  = '',
        @adjustmentReason NVARCHAR(100) = null,
        @churnMultiplierDisplay INT = null,
        @isDepositBonus BIT = null,
    @transactionReferenceNo VARCHAR(150) = null
AS
BEGIN
        SET NOCOUNT ON; 

    SELECT @MemberID = MemberID, @MemberVIPLevel = memberlevel from [dbo].[Member] where membername = @MemberName

    INSERT INTO [dbo].[VIPBonusTransaction]
            ([TransactionDate],[BonusDate],[ExpiredDate],[MemberID]
            ,[MemberName],[MemberVIPLevel],[VIPBonusType]
            ,[VIPBonusEventId],[Status],[BonusAmount]
            ,[ChurnRequired],[AdjustmentTransactionNo],[ClaimDateUTC]
            ,[ClaimBy],[DateCreated],[CreatedBy]
            ,[DateUpdated],[UpdatedBy],[Remark], [AdjustmentReason]
                        ,[ChurnMultiplierDisplay], [IsDepositBonus], [TransactionReferenceNo])
    VALUES
            (GETUTCDATE(),@BonusDate,@ExpiredDate,@MemberID
            ,@MemberName,@MemberVIPLevel,@VIPBonusType
            ,@VIPBonusEventId,@Status,@BonusAmount
            ,@ChurnRequired,@AdjustmentTransactionNo,@ClaimDateUTC
            ,@ClaimBy,GETDATE(),@CreatedBy
            ,@DateUpdated,@UpdatedBy,@Remark, @adjustmentReason
                        ,@churnMultiplierDisplay, @isDepositBonus, @transactionReferenceNo)

    SELECT SCOPE_IDENTITY();
END
Go