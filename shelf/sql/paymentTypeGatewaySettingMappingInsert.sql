DECLARE @json NVARCHAR(MAX) = N'[
    {
        "DBCode": "SPABANK",
        "Name": "平安银行",
        "Code": "HPT00024"
    },
    {
        "DBCode": "CIB",
        "Name": "兴业银行",
        "Code": "HPT00008"
    },
    {
        "DBCode": "BJBANK",
        "Name": "北京银行",
        "Code": "HPT00025"
    }
]';
DECLARE @jsonTable TABLE (
    Code NVARCHAR(50),
    BankName NVARCHAR(MAX),
    DBCode NVARCHAR(50)
);
INSERT INTO @jsonTable (Code,BankName, DBCode)
SELECT JSON_VALUE(value, '$.Code'), JSON_VALUE(value, '$.Name'), JSON_VALUE(value, '$.DBCode')
FROM OPENJSON(@json);

DECLARE @BankIDT INT;
DECLARE @Provider INT = 40,
        @PaymentTypeGatewaySettingID INT = 1106,
        @InternalAuditID INT = NULL

DECLARE @Index INT = 1
DECLARE @JsonCount INT = (SELECT COUNT(*) FROM @jsonTable)

WHILE @Index <= @JsonCount
BEGIN

    DECLARE @Code NVARCHAR(50);
    DECLARE @DBCode NVARCHAR(50);
    DECLARE @dbBankName NVARCHAR(MAX);

    SELECT @Code = JSON_VALUE(@json, CONCAT('$[', @Index - 1, '].Code')),
           @dbBankName = JSON_VALUE(@json, CONCAT('$[', @Index - 1, '].Name')),
           @DBCode = JSON_VALUE(@json, CONCAT('$[', @Index - 1, '].DBCode'));

    IF NOT EXISTS (
        SELECT 1
        FROM ProviderBankCode a
        CROSS JOIN Bank b
        WHERE a.code = @Code
            AND a.ProviderID = 38
            AND b.BankCode = @DBCode
            AND EXISTS (
                SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK)
                WHERE PaymentTypeGatewaySettingID = 1106
                AND BankID = b.BankID
            )
        
    )
    BEGIN
        SELECT @BankIDT = b.BankID
        FROM ProviderBankCode a
        CROSS JOIN Bank b
        WHERE a.code = @Code
            AND a.ProviderID = 38
            AND b.BankCode = @DBCode
            AND NOT EXISTS (
                SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK)
                WHERE PaymentTypeGatewaySettingID = 1106
                AND BankID = b.BankID
            )

        INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, InternalAuditID, BankID)
        SELECT @PaymentTypeGatewaySettingID, @InternalAuditID, @BankIDT
    END
    SET @Index = @Index + 1
END

