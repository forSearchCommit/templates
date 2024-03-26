/* 
Type : Checking
Script : Checking provider bank code mapping related information
. 
. Check bank code mapping uniqueness and count
. Check Payment Type Support Bank List uniqueness and count
. Compare check bank id value for both mapping and support bank list are the same
. 
 */

DECLARE @firstProviderBankCodeID int
DECLARE @lastProviderBankCodeID int

select Count(*) as NoOfProviderBankCode 
from ProviderBankCode
where ProviderID = 38

select Top 1 @firstProviderBankCodeID = ProviderBankCodeID
from ProviderBankCode
where providerID = 38
ORDER BY ProviderBankCodeID ASC;
select Top 1 @lastProviderBankCodeID = ProviderBankCodeID
from ProviderBankCode
where providerID = 38
ORDER BY ProviderBankCodeID DESC;

select @lastProviderBankCodeID - @firstProviderBankCodeID + 1 AS CheckIndexNo

select Count(*) as NumberOfProviderBankCodeMapping
from ProviderBankCodeMapping
where ProviderBankCodeID BETWEEN @firstProviderBankCodeID and @lastProviderBankCodeID

SELECT 'ProviderBankCodeMapping' AS source_table, BankID AS BankIDUniqueValue
FROM ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226
EXCEPT
SELECT 'PaymentTypeGatewaySupportBankSetting' AS source_table, BankID AS BankIDUniqueValue
FROM PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103;





select Count(*) as NumberOfSupportBank 
from PaymentTypeGatewaySupportBankSetting 
where PaymentTypeGatewaySettingID = 1103

SELECT 'table1' AS source_table, COUNT(DISTINCT BankID) AS unique_values_count
FROM ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226
UNION
SELECT 'table2' AS source_table, COUNT(DISTINCT BankID) AS unique_values_count
FROM PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103
HAVING COUNT(DISTINCT BankID) = COUNT(DISTINCT BankID);

-- select * from ProviderBankCode where ProviderID = 38

select BankID from ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226



SELECT 'table1' AS source_table, BankID AS unique_value
FROM PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103
EXCEPT
SELECT 'table2' AS source_table, BankID AS unique_value
FROM ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226







