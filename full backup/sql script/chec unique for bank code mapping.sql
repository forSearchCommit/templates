select BankID from PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103

-- select * from ProviderBankCode where ProviderID = 38

select BankID from ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226

SELECT 'table1' AS source_table, COUNT(DISTINCT BankID) AS unique_values_count
FROM ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226
UNION
SELECT 'table2' AS source_table, COUNT(DISTINCT BankID) AS unique_values_count
FROM PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103
HAVING COUNT(DISTINCT BankID) = COUNT(DISTINCT BankID);

SELECT 'table1' AS source_table, BankID AS unique_value
FROM PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103
EXCEPT
SELECT 'table2' AS source_table, BankID AS unique_value
FROM ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226



SELECT 'table2' AS source_table, BankID AS unique_value
FROM ProviderBankCodeMapping where ProviderBankCodeID BETWEEN 3057 and 3226
EXCEPT
SELECT 'table1' AS source_table, BankID AS unique_value
FROM PaymentTypeGatewaySupportBankSetting where PaymentTypeGatewaySettingID = 1103;