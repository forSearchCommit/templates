USE [GCT_P003]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccountMember_InsertStatusUpdateAuditLogWithCrypto]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BankAccountMember_GetMemberBankAccountDataWithCrypto]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccountMember_InsertStatusUpdateAuditLogWithCrypto]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Feng Wei
-- Create date: 21/11/2023
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BankAccountMember_InsertStatusUpdateAuditLogWithCrypto]
	@memberName NVARCHAR(MAX),
	@oldStatus NVARCHAR(MAX),
	@newStatus NVARCHAR(MAX),
	@bankAccountID Integer
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[AuditLogBankAccountMember] (ActionID, UserCreated, DateCreated, ReferenceNo, OldValue, NewValue, AuditLogAttributeID) 
	VALUES (5000, @memberName, GETDATE(), @bankAccountID, @oldStatus, @newStatus, 5048); 
END
' 
END
GO
