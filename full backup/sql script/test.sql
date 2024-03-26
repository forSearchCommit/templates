-- select * from PaymentTypeGatewaySupportBankSetting
-- ORDER BY PaymentTypeGatewaySettingID DESC

SELECT * FROM PaymentTypeGatewaySupportBankSetting
where PaymentTypeGatewaySettingID = 1103

-- SELECT 1
-- FROM ProviderBankCode a
-- CROSS JOIN Bank b
-- WHERE a.code = 'SXCB'
--     AND a.ProviderID = 38
--     AND b.BankCode = 'SXCB'r
--     AND EXISTS (
--         SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK)
--         WHERE PaymentTypeGatewaySettingID = 1103
--         AND BankID = b.BankID
--     )

-- select * from bank where BankID = 12
-- select * from ProviderBankCode where ProviderBankCodeID = 3128
-- DELETE FROM PaymentTypeGatewaySupportBankSetting
-- WHERE PaymentTypeGatewaySettingID = 1103;


-- SELECT 1
-- FROM PaymentTypeGatewaySupportBankSetting a
-- WHERE a.PaymentTypeGatewaySettingID = 1100
-- AND a.BankID = 46

-- SELECT 1103, b.BankID
-- FROM ProviderBankCode a
-- CROSS JOIN Bank b
-- WHERE a.code = 'CNCB'
--     AND a.ProviderID = 38
--     AND b.BankCode = 'CITIC'

-- SELECT *
-- FROM [dbo].[PaymentTypeGatewaySupportBankSetting] p
-- INNER JOIN ProviderBankCode a ON p.BankID = 12
-- INNER JOIN Bank b ON b.BankCode = a.Code
-- WHERE p.PaymentTypeGatewaySettingID = 1103
--     AND a.ProviderID =38
--     AND a.Code = 'CNCB'
-- SELECT Top 1 * FROM PaymentTypeGatewaySupportBankSetting
-- WHERE PaymentTypeGatewaySettingID = 1103
-- ORDER BY SupportBankSettingId ASC

-- SELECT Top 1 * FROM PaymentTypeGatewaySupportBankSetting
-- WHERE PaymentTypeGatewaySettingID = 1103
-- ORDER BY SupportBankSettingId DESC

-- select * from ProviderBankCode
-- where ProviderID = 38

-- select * 
-- from ProviderBankCodeMapping
-- where BankID IN (
--     SELECT BankID
--     FROM ProviderBankCodeMapping
--     GROUP BY BankID
--     HAVING COUNT(BankID) > 1
-- )
-- AND ProviderBankCodeID BETWEEN 3057 and 32263.;
-- -- AND BankID = 144
-- SELECT BankID
-- FROM ProviderBankCodeMapping
-- WHERE ProviderBankCodeMappingID BETWEEN 3057 and 32263 -- Specify your desired range
-- GROUP BY BankID
-- HAVING COUNT(BankID) > 1;

-- select * from ProviderBankCodeMapping where ProviderBankCodeMappingID BETWEEN 3057 and 32263
-- SELECT 1
--         FROM ProviderBankCode a
--         CROSS JOIN Bank b
--         WHERE a.code = 'CNCB'
--             AND a.ProviderID = 38
--             AND b.BankCode = 'CITIC'
--             AND EXISTS (
--                 SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK)
--                 WHERE PaymentTypeGatewaySettingID = 1103
--                 AND BankID = b.BankID
--             )

-- SELECT BankID
-- FROM ProviderBankCode a
-- CROSS JOIN Bank b
-- WHERE a.code = 'CNCB'
-- AND a.ProviderID = 38
-- AND b.BankCode = 'CITIC'

-- SELECT top 1 *  from ProviderBankCodeMapping
SELECT top 1 * from PaymentTypeGatewaySupportBankSetting

-- select * from ProviderBankCode where ProviderID = 38

-- SELECT *
-- FROM ProviderBankCodeMapping a
-- CROSS JOIN ProviderBankCode b
-- WHERE a.ProviderBankCodeID BETWEEN 3057 and 32263
