USE [GCT_P003]
/****** Object:  StoredProcedure [dbo].[BankAccount_GetBankListWithTransferInfoWithCrypto]    Script Date: 12/05/2015 3:50:44 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccount_GetBankListWithTransferInfoWithCrypto]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].BankAccount_GetBankListWithTransferInfoWithCrypto
GO
/****** Object:  StoredProcedure [dbo].[BankAccount_GetBankListWithTransferInfoWithCrypto]    Script Date: 12/05/2015 3:50:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccount_GetBankListWithTransferInfoWithCrypto]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ==============================================
-- Modify By     :	Feng Wei
-- Modify date   :  13/10/2023
-- Description   :	<,,>
-- =============================================

CREATE PROCEDURE [dbo].[BankAccount_GetBankListWithTransferInfoWithCrypto]
      @countryId Integer ,
	  @currencyId Integer,
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
        SELECT BankID,
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

		WHERE b.CountryID = @countryId AND b.CurrencyID = @currencyId AND b.BankURL IS NULL
		AND b.IsDisplayWithdrawal = 1 AND b.IsDeleted = 0 AND b.BankStatus = 1 ORDER BY b.BankName COLLATE Chinese_PRC_CI_AS
    END
    ELSE
    BEGIN
        SELECT BankID,
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

		WHERE b.CountryID = @countryId AND b.CurrencyID = @currencyId AND b.BankURL IS NOT NULL
		AND b.IsDisplayWithdrawal = 1 AND b.IsDeleted = 0 AND b.BankStatus = 1 ORDER BY b.BankName COLLATE Chinese_PRC_CI_AS
    END
    
	
END


' 
END
GO
