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

DECLARE @startIndex INT, @endIndex INT, @jsonValue NVARCHAR(MAX), @jsonFragment NVARCHAR(MAX);
DECLARE @jsonTable TABLE (
    Code NVARCHAR(50),
    BankName NVARCHAR(MAX),
    DBCode NVARCHAR(50)
);

SET @startIndex = CHARINDEX('{', @json, 1);

WHILE @startIndex > 0
BEGIN

    SET @endIndex = CHARINDEX('}', @json, @startIndex);

    SET @jsonFragment = SUBSTRING(@json, @startIndex, @endIndex - @startIndex + 1);

    SET @jsonValue = JSON_VALUE(@jsonFragment, '$.Code');
    INSERT INTO @jsonTable (Code, BankName, DBCode)
    VALUES (@jsonValue, JSON_VALUE(@jsonFragment, '$.Name'), JSON_VALUE(@jsonFragment, '$.DBCode'));

    SET @startIndex = CHARINDEX('{', @json, @endIndex + 1);
END;

DECLARE @providerID INT = 38;
DECLARE @idx INT = 1;
DECLARE @TestTable TABLE (
    ProviderBankCodeID INT,
    BankName NVARCHAR(MAX),
    BankID INT
);


DECLARE @totalCount INT = (SELECT COUNT(*) FROM @jsonTable);
SELECT @totalCount AS Counting;
WHILE @idx <= @totalCount
BEGIN
    
    DECLARE @code NVARCHAR(50);
    DECLARE @dbCode NVARCHAR(50);
    DECLARE @dbBankName NVARCHAR(MAX);

    SELECT @code = JSON_VALUE(@json, CONCAT('$[', @idx - 1, '].Code')),
           @dbBankName = JSON_VALUE(@json, CONCAT('$[', @idx - 1, '].Name')),
           @dbCode = JSON_VALUE(@json, CONCAT('$[', @idx - 1, '].DBCode'));

    INSERT INTO @TestTable (ProviderBankCodeID,BankName, BankID)
    SELECT a.ProviderBankCodeID, b.BankName, b.BankID
    FROM ProviderBankCode a
    CROSS JOIN Bank b
    WHERE a.code = @code
    AND a.ProviderID = @providerID
    AND b.BankCode = @dbCode
    AND b.BankName = @dbBankName
    ANd b.BankStatus = 1;

    SET @idx = @idx + 1;
END;

DECLARE @IndexedTable TABLE (
    RowIndex INT,
    Code NVARCHAR(50),
    BankName NVARCHAR(MAX),
    DBCode NVARCHAR(50)
);

INSERT INTO @IndexedTable (RowIndex, Code,BankName, DBCode)
SELECT
    ROW_NUMBER() OVER (ORDER BY Code) AS RowIndex,
    Code,
    BankName,
    DBCode
FROM @jsonTable AS A
WHERE NOT EXISTS (
    SELECT 1
    FROM @TestTable AS B
    WHERE A.BankName = B.BankName
); 

DECLARE @idx2 INT = 1;
DECLARE @totalCount2 INT = (SELECT COUNT(*) FROM @IndexedTable);
WHILE @idx2 <= @totalCount2
BEGIN
    
    DECLARE @code2 NVARCHAR(50);
    DECLARE @dbCode2 NVARCHAR(50);
    DECLARE @dbBankName2 NVARCHAR(MAX);

    SELECT  @code2 = Code,
            @dbBankName2 = BankName,
            @dbCode2 = DBCode
    FROM @IndexedTable
    WHERE RowIndex = @idx2;

    INSERT INTO @TestTable (ProviderBankCodeID,BankName, BankID)
    SELECT a.ProviderBankCodeID, b.BankName, b.BankID
    FROM ProviderBankCode a
    CROSS JOIN Bank b
    WHERE a.code = @code2
    AND a.ProviderID = @providerID
    AND b.BankCode = @dbCode2
    ANd b.BankStatus = 1;

    SET @idx2 = @idx2 + 1;
END;

SELECT * from @TestTable