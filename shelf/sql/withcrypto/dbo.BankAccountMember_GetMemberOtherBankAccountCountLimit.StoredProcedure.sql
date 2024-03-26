USE [GCT_P003]
GO
/****** Object:  StoredProcedure [dbo].[BankAccountMember_GetMemberOtherBankAccountCountLimit]    Script Date: 12/10/2023 7:42:19 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccountMember_GetMemberOtherBankAccountCountLimit]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[BankAccountMember_GetMemberOtherBankAccountCountLimit]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- AUTHOR			: Feng Wei
-- MODIFIED DATE	: 12 OCT 2023
-- DESCRIPTION		: For Crypto
-- =============================================
CREATE PROCEDURE [dbo].[BankAccountMember_GetMemberOtherBankAccountCountLimit]
			@MemberID INT
AS

BEGIN
	IF EXISTS(
	SELECT 1 FROM Member M WITH (NOLOCK) 
	INNER JOIN MemberAccount MA WITH (NOLOCK) ON M.MemberID = MA.MemberID 
	INNER JOIN MemberDepositWithdrawalLimit MDWL (NOLOCK) ON MA.AccountID = MDWL.AccountID 
	WHERE M.MemberID = @MemberID AND MDWL.IsEdited = 1)
		BEGIN
			SELECT MaxOtherBankAccountSaved AS BankAccountCountLimit 
			FROM MemberDepositWithdrawalLimit WITH (NOLOCK) 
			WHERE AccountID = (SELECT AccountID FROM MemberAccount WITH(NOLOCK) WHERE MemberID = @MemberID)
		END
	ELSE
		BEGIN
			SELECT OtherAccountCountLimit AS BankAccountCountLimit 
			FROM PaymentLimit PL WITH (NOLOCK) 
			INNER JOIN MemberAccount MA ON PL.CurrencyCode = MA.CurrencyCode 
			WHERE MA.MemberID = @MemberID
		END
END
