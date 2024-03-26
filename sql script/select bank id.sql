DECLARE @json NVARCHAR(MAX);

SET @json = N'{
  "QHRC": "青海银行",
  "SYCB": "上虞农商银行",
  "SXCB": "绍兴银行",
  "TCRCB": "太仓农商银行",
  "TACCB": "泰安银行",
  "TRCB": "天津农商银行",
  "XTB": "邢台银行",
  "RCBOZ": "张家港农商银行",
  "JSCCB": "长江商业银行",
  "MYCC": "绵阳商业银行",
  "SRCU": "山西农信",
  "YQCCB": "阳泉商业银行",
  "HDHMB": "桦甸惠民村镇银行",
  "HNB": "海南农信",
  "HHNX": "黄河农信银行",
  "JMRCB": "江门农商银行",
  "JCCB": "晋城银行",
  "NXBANK": "宁夏银行",
  "NXRCU": "宁夏黄河农村商业银行",
  "FTYZB": "深圳福田银座村镇银行",
  "SZSCCB": "石嘴山银行",
  "WJRCB": "苏州农商银行",
  "TJBHB": "天津滨海农村商业银行",
  "ZZB": "枣庄银行",
  "MYBANK": "浙江网商银行",
  "GZRCB": "广东农商银行",
  "HNBANK": "海南银行",
  "WCHMB": "五常惠民村镇银行",
  "TSB": "唐山银行",
  "RXVB": "融兴村镇银行",
  "NMGNXS": "内蒙古农村信用社",
  "BOIMC": "内蒙古银行",
  "HSHSB": "惠水恒升村镇银行",
  "CYCB": "朝阳银行",
  "JXNXS": "江西农商银行",
  "GYNSH": "贵阳农商银行",
  "QZCCB": "泉州银行",
  "SRCB": "深圳农商银行",
  "GXNX": "广西农村信用社",
  "BJRCB": "北京农村商业银行",
  "ICBC": "工商银行",
  "CMB": "招商银行",
  "CCB": "建设银行",
  "BOC": "中国银行",
  "ABC": "农业银行",
  "BCM": "交通银行",
  "SPDB": "上海浦东发展银行",
  "CGB": "广东发展银行",
  "CEB": "光大银行",
  "CIB": "兴业银行",
  "PAB": "平安银行",
  "CMBC": "民生银行",
  "HXB": "华夏银行",
  "PSBC": "邮政银行",
  "NBBANK": "宁波银行",
  "BJBANK": "北京银行",
  "CZBANK": "浙商银行",
  "GCB": "广州银行",
  "CSCB": "长沙银行",
  "BGB": "广西北部湾银行",
  "GDRC": "广东农信",
  "GLB": "桂林银行",
  "BOD": "东莞银行",
  "HZCB": "杭州银行",
  "JSBC": "江苏银行",
  "GXRCU": "广西农信银行",
  "WSGM": "微信固码",
  "JLBANK": "吉林银行",
  "NJCB": "南京银行",
  "EGBANK": "恒丰银行",
  "ATCZB": "安图农商村镇银行",
  "CNCB": "中信银行",
  "WHRCB": "武汉农商银行",
  "WHCCB": "威海银行",
  "SHBANK": "上海银行",
  "HRBANK": "哈尔滨银行",
  "QDCCB": "青岛银行",
  "LSBANK": "莱商银行",
  "QLBANK": "齐鲁银行",
  "YTBANK": "烟台银行",
  "LZCCB": "柳州银行",
  "CRCBANK": "重庆农村商业银行",
  "BCCB": "北京商业银行",
  "GSNX": "甘肃省农村信用社",
  "HBC": "湖北银行",
  "HEBNX": "河北农信银行",
  "DRCB": "东莞农村商业银行",
  "HUNNX": "湖南省农村信用社",
  "ZJTLCB": "泰隆银行",
  "CZCB": "稠州银行",
  "ZGCCB": "自贡银行",
  "MTBANK": "民泰银行",
  "YZBANK": "银座村镇银行",
  "BOYK": "营口银行",
  "LZYH": "兰州银行",
  "LSBC": "临商银行",
  "NCB": "江西银行",
  "JXRCU": "江西省农村信用社",
  "JSRCU": "江苏省农村信用社联合社",
  "HRXJB": "华融湘江银行",
  "HURCB": "湖北省农信社",
  "DLB": "大连银行",
  "BOCZ": "沧州银行",
  "CCQTGB": "重庆三峡银行",
  "DYCCB": "东营银行",
  "GDRCC": "广东省农村信用社联合社",
  "GRCB": "广州农商银行",
  "PERB": "蒙商银行",
  "CCRFCB": "长春经开融丰村镇银行",
  "BOB": "保定银行",
  "CDBANK": "承德银行",
  "ZJNX": "浙江农村信用合作社",
  "ARCU": "安徽省农村信用社",
  "YGCZYH": "阳光村镇银行",
  "FJNX": "福建农村信用社",
  "GHB": "广东华兴银行",
  "GDRCU": "广东省农村信用社",
  "CRBANK": "珠海华润银行",
  "NRCB": "南海农商银行",
  "CSRCB": "常熟农商银行",
  "CDCB": "成都银行",
  "HKB": "汉口银行",
  "URCB": "杭州联合银行",
  "JNRCB": "江南农村商业银行",
  "JSNX": "江苏省农村信用社",
  "JJCCB": "九江银行",
  "INRCC": "辽宁省农村信用社",
  "LYBANK": "洛阳银行",
  "QSB": "齐商银行",
  "QRCB": "青岛农商银行",
  "YNRCC": "云南农信银行",
  "WEBANK": "深圳前海微众银行",
  "SJBANK": "盛京银行",
  "SCRCU": "四川省农村信用社",
  "PWEB": "四川天府银行",
  "BOSZ": "苏州银行",
  "TZCB": "台州银行",
  "SBANK": "微商银行",
  "WZCB": "温州银行",
  "ZJXSBANK": "萧山农商银行",
  "CRCB": "长沙农商银行",
  "ZZBANK": "郑州银行",
  "ZYBANK": "中原银行",
  "ZJRCB": "紫金农商银行",
  "HNRCU": "河南省农村信用社",
  "CBHB": "渤海银行",
  "LJBANK": "龙江银行",
  "HLJRCU": "黑龙江农信",
  "LYCB": "辽阳银行",
  "BODD": "丹东银行",
  "DLRCB": "大连农商银行",
  "GSBANK": "甘肃银行",
  "GYCB": "贵阳银行",
  "ZYCBANK": "贵州银行",
  "GLGM": "桂林国民银行",
  "HSBANK": "徽商银行",
  "BOJN": "济宁银行",
  "LANGFB": "廊坊银行",
  "CCAB": "长安银行",
  "XABANK": "西安银行",
  "BSB": "包商银行",
  "BOBZ": "本溪银行",
  "BODZ": "达州银行",
  "CDRCB": "成都农商银行",
  "HKBEA": "东亚银行",
  "FSCB": "抚顺银行",
  "GZRCU": "贵州省农村信用社联合社",
  "BHB": "河北银行",
  "JLRCU": "吉林农信银行",
  "JRCB": "江苏农商银行"
}';

