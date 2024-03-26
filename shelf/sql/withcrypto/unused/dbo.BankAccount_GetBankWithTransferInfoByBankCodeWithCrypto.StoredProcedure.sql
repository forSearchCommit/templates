USE [GCT_P003]
/****** Object:  StoredProcedure [dbo].[BankAccount_GetBankWithTransferInfoByBankCodeWithCrypto]    Script Date: 12/05/2015 3:50:44 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccount_GetBankWithTransferInfoByBankCodeWithCrypto]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].BankAccount_GetBankWithTransferInfoByBankCodeWithCrypto
GO
/****** Object:  StoredProcedure [dbo].[BankAccount_GetBankWithTransferInfoByBankCodeWithCrypto]    Script Date: 12/05/2015 3:50:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccount_GetBankWithTransferInfoByBankCodeWithCrypto]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ==============================================
-- Modify By     :	Feng Wei
-- Modify date   :  13/10/2023
-- Description   :	<,,>
-- =============================================

CREATE PROCEDURE [dbo].[BankAccount_GetBankWithTransferInfoByBankCodeWithCrypto]
      @BankCode NVARCHAR(20),
	  @isCrypto BIT
AS
BEGIN

	SET NOCOUNT ON;

	-- THIS FIELD NAME MUST REFER TO DropdownListEntity.config
	DECLARE @BankProvinceFieldName NVARCHAR(30) = ''BankProvince'',
			@BankBranchFieldName NVARCHAR(30) = ''BankBranch'',
			@BankCityFieldName NVARCHAR(30) = ''BankCity''


	IF @isCrypto = 1 
    BEGIN
        SELECT TOP 1
		   BankID,
		   WebsiteID,
		   BankCode,
		   BankName,
		   [Description],
		   IsDisplayDeposit,
		   IsDisplayWithdrawal,
		   IsDeleted,
		   BankURL,
		   BankImage,
		   BankImageName,
           CountryID,
           CurrencyID,
		   ISNULL(BankStatus, 1) AS BankStatus,
		   IsPopular,
		   0 AS IsRequireBankProvince,
		   0 AS IsRequireBankBranch,
		   0 AS IsRequireBankCity
		FROM dbo.Bank AS b WITH(NOLOCK)

		WHERE b.BankCode = @BankCode 
    END
    ELSE
    BEGIN
        SELECT TOP 1
		   BankID,
		   WebsiteID,
		   BankCode,
		   BankName,
		   [Description],
		   IsDisplayDeposit,
		   IsDisplayWithdrawal,
		   IsDeleted,
		   BankURL,
		   BankImage,
		   BankImageName,
           CountryID,
           CurrencyID,
		   ISNULL(BankStatus, 1) AS BankStatus,
		   IsPopular,
		   ISNULL((SELECT TOP 1 IsEnabled FROM BankTransferInfoField btf (NOLOCK) WHERE btf.BankID = b.BankID AND btf.FieldName = @BankProvinceFieldName),0) AS IsRequireBankProvince,
		   ISNULL((SELECT TOP 1 IsEnabled FROM BankTransferInfoField btf (NOLOCK) WHERE btf.BankID = b.BankID AND btf.FieldName = @BankBranchFieldName),0) AS IsRequireBankBranch,
		   ISNULL((SELECT TOP 1 IsEnabled FROM BankTransferInfoField btf (NOLOCK) WHERE btf.BankID = b.BankID AND btf.FieldName = @BankCityFieldName),0) AS IsRequireBankCity
		FROM dbo.Bank AS b WITH(NOLOCK)

		WHERE b.BankCode = @BankCode 
    END

    
	
END


' 
END
GO