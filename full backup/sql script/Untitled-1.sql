SELECT ProviderBankCodeID, COUNT(*) as count
FROM @TestTable
GROUP BY ProviderBankCodeID
HAVING COUNT(*) > 1;

-- SELECT * FROM @TestTable
-- where ProviderBankCodeID=3110 OR ProviderBankCodeID=3130 OR ProviderBankCodeID=3187 OR ProviderBankCodeID=3190

-- select * from bank
-- where BankID=132 OR BankID=163

-- select * from bank
-- where BankID=144

-- select * from ProviderBankCode
-- where ProviderBankCodeID=3059

-- SELECT DISTINCT B.BankName
-- FROM @TestTable B
-- LEFT JOIN @jsonTable A ON B.BankName = A.BankName
-- WHERE B.BankName IS NULL;

-- SELECT BankName
-- FROM @jsonTable
-- GROUP BY BankName
-- HAVING COUNT(*) > 1;

-- SELECT Code
-- FROM @jsonTable
-- GROUP BY Code
-- HAVING COUNT(*) > 1;

-- SELECT DBCode
FROM @jsonTable
GROUP BY DBCode
HAVING COUNT(*) > 1;

select * from Bank
where BankName = N'四川省农村信用联合社'

select *  from Bank
where BankCode = 'SCRCUe'
-- select * from @jsonTable

SELECT * FROM @TestTable;

SELECT *
FROM @jsonTable AS A
WHERE NOT EXISTS (
    SELECT 1
    FROM @TestTable AS B
    WHERE A.BankName = B.BankName
);

SELECT * FROM @IndexedTable;
SELECT * FROM @TestTable;

