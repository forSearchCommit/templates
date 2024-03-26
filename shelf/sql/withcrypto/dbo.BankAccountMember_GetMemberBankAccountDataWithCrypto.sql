USE [GCT_P003]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccountMember_GetMemberBankAccountDataWithCrypto]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BankAccountMember_GetMemberBankAccountDataWithCrypto]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccountMember_GetMemberBankAccountDataWithCrypto]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Feng Wei
-- Create date: 12/10/2023
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BankAccountMember_GetMemberBankAccountDataWithCrypto]
	@memberID Integer,
	@isCrypto BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @isCrypto = 1
    BEGIN
        SELECT *
		FROM dbo.BankAccountMember t1
		LEFT JOIN dbo.MemberAccount t2 ON t2.AccountID = t1.AccountID
		LEFT JOIN dbo.Bank t3 ON t3.BankID = t1.BankID
		WHERE 
		t2.MemberID = @memberID AND
		t3.BankURL IS NULL;
    END
    ELSE
    BEGIN
        SELECT *
		FROM dbo.BankAccountMember t1
		LEFT JOIN dbo.MemberAccount t2 ON t2.AccountID = t1.AccountID
		LEFT JOIN dbo.Bank t3 ON t3.BankID = t1.BankID
		WHERE 
		t2.MemberID = @memberID AND
		t3.BankURL IS NOT NULL;
    END
	

END
' 
END
GO
