
<details>
<summary>Some Queries</summary>

```sql
-- DECLARE 
--     @AffiliateCode NVARCHAR(100) = '083778',
-- 	@CredentialID BIGINT,
-- 	@MemberCode NVARCHAR(100) = 'kcUserR01',
-- 	@MemberCurrency NVARCHAR(10),
-- 	@Amount DECIMAL(20,4),
-- 	@Churn INT,
-- 	@RemarkType INT,
-- 	@Remark NVARCHAR(50),
-- 	@CreatedBy NVARCHAR(50)

-- SET @CredentialID = (SELECT CredentialID FROM Affiliate.AffiliateCodes WITH (NOLOCK) WHERE AffiliateCode ='083778');
-- DECLARE @CredentailIDSub BIGINT = @CredentialID; -- this Credentail ID may possible is a subUser Credentail ID
-- SELECT @CredentialID AS CredentialID, @CredentailIDSub AS CredentailIDSub

-- SELECT * FROM [dbo].[fn_n8Live_Member](NULL,@AffiliateCode,@MemberCode,NULL,NULL);
SELECT * from Affiliate.MMPayHistory

select * from tblPromotionCampaign where Title = 'test'
SELECT * FROM providers
select * from PaymentType
SELECT * from PaymentTypeGatewaySetting
SELECT * from PaymentOptionRoutingRulesSetting
select * from PaymentTypeGatewaySecureKey

-- select * from promotioncampaign h
```
</details>
