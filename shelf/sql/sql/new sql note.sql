
-- select top 3 * from Spw_DrawPrizeList order by CreatedDate desc

-- select top 3 * from Spw_PrizeGrpList order by CreatedDate desc
-- select top 3 * from Spw_PrizeGrpList order by CreatedDate desc

-- declare @UpdatedList as table ( WinCombinationCountId bigint, DisplayName NVARCHAR(MAX))

-- insert into Slot_WinCombinationCount
-- (TotalCount, RemainCount, DisplayName, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, InitialAssignCount, DrawId)
-- output inserted.WinCombinationCountId, inserted.DisplayName into @UpdatedList
-- VALUES
-- (10 , 10, '10' , GETUTCDATE(), '10' , GETUTCDATE(), '10', '10',579),
-- (10 , 10, '11' , GETUTCDATE(), '10' , GETUTCDATE(), '10', '10',579),
-- (10 , 10, '12' , GETUTCDATE(), '10' , GETUTCDATE(), '10', '10',579)
-- SELECT * FROM @UpdatedList;

-- select * from [Spw_PrizeGrpList]
-- join Slot_WinCombinationCount on Slot_WinCombinationCount.WinCombinationCountId = Spw_PrizeGrpList.WinCombinationCountId
-- where Spw_PrizeGrpList.DrawId = 579
-- order by Spw_PrizeGrpList.CreatedDate desc
-- select * from Spw_DrawResult where DrawId = 579 and RoundNo = 4
-- select * from Spw_DrawResult where DrawId = 579 and RoundNo = 6

-- select * from Spw_PrizeGrpList order by CreatedDate desc
-- select * from Spw_PrizeList order by CreatedDate desc
-- select * from Slot_WinCombinationCount order by CreatedDate desc


-- select top 1 * from tblCampaignDetails order by CreatedDate desc
-- select * from Slot_SpinSetting order by CreatedDate desc
-- select * from Slot_SpinSettingDetail ORDER by CreatedDate desc


-- select * from Spw_DrawPrizeList
-- select top 1 * from PaymentOption where PaymentOptionId = 8
-- -- select top 3 * from PaymentType ORDER BY PaymentTypeID DESC
-- -- select top 3 * from Providers ORDER BY ProviderID DESC
-- -- select  top 4 * from PaymentTypeGatewaySetting order by PaymentTypeGatewaySettingID DESC
-- -- select  top 3 * from PaymentOptionRoutingRulesSetting order by RoutingRulesSettingID DESC
-- -- select  top 3 * from PaymentTypeControlStatus order by PaymentTypeControlStatusID DESC
-- -- select top 3 * from PaymentTypeGatewaySecureKey order by SecureKeyID DESC

-- -- select * from PaymentOptionType
-- select top 1 * from PaymentOptionType where PaymentOptionTypeID = 8
-- select * from bank where bankid = 12

-- select * from ProviderBankCode

-- select * from PaymentTypeGatewaySecureKey

-- -- SELECT TOP 5 * FROM [dbo].[ProviderBankCode] ORDER BY ProviderBankCodeID DESC 
-- select * from ProviderBankCode where ProviderID = 41 AND Name = N'中信银行'
-- select * from Bank where BankName = N'中信银行'
-- select * from ProviderBankCode where ProviderID = 41 AND Name = N'农业银行'
-- select * from Bank where BankName = N'农业银行'
-- select * from PaymentOptionType where PaymentOptionTypeID = 24
-- select * from PaymentOption where PaymentOptionTypeID = 24
-- select * from paymentoption where paymentoptionid = 16
-- select * from PaymentOptionType WHERE paymentoptiontypeid = 14

-- SELECT * from ProviderBankCodeMapping 

-- select * from Bank

-- select * from PaymentType
-- -- select* from PaymentOptionType
-- select * from providerbankcode where ProviderID = 38
-- select * from ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226
-- select* from paymentoption where PaymentOptionTypeID = 24

-- select * from PaymentTypeGatewaySecureKey
-- select * from
-- select * from PaymentTypeGatewaySupportBankSetting
-- select * from bank where BankCode = 'SDRCU'
-- select * from bank where BankCode = 'SCRCU'
-- select * from ProviderBankCodeMapping
-- -- select * from pro
-- -- 3227
-- -- 3472

-- select * from PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1107

-- select * from ProviderBankCode

-- select Top 1 ProviderBankCodeID
-- from ProviderBankCode
-- where providerID = 40
-- ORDER BY ProviderBankCodeID ASC;

-- select Top 1 * 
-- from ProviderBankCode
-- where providerID = 38
-- ORDER BY ProviderBankCodeID DESC;

-- select * from bank where BankCode = 'JRCB'

-- select *  from ProviderBankCodeMapping
-- select * from PaymentTypeGatewaySupportBankSetting

-- select * from member where MemberName = 'kcUserR01'
-- select * from paymenttype
-- select * from PaymentTypeGatewaySetting
-- select * from paymentoption where paymentoptiontypeid = 8
-- select * from PaymentOptionRoutingRulesSetting
-- select * from ProviderBankCode where ProviderID  =41
-- SELECT TOP 5 * FROM [dbo].[ProviderBankCode] ORDER BY ProviderBankCodeID DESC 
-- -- DELETE FROM [dbo].[ProviderBankCode] WHERE ProviderID = 41;
-- INSERT INTO [dbo].[ProviderBankCode] ([ProviderBankCodeID], [Name], [Code], [Icon], [ProviderID]) 
-- VALUES 
-- (3473,N'中国工商银行','1','',41)
-- select * from ProviderBankCodeMapping

-- select * from providers WHERE ProviderName LIKE '%M%' ORDER BY ProviderName ASC
-- select * from PaymentType WHERE Name Like'%MM%' order BY Name ASC
-- select * from PaymentTypeGatewaySetting where PaymentTypeID = 47
-- select * from PaymentTypeGatewaySecureKey WHERE PaymentTypeGatewaySettingID = 1047
-- -- select * from PaymentTypeGatewaySupportBankSetting  WHERE PaymentTypeGatewaySettingID = 1047
-- SELECT * FROM PaymentTypeControlStatus WHERE PAYMENTTYPEID = 47
-- SELECT * FROM PaymentOptionRoutingRulesSetting WHERE PaymentTypeGatewaySettingID = 1047
-- -- PAYMENTOPTIONTYPEID = 16
-- PAYMENTOPTIONID = 18
-- select * from Member where MemberName = 'kcUserR01'
-- -- select * from Affiliate
-- -- select * from 
-- --  where MemberName = 'uattest'


-- select * from Website

-- select * from Affiliate.AffiliateInfo
-- SELECT * from PaymentTypeGatewaySetting
-- select * from Affiliate.Adjustments 
-- DECLARE 
-- @affCode NVARCHAR(50) = '083778',
-- @creId NVARCHAR(50),
-- @memberCode INT 
-- aff code for downline REFERENCES
-- aff unique id
-- downline membername in member dbo
-- SELECT @creId = CredentialID from affiliate.AffiliateCodes where AffiliateCode = @affCode
-- SELECT * from affiliate.MMPayHistory where CredentialID = @creId
-- select * from Affiliate.Adjustments where TransferAffiliateCode = @creId
-- SELECT * from affiliate.AffiliateInfos where CredentialID = @creId


