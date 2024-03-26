/****** Object:  StoredProcedure [dbo].[BankAccount_GetMatchedBankCodeByAccountNumberWithCrypto.]    Script Date: 12/05/2015 3:50:44 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccount_GetMatchedBankCodeByAccountNumberWithCrypto.]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BankAccount_GetMatchedBankCodeByAccountNumberWithCrypto.]
GO
/****** Object:  StoredProcedure [dbo].[BankAccount_GetMatchedBankCodeByAccountNumberWithCrypto.]    Script Date: 12/05/2015 3:50:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccount_GetMatchedBankCodeByAccountNumberWithCrypto.]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ==============================================
-- Modify By     :	Feng Wei
-- Modify date   :  16/10/2023
-- Description   :	Get Matched Bank Code
-- =============================================

CREATE PROCEDURE [dbo].[BankAccount_GetMatchedBankCodeByAccountNumberWithCrypto]
      @BankAccountNumber NVARCHAR(500)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT TOP 1 B.*
	FROM Bank B
	WHERE B.BankID = (
		SELECT BAM.BankID
		FROM BankAccountMember BAM
		WHERE BAM.BankAccountNo = @BankAccountNumber
	);
	
END

' 
END
GO
