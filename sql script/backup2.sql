DECLARE @json NVARCHAR(MAX) = N'[
    {
        "DBCode": "SXCB",
        "Name": "绍兴银行",
        "Code": "SXCB"
    },
    {
        "DBCode": "TACCB",
        "Name": "泰安银行",
        "Code": "TACCB"
    },
    {
        "DBCode": "CITIC",
        "Name": "中信银行",
        "Code": "CNCB"
    }
]';

DECLARE @providerID INT = 38;

-- Create a table to store the JSON data
DECLARE @jsonTable TABLE (
    Code NVARCHAR(50),
    BankName NVARCHAR(MAX),
    DBCode NVARCHAR(50)
);

-- Parse the JSON data and insert it into the @jsonTable
INSERT INTO @jsonTable (Code, BankName, DBCode)
SELECT JSON_VALUE(value, '$.Code'), JSON_VALUE(value, '$.Name'), JSON_VALUE(value, '$.DBCode')
FROM OPENJSON(@json);

-- Create a table to store the results
DECLARE @TestTable TABLE (
    ProviderBankCodeID INT,
    BankName NVARCHAR(MAX),
    BankID INT
);

-- Insert data into @TestTable using a single query
INSERT INTO @TestTable (ProviderBankCodeID, BankName, BankID)
SELECT a.ProviderBankCodeID, jt.BankName, b.BankID
FROM ProviderBankCode a
CROSS JOIN Bank b
INNER JOIN @jsonTable jt ON a.code = jt.Code
WHERE a.ProviderID = @providerID
AND b.BankCode = jt.DBCode
AND b.BankName = jt.BankName
AND b.BankStatus = 1;

-- Select the final result from @TestTable
SELECT * FROM @TestTable;