-- Convert the JSON string to a table
DECLARE @jsonTable TABLE (Code NVARCHAR(MAX), Name NVARCHAR(MAX));
INSERT INTO @jsonTable (Code, Name)
SELECT [key], value
FROM OPENJSON(@json);

--SELECT * From @jsonTable;

DECLARE @tempTable1 TABLE (Code NVARCHAR(MAX), Name NVARCHAR(MAX));

INSERT INTO @tempTable1 (Code, Name)
SELECT j.Code, j.Name
FROM @jsonTable j
WHERE EXISTS (
    SELECT 1
    FROM dbo.Bank t
    WHERE t.BankCode = j.code
);
SELECT code,code FROM @tempTable1;

DECLARE @tempTable TABLE (Code NVARCHAR(MAX), Name NVARCHAR(MAX));

INSERT INTO @tempTable (Code, Name)
SELECT j.Code, j.Name
FROM @jsonTable j
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Bank t
    WHERE t.BankCode = j.code
);
--SELECT code FROM @tempTable;

DECLARE @temp2Table TABLE (DBCode NVARCHAR(MAX), Code NVARCHAR(MAX), Name NVARCHAR(MAX));

-- INSERT INTO @temp2Table (DBCode, Code, Name)
-- SELECT j.Code, j.Name, t.BankCode
-- FROM @tempTable j
-- WHERE EXISTS (
--     SELECT 1
--     FROM dbo.Bank t
--     WHERE t.BankName = j.Name
-- );
-- SELECT code FROM @temp2Table;

INSERT INTO @temp2Table (Code, DBCode, Name)
SELECT j.Code, t.BankCode, j.Name
FROM @tempTable j
JOIN dbo.Bank t ON j.Name = t.BankName

SELECT Code, DBCode FROM @temp2Table;
