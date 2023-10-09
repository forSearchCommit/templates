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
        "DBCode": "TRCB",
        "Name": "天津农商银行",
        "Code": "TRCB"
    },
    {
        "DBCode": "XTB",
        "Name": "邢台银行",
        "Code": "XTB"
    },
    {
        "DBCode": "NXBANK",
        "Name": "宁夏银行",
        "Code": "NXBANK"
    },
    {
        "DBCode": "NXRCU",
        "Name": "宁夏黄河农村商业银行",
        "Code": "NXRCU"
    },
    {
        "DBCode": "WJRCB",
        "Name": "苏州农商银行",
        "Code": "WJRCB"
    },
    {
        "DBCode": "NMGNXS",
        "Name": "内蒙古农村信用社",
        "Code": "NMGNXS"
    },
    {
        "DBCode": "SRCB",
        "Name": "深圳农商银行",
        "Code": "SRCB"
    },
    {
        "DBCode": "ICBC",
        "Name": "工商银行",
        "Code": "ICBC"
    },
    {
        "DBCode": "CMB",
        "Name": "招商银行",
        "Code": "CMB"
    },
    {
        "DBCode": "CCB",
        "Name": "建设银行",
        "Code": "CCB"
    },
    {
        "DBCode": "BOC",
        "Name": "中国银行",
        "Code": "BOC"
    },
    {
        "DBCode": "ABC",
        "Name": "农业银行",
        "Code": "ABC"
    },
    {
        "DBCode": "CEB",
        "Name": "光大银行",
        "Code": "CEB"
    },
    {
        "DBCode": "CIB",
        "Name": "兴业银行",
        "Code": "CIB"
    },
    {
        "DBCode": "CMBC",
        "Name": "民生银行",
        "Code": "CMBC"
    },
    {
        "DBCode": "PSBC",
        "Name": "邮政银行",
        "Code": "PSBC"
    },
    {
        "DBCode": "NBBANK",
        "Name": "宁波银行",
        "Code": "NBBANK"
    },
    {
        "DBCode": "BJBANK",
        "Name": "北京银行",
        "Code": "BJBANK"
    },
    {
        "DBCode": "CZBANK",
        "Name": "浙商银行",
        "Code": "CZBANK"
    },
    {
        "DBCode": "GCB",
        "Name": "广州银行",
        "Code": "GCB"
    },
    {
        "DBCode": "CSCB",
        "Name": "长沙银行",
        "Code": "CSCB"
    },
    {
        "DBCode": "BGB",
        "Name": "广西北部湾银行",
        "Code": "BGB"
    },
    {
        "DBCode": "BOD",
        "Name": "东莞银行",
        "Code": "BOD"
    },
    {
        "DBCode": "HZCB",
        "Name": "杭州银行",
        "Code": "HZCB"
    },
    {
        "DBCode": "JLBANK",
        "Name": "吉林银行",
        "Code": "JLBANK"
    },
    {
        "DBCode": "NJCB",
        "Name": "南京银行",
        "Code": "NJCB"
    },
    {
        "DBCode": "EGBANK",
        "Name": "恒丰银行",
        "Code": "EGBANK"
    },
    {
        "DBCode": "SHBANK",
        "Name": "上海银行",
        "Code": "SHBANK"
    },
    {
        "DBCode": "HRBANK",
        "Name": "哈尔滨银行",
        "Code": "HRBANK"
    },
    {
        "DBCode": "QDCCB",
        "Name": "青岛银行",
        "Code": "QDCCB"
    },
    {
        "DBCode": "LSBANK",
        "Name": "莱商银行",
        "Code": "LSBANK"
    },
    {
        "DBCode": "QLBANK",
        "Name": "齐鲁银行",
        "Code": "QLBANK"
    },
    {
        "DBCode": "YTBANK",
        "Name": "烟台银行",
        "Code": "YTBANK"
    },
    {
        "DBCode": "CRCBANK",
        "Name": "重庆农村商业银行",
        "Code": "CRCBANK"
    },
    {
        "DBCode": "HBC",
        "Name": "湖北银行",
        "Code": "HBC"
    },
    {
        "DBCode": "ZGCCB",
        "Name": "自贡银行",
        "Code": "ZGCCB"
    },
    {
        "DBCode": "YZBANK",
        "Name": "银座村镇银行",
        "Code": "YZBANK"
    },
    {
        "DBCode": "BOYK",
        "Name": "营口银行",
        "Code": "BOYK"
    },
    {
        "DBCode": "LZYH",
        "Name": "兰州银行",
        "Code": "LZYH"
    },
    {
        "DBCode": "LSBC",
        "Name": "临商银行",
        "Code": "LSBC"
    },
    {
        "DBCode": "HRXJB",
        "Name": "华融湘江银行",
        "Code": "HRXJB"
    },
    {
        "DBCode": "DLB",
        "Name": "大连银行",
        "Code": "DLB"
    },
    {
        "DBCode": "CCQTGB",
        "Name": "重庆三峡银行",
        "Code": "CCQTGB"
    },
    {
        "DBCode": "DYCCB",
        "Name": "东营银行",
        "Code": "DYCCB"
    },
    {
        "DBCode": "GRCB",
        "Name": "广州农商银行",
        "Code": "GRCB"
    },
    {
        "DBCode": "FJNX",
        "Name": "福建农村信用社",
        "Code": "FJNX"
    },
    {
        "DBCode": "GHB",
        "Name": "广东华兴银行",
        "Code": "GHB"
    },
    {
        "DBCode": "CSRCB",
        "Name": "常熟农商银行",
        "Code": "CSRCB"
    },
    {
        "DBCode": "CDCB",
        "Name": "成都银行",
        "Code": "CDCB"
    },
    {
        "DBCode": "HKB",
        "Name": "汉口银行",
        "Code": "HKB"
    },
    {
        "DBCode": "SJBANK",
        "Name": "盛京银行",
        "Code": "SJBANK"
    },
    {
        "DBCode": "BOSZ",
        "Name": "苏州银行",
        "Code": "BOSZ"
    },
    {
        "DBCode": "TZCB",
        "Name": "台州银行",
        "Code": "TZCB"
    },
    {
        "DBCode": "WZCB",
        "Name": "温州银行",
        "Code": "WZCB"
    },
    {
        "DBCode": "ZZBANK",
        "Name": "郑州银行",
        "Code": "ZZBANK"
    },
    {
        "DBCode": "DLRCB",
        "Name": "大连农商银行",
        "Code": "DLRCB"
    },
    {
        "DBCode": "GSBANK",
        "Name": "甘肃银行",
        "Code": "GSBANK"
    },
    {
        "DBCode": "GYCB",
        "Name": "贵阳银行",
        "Code": "GYCB"
    },
    {
        "DBCode": "ZYCBANK",
        "Name": "贵州银行",
        "Code": "ZYCBANK"
    },
    {
        "DBCode": "HSBANK",
        "Name": "徽商银行",
        "Code": "HSBANK"
    },
    {
        "DBCode": "LANGFB",
        "Name": "廊坊银行",
        "Code": "LANGFB"
    },
    {
        "DBCode": "XABANK",
        "Name": "西安银行",
        "Code": "XABANK"
    },
    {
        "DBCode": "CDRCB",
        "Name": "成都农商银行",
        "Code": "CDRCB"
    },
    {
        "DBCode": "HKBEA",
        "Name": "东亚银行",
        "Code": "HKBEA"
    },
    {
        "DBCode": "BHB",
        "Name": "河北银行",
        "Code": "BHB"
    },
    {
        "DBCode": "ARCU",
        "Name": "安徽农村信用社",
        "Code": "ARCU"
    },
    {
        "DBCode": "BJRCB",
        "Name": "北京农商银行",
        "Code": "BJRCB"
    },
    {
        "DBCode": "CZCB",
        "Name": "浙江稠州商业银行",
        "Code": "CZCB"
    },
    {
        "DBCode": "GDRCC",
        "Name": "广东农村信用社",
        "Code": "GDRCC"
    },
    {
        "DBCode": "GXRCU",
        "Name": "广西农村信用社",
        "Code": "GXRCU"
    },
    {
        "DBCode": "GZRCU",
        "Name": "贵州农村信用社",
        "Code": "GZRCU"
    },
    {
        "DBCode": "HLJRCU",
        "Name": "黑龙江农村信用社",
        "Code": "HLJRCU"
    },
    {
        "DBCode": "HNRCU",
        "Name": "河南农村信用社",
        "Code": "HNRCU"
    },
    {
        "DBCode": "HURCB",
        "Name": "湖北农村信用社",
        "Code": "HURCB"
    },
    {
        "DBCode": "JLRCU",
        "Name": "吉林农村信用社",
        "Code": "JLRCU"
    },
    {
        "DBCode": "JSRCU",
        "Name": "江苏农村信用社",
        "Code": "JSRCU"
    },
    {
        "DBCode": "JXRCU",
        "Name": "江西农村信用社",
        "Code": "JXRCU"
    },
    {
        "DBCode": "MTBANK",
        "Name": "浙江民泰商业银行",
        "Code": "MTBANK"
    },
    {
        "DBCode": "SCRCU",
        "Name": "四川省农村信用联合社",
        "Code": "SCRCU"
    },
    {
        "DBCode": "SPDB",
        "Name": "浦发银行",
        "Code": "SPDB"
    },
    {
        "DBCode": "TCRCB",
        "Name": "太仓农村商业银行",
        "Code": "TCRCB"
    },
    {
        "DBCode": "TJBHB",
        "Name": "天津滨海农商银行",
        "Code": "TJBHB"
    },
    {
        "DBCode": "WHCCB",
        "Name": "威海商业银行",
        "Code": "WHCCB"
    },
    {
        "DBCode": "WHRCB",
        "Name": "武汉农村商业银行",
        "Code": "WHRCB"
    },
    {
        "DBCode": "YNRCC",
        "Name": "云南农村信用社",
        "Code": "YNRCC"
    },
    {
        "DBCode": "ZJNX",
        "Name": "浙江农村信用社",
        "Code": "ZJNX"
    },
    {
        "DBCode": "ZJTLCB",
        "Name": "浙江泰隆商业银行",
        "Code": "ZJTLCB"
    },
    {
        "DBCode": "BDCBANK",
        "Name": "保定银行",
        "Code": "BOB"
    },
    {
        "DBCode": "BOCD",
        "Name": "承德银行",
        "Code": "CDBANK"
    },
    {
        "DBCode": "BOHAIB",
        "Name": "渤海银行",
        "Code": "CBHB"
    },
    {
        "DBCode": "BOQH",
        "Name": "青海银行",
        "Code": "QHRC"
    },
    {
        "DBCode": "BOQZ",
        "Name": "泉州银行",
        "Code": "QZCCB"
    },
    {
        "DBCode": "CABANK",
        "Name": "长安银行",
        "Code": "CCAB"
    },
    {
        "DBCode": "CGNB",
        "Name": "四川天府银行",
        "Code": "PWEB"
    },
    {
        "DBCode": "CITIC",
        "Name": "中信银行",
        "Code": "CNCB"
    },
    {
        "DBCode": "COMM",
        "Name": "交通银行",
        "Code": "BCM"
    },
    {
        "DBCode": "CZRCB",
        "Name": "江南农村商业银行",
        "Code": "JNRCB"
    },
    {
        "DBCode": "DAQINGB",
        "Name": "龙江银行",
        "Code": "LJBANK"
    },
    {
        "DBCode": "DRCBCL",
        "Name": "东莞农村商业银行",
        "Code": "DRCB"
    },
    {
        "DBCode": "GLBANK",
        "Name": "桂林银行",
        "Code": "GLB"
    },
    {
        "DBCode": "H3CB",
        "Name": "内蒙古银行",
        "Code": "BOIMC"
    },
    {
        "DBCode": "HXBANK",
        "Name": "华夏银行",
        "Code": "HXB"
    },
    {
        "DBCode": "JJBANK",
        "Name": "九江银行",
        "Code": "JJCCB"
    },
    {
        "DBCode": "JNBANK",
        "Name": "济宁银行",
        "Code": "BOJN"
    },
    {
        "DBCode": "JSBANK",
        "Name": "江苏银行",
        "Code": "JSBC"
    },
    {
        "DBCode": "NHB",
        "Name": "南海农商银行",
        "Code": "NRCB"
    },
    {
        "DBCode": "SPABANK",
        "Name": "平安银行",
        "Code": "PAB"
    },
    {
        "DBCode": "SZSBK",
        "Name": "石嘴山银行",
        "Code": "SZSCCB"
    },
    {
        "DBCode": "ZBCB",
        "Name": "齐商银行",
        "Code": "QSB"
    },
    {
        "DBCode": "ZRCBANK",
        "Name": "张家港农商银行",
        "Code": "RCBOZ"
    },
    {
        "DBCode": "ZYB",
        "Name": "中原银行",
        "Code": "ZYBANK"
    },
    {
        "DBCode": "ZZYH",
        "Name": "枣庄银行",
        "Code": "ZZB"
    }
]';
DECLARE @jsonTable TABLE (
    Code NVARCHAR(50),
    BankName NVARCHAR(MAX),
    DBCode NVARCHAR(50)
);


DECLARE @providerID INT = 38;
DECLARE @idx INT = 1;
DECLARE @TestTable TABLE (
    ProviderBankCodeID INT,
    BankName NVARCHAR(MAX),
    BankID INT
);

INSERT INTO @jsonTable (Code,BankName, DBCode)
SELECT JSON_VALUE(value, '$.Code'), JSON_VALUE(value, '$.Name'), JSON_VALUE(value, '$.DBCode')
FROM OPENJSON(@json);

DECLARE @totalCount INT = (SELECT COUNT(*) FROM @jsonTable);
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

INSERT INTO ProviderBankCodeMapping(ProviderBankCodeID, BankID)
SELECT ProviderBankCodeID, BankID
FROM @TestTable