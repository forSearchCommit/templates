DECLARE @json NVARCHAR(MAX) = N'[
    {
        "DBCode": "CMBC",
        "Name": "民生银行",
        "Code": "HPT00009"
    },
    {
        "DBCode": "SPDB",
        "Name": "浦发银行",
        "Code": "HPT00192"
    },
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
    },
    {
        "DBCode": "BOHAIB",
        "Name": "渤海银行",
        "Code": "HPT00029"
    },
    {
        "DBCode": "NBBANK",
        "Name": "宁波银行",
        "Code": "HPT00030"
    },
    {
        "DBCode": "BJRCB",
        "Name": "北京农商银行",
        "Code": "HPT00032"
    },
    {
        "DBCode": "NJCB",
        "Name": "南京银行",
        "Code": "HPT00028"
    },
    {
        "DBCode": "CZBANK",
        "Name": "浙商银行",
        "Code": "HPT00037"
    },
    {
        "DBCode": "SHBANK",
        "Name": "上海银行",
        "Code": "HPT00027"
    },
    {
        "DBCode": "SHRCB",
        "Name": "上海农商银行",
        "Code": "HPT00033"
    },
    {
        "DBCode": "HZCB",
        "Name": "杭州银行",
        "Code": "HPT00035"
    },
    {
        "DBCode": "CZCB",
        "Name": "浙江稠州商业银行",
        "Code": "HPT00034"
    },
    {
        "DBCode": "HKB",
        "Name": "汉口银行",
        "Code": "HPT00177"
    },
    {
        "DBCode": "CSCB",
        "Name": "长沙银行",
        "Code": "HPT00067"
    },
    {
        "DBCode": "GRCB",
        "Name": "广州农商银行",
        "Code": "HPT00044"
    },
    {
        "DBCode": "EGBANK",
        "Name": "恒丰银行",
        "Code": "HPT00077"
    },
    {
        "DBCode": "HSBANK",
        "Name": "徽商银行",
        "Code": "HPT00039"
    },
    {
        "DBCode": "BOD",
        "Name": "东莞银行",
        "Code": "HPT00068"
    },
    {
        "DBCode": "XMBANK",
        "Name": "厦门银行",
        "Code": "HPT00101"
    },
    {
        "DBCode": "JLBANK",
        "Name": "吉林银行",
        "Code": "HPT00053"
    },
    {
        "DBCode": "GCB",
        "Name": "广州银行",
        "Code": "HPT00041"
    },
    {
        "DBCode": "DLB",
        "Name": "大连银行",
        "Code": "HPT00140"
    },
    {
        "DBCode": "TCCB",
        "Name": "天津银行",
        "Code": "HPT00146"
    },
    {
        "DBCode": "ZZBANK",
        "Name": "郑州银行",
        "Code": "HPT00075"
    },
    {
        "DBCode": "NHB",
        "Name": "南海农商银行",
        "Code": "HPT00135"
    },
    {
        "DBCode": "HBC",
        "Name": "湖北银行",
        "Code": "HPT00061"
    },
    {
        "DBCode": "QDCCB",
        "Name": "青岛银行",
        "Code": "HPT00109"
    },
    {
        "DBCode": "CDCB",
        "Name": "成都银行",
        "Code": "HPT00076"
    },
    {
        "DBCode": "BHB",
        "Name": "河北银行",
        "Code": "HPT00038"
    },
    {
        "DBCode": "ZJTLCB",
        "Name": "浙江泰隆商业银行",
        "Code": "HPT00188"
    },
    {
        "DBCode": "WZCB",
        "Name": "温州银行",
        "Code": "HPT00201"
    },
    {
        "DBCode": "FDB",
        "Name": "富滇银行",
        "Code": "HPT00036"
    },
    {
        "DBCode": "ZJNX",
        "Name": "浙江农村信用社",
        "Code": "HPT00049"
    },
    {
        "DBCode": "NYBANK",
        "Name": "广东南粤银行",
        "Code": "HPT00158"
    },
    {
        "DBCode": "BOSZ",
        "Name": "苏州银行",
        "Code": "HPT00217"
    },
    {
        "DBCode": "CSRCB",
        "Name": "常熟农商银行",
        "Code": "HPT00154"
    },
    {
        "DBCode": "ZYB",
        "Name": "中原银行",
        "Code": "HPT00108"
    },
    {
        "DBCode": "ZBCB",
        "Name": "齐商银行",
        "Code": "HPT00110"
    },
    {
        "DBCode": "CRCBANK",
        "Name": "重庆农村商业银行",
        "Code": "HPT00060"
    },
    {
        "DBCode": "GXRCU",
        "Name": "广西农村信用社",
        "Code": "HPT00042"
    },
    {
        "DBCode": "HRXJB",
        "Name": "华融湘江银行",
        "Code": "HPT00132"
    },
    {
        "DBCode": "CGNB",
        "Name": "四川天府银行",
        "Code": "HPT00065"
    },
    {
        "DBCode": "GLBANK",
        "Name": "桂林银行",
        "Code": "HPT00058"
    },
    {
        "DBCode": "CZRCB",
        "Name": "江南农村商业银行",
        "Code": "HPT00178"
    },
    {
        "DBCode": "WHRCB",
        "Name": "武汉农村商业银行",
        "Code": "HPT00093"
    },
    {
        "DBCode": "BGB",
        "Name": "广西北部湾银行",
        "Code": "HPT00051"
    },
    {
        "DBCode": "RZB",
        "Name": "日照银行",
        "Code": "HPT00069"
    },
    {
        "DBCode": "QLBANK",
        "Name": "齐鲁银行",
        "Code": "HPT00244"
    },
    {
        "DBCode": "JJBANK",
        "Name": "九江银行",
        "Code": "HPT00055"
    },
    {
        "DBCode": "GZB",
        "Name": "赣州银行",
        "Code": "HPT00080"
    },
    {
        "DBCode": "HRBANK",
        "Name": "哈尔滨银行",
        "Code": "HPT00100"
    },
    {
        "DBCode": "TZCB",
        "Name": "台州银行",
        "Code": "HPT00092"
    },
    {
        "DBCode": "GHB",
        "Name": "广东华兴银行",
        "Code": "HPT00157"
    },
    {
        "DBCode": "SJBANK",
        "Name": "盛京银行",
        "Code": "HPT00081"
    },
    {
        "DBCode": "DRCBCL",
        "Name": "东莞农村商业银行",
        "Code": "HPT00111"
    },
    {
        "DBCode": "FXCB",
        "Name": "阜新银行",
        "Code": "HPT00236"
    },
    {
        "DBCode": "YTBANK",
        "Name": "烟台银行",
        "Code": "HPT00070"
    },
    {
        "DBCode": "H3CB",
        "Name": "内蒙古银行",
        "Code": "HPT00127"
    },
    {
        "DBCode": "BOYK",
        "Name": "营口银行",
        "Code": "HPT00218"
    },
    {
        "DBCode": "JHBANK",
        "Name": "金华银行",
        "Code": "HPT00231"
    },
    {
        "DBCode": "DAQINGB",
        "Name": "龙江银行",
        "Code": "HPT00245"
    },
    {
        "DBCode": "TACCB",
        "Name": "泰安银行",
        "Code": "HPT00184"
    },
    {
        "DBCode": "LSBC",
        "Name": "临商银行",
        "Code": "HPT00119"
    },
    {
        "DBCode": "DYCCB",
        "Name": "东营银行",
        "Code": "HPT00088"
    },
    {
        "DBCode": "XABANK",
        "Name": "西安银行",
        "Code": "HPT00074"
    },
    {
        "DBCode": "ZJKCCB",
        "Name": "张家口银行",
        "Code": "HPT00062"
    },
    {
        "DBCode": "BOCD",
        "Name": "承德银行",
        "Code": "HPT00165"
    },
    {
        "DBCode": "TRCB",
        "Name": "天津农商银行",
        "Code": "HPT00091"
    },
    {
        "DBCode": "SRBANK",
        "Name": "上饶银行",
        "Code": "HPT00116"
    },
    {
        "DBCode": "NBYZ",
        "Name": "鄞州银行",
        "Code": "HPT00229"
    },
    {
        "DBCode": "BOQZ",
        "Name": "泉州银行",
        "Code": "HPT00183"
    },
    {
        "DBCode": "LSBANK",
        "Name": "莱商银行",
        "Code": "HPT00084"
    },
    {
        "DBCode": "KLB",
        "Name": "昆仑银行",
        "Code": "HPT00170"
    },
    {
        "DBCode": "GSBANK",
        "Name": "甘肃银行",
        "Code": "HPT00071"
    },
    {
        "DBCode": "UBCHN",
        "Name": "海口联合农商银行",
        "Code": "HPT00195"
    },
    {
        "DBCode": "HXBANK",
        "Name": "华夏银行",
        "Code": "HPT00010"
    },
    {
        "DBCode": "GDB",
        "Name": "广发银行",
        "Code": "HPT00023"
    },
    {
        "DBCode": "GDRCC",
        "Name": "广东农村信用社",
        "Code": "HPT00156"
    },
    {
        "DBCode": "CDRCB",
        "Name": "成都农商银行",
        "Code": "HPT00164"
    },
    {
        "DBCode": "GYCB",
        "Name": "贵阳银行",
        "Code": "HPT00073"
    },
    {
        "DBCode": "DYCB",
        "Name": "长城华西银行",
        "Code": "HPT00232"
    },
    {
        "DBCode": "FJHXBC",
        "Name": "福建海峡银行",
        "Code": "HPT00066"
    },
    {
        "DBCode": "ZYCBANK",
        "Name": "贵州银行",
        "Code": "HPT00078"
    },
    {
        "DBCode": "BOHN",
        "Name": "海南农村信用社",
        "Code": "HPT00054"
    },
    {
        "DBCode": "KSRB",
        "Name": "昆山农商银行",
        "Code": "HPT00171"
    },
    {
        "DBCode": "XJRCU",
        "Name": "新疆农村信用社",
        "Code": "HPT00168"
    },
    {
        "DBCode": "WRCB",
        "Name": "无锡农村商业银行",
        "Code": "HPT00094"
    },
    {
        "DBCode": "WJRCB",
        "Name": "苏州农商银行",
        "Code": "HPT00216"
    },
    {
        "DBCode": "XTB",
        "Name": "邢台银行",
        "Code": "HPT00086"
    },
    {
        "DBCode": "WOORI",
        "Name": "友利银行",
        "Code": "HPT00079"
    },
    {
        "DBCode": "ASCB",
        "Name": "鞍山银行",
        "Code": "HPT00241"
    },
    {
        "DBCode": "CCQTGB",
        "Name": "重庆三峡银行",
        "Code": "HPT00056"
    },
    {
        "DBCode": "ORBANK",
        "Name": "鄂尔多斯银行",
        "Code": "HPT00228"
    },
    {
        "DBCode": "HZCCB",
        "Name": "湖州银行",
        "Code": "HPT00204"
    },
    {
        "DBCode": "JXBANK",
        "Name": "嘉兴银行",
        "Code": "HPT00089"
    },
    {
        "DBCode": "TCRCB",
        "Name": "太仓农村商业银行",
        "Code": "HPT00250"
    },
    {
        "DBCode": "LZYH",
        "Name": "兰州银行",
        "Code": "HPT00083"
    },
    {
        "DBCode": "BOQH",
        "Name": "青海银行",
        "Code": "HPT00240"
    },
    {
        "DBCode": "QJCCB",
        "Name": "曲靖市商业银行",
        "Code": "HPT00174"
    },
    {
        "DBCode": "SZSBK",
        "Name": "石嘴山银行",
        "Code": "HPT00210"
    },
    {
        "DBCode": "SNCCB",
        "Name": "遂宁银行",
        "Code": "HPT00227"
    },
    {
        "DBCode": "LANGFB",
        "Name": "廊坊银行",
        "Code": "HPT00096"
    },
    {
        "DBCode": "SXCB",
        "Name": "绍兴银行",
        "Code": "HPT00214"
    },
    {
        "DBCode": "JSB",
        "Name": "晋商银行",
        "Code": "HPT00172"
    },
    {
        "DBCode": "NXBANK",
        "Name": "宁夏银行",
        "Code": "HPT00148"
    },
    {
        "DBCode": "CQBANK",
        "Name": "重庆银行",
        "Code": "HPT00082"
    },
    {
        "DBCode": "CITIC",
        "Name": "中信银行",
        "Code": "HPT00007"
    },
    {
        "DBCode": "HDBANK",
        "Name": "邯郸银行",
        "Code": "HPT00090"
    },
    {
        "DBCode": "BDCBANK",
        "Name": "保定银行",
        "Code": "HPT00085"
    },
    {
        "DBCode": "BOCFCB",
        "Name": "中银富登村镇银行",
        "Code": "HPT00118"
    },
    {
        "DBCode": "BANKWF",
        "Name": "潍坊银行",
        "Code": "HPT00206"
    },
    {
        "DBCode": "JNBANK",
        "Name": "济宁银行",
        "Code": "HPT00186"
    },
    {
        "DBCode": "BOJZ",
        "Name": "锦州银行",
        "Code": "HPT00087"
    },
    {
        "DBCode": "CABANK",
        "Name": "长安银行",
        "Code": "HPT00233"
    },
    {
        "DBCode": "DZBANK",
        "Name": "德州银行",
        "Code": "HPT00163"
    },
    {
        "DBCode": "ICBC",
        "Name": "工商银行",
        "Code": "HPT00002"
    },
    {
        "DBCode": "ABC",
        "Name": "农业银行",
        "Code": "HPT00004"
    },
    {
        "DBCode": "JSBANK",
        "Name": "江苏银行",
        "Code": "HPT00045"
    },
    {
        "DBCode": "CMB",
        "Name": "招商银行",
        "Code": "HPT00005"
    },
    {
        "DBCode": "COMM",
        "Name": "交通银行",
        "Code": "HPT00006"
    },
    {
        "DBCode": "BOC",
        "Name": "中国银行",
        "Code": "HPT00001"
    },
    {
        "DBCode": "CCB",
        "Name": "建设银行",
        "Code": "HPT00003"
    },
    {
        "DBCode": "FJNX",
        "Name": "福建农村信用社",
        "Code": "HPT00046"
    },
    {
        "DBCode": "SCRCU",
        "Name": "四川省农村信用联合社",
        "Code": "HPT00063"
    },
    {
        "DBCode": "HNRCU",
        "Name": "河南农村信用社",
        "Code": "HPT00103"
    },
    {
        "DBCode": "YNRCC",
        "Name": "云南农村信用社",
        "Code": "HPT00064"
    },
    {
        "DBCode": "GZRCU",
        "Name": "贵州农村信用社",
        "Code": "HPT00112"
    },
    {
        "DBCode": "HNRCC",
        "Name": "湖南农村信用社",
        "Code": "HPT00050"
    },
    {
        "DBCode": "JLRCU",
        "Name": "吉林农村信用社",
        "Code": "HPT00102"
    },
    {
        "DBCode": "RBOZ",
        "Name": "华润银行",
        "Code": "HPT00052"
    },
    {
        "DBCode": "HBRCU",
        "Name": "河北农村信用社",
        "Code": "HPT00104"
    },
    {
        "DBCode": "TJBHB",
        "Name": "天津滨海农商银行",
        "Code": "HPT00145"
    },
    {
        "DBCode": "ZRCBANK",
        "Name": "张家港农商银行",
        "Code": "HPT00162"
    },
    {
        "DBCode": "JSRCU",
        "Name": "江苏农村信用社",
        "Code": "HPT00179"
    },
    {
        "DBCode": "DLRCB",
        "Name": "大连农商银行",
        "Code": "HPT00139"
    },
    {
        "DBCode": "GSRCU",
        "Name": "甘肃农村信用社",
        "Code": "HPT00209"
    },
    {
        "DBCode": "LNRCC",
        "Name": "辽宁农村信用社",
        "Code": "HPT00114"
    },
    {
        "DBCode": "NMGNXS",
        "Name": "内蒙古农村信用社",
        "Code": "HPT00126"
    },
    {
        "DBCode": "YDRCB",
        "Name": "尧都农商银行",
        "Code": "HPT00151"
    },
    {
        "DBCode": "SXRCCU",
        "Name": "陕西农村信用社",
        "Code": "HPT00237"
    },
    {
        "DBCode": "SXRCU",
        "Name": "山西农村信用社",
        "Code": "HPT00057"
    },
    {
        "DBCode": "PSBC",
        "Name": "邮政银行",
        "Code": "HPT00026"
    },
    {
        "DBCode": "HKBEA",
        "Name": "东亚银行",
        "Code": "HPT00020"
    },
    {
        "DBCode": "WHCCB",
        "Name": "威海商业银行",
        "Code": "HPT00147"
    },
    {
        "DBCode": "ARCU",
        "Name": "安徽农村信用社",
        "Code": "HPT00107"
    },
    {
        "DBCode": "SDEB",
        "Name": "顺德农商银行",
        "Code": "HPT00098"
    },
    {
        "DBCode": "SDRCU",
        "Name": "山东农村信用社",
        "Code": "HPT00099"
    },
    {
        "DBCode": "HURCB",
        "Name": "湖北农村信用社",
        "Code": "HPT00106"
    },
    {
        "DBCode": "HLJRCU",
        "Name": "黑龙江农村信用社",
        "Code": "HPT00242"
    },
    {
        "DBCode": "SRCB",
        "Name": "深圳农商银行",
        "Code": "HPT00105"
    },
    {
        "DBCode": "CEB",
        "Name": "光大银行",
        "Code": "HPT00022"
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

DECLARE @providerID INT = 40;
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


DECLARE @inactivebankproviderbankcodeid INT = 1
SELECT @inactivebankproviderbankcodeid =  providerbankcodeid
from ProviderBankCode where ProviderID = 40 and code = 'HPT00099' ;
INSERT INTO @TestTable (ProviderBankCodeID,BankName, BankID)
VALUES (@inactivebankproviderbankcodeid, N'山东农村信用社', 150);

DECLARE @firstID NVARCHAR(50)
DECLARE @lastID NVARCHAR(50)

select Top 1 @firstID = ProviderBankCodeID
from ProviderBankCode
where providerID = 40
ORDER BY ProviderBankCodeID ASC;

select Top 1 @lastID = ProviderBankCodeID
from ProviderBankCode
where providerID = 40
ORDER BY ProviderBankCodeID DESC;

DELETE FROM ProviderBankCodeMapping
WHERE ProviderBankCodeID BETWEEN @firstID AND @lastID;

INSERT INTO ProviderBankCodeMapping(ProviderBankCodeID, BankID)
SELECT ProviderBankCodeID, BankID
FROM @TestTable

-- select @inactivebankproviderbankcodeid
-- SELECT * from @TestTable
-- select * from ProviderBankCodeMapping 

