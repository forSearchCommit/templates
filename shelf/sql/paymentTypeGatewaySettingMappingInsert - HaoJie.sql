DECLARE
    @Provider INT = 40, 
    @PaymentTypeGatewaySettingID INT = 1106

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00009'and a.ProviderID = @Provider AND b.BankCode ='CMBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00009' and a.ProviderID = @Provider AND b.BankCode ='CMBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00192'and a.ProviderID = @Provider AND b.BankCode ='SPDB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00192' and a.ProviderID = @Provider AND b.BankCode ='SPDB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00024'and a.ProviderID = @Provider AND b.BankCode ='SPABANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00024' and a.ProviderID = @Provider AND b.BankCode ='SPABANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00008'and a.ProviderID = @Provider AND b.BankCode ='CIB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00008' and a.ProviderID = @Provider AND b.BankCode ='CIB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00025'and a.ProviderID = @Provider AND b.BankCode ='BJBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00025' and a.ProviderID = @Provider AND b.BankCode ='BJBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00029'and a.ProviderID = @Provider AND b.BankCode ='BOHAIB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00029' and a.ProviderID = @Provider AND b.BankCode ='BOHAIB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00030'and a.ProviderID = @Provider AND b.BankCode ='NBBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00030' and a.ProviderID = @Provider AND b.BankCode ='NBBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00032'and a.ProviderID = @Provider AND b.BankCode ='BJRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00032' and a.ProviderID = @Provider AND b.BankCode ='BJRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00028'and a.ProviderID = @Provider AND b.BankCode ='NJCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00028' and a.ProviderID = @Provider AND b.BankCode ='NJCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00037'and a.ProviderID = @Provider AND b.BankCode ='CZBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00037' and a.ProviderID = @Provider AND b.BankCode ='CZBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00027'and a.ProviderID = @Provider AND b.BankCode ='SHBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00027' and a.ProviderID = @Provider AND b.BankCode ='SHBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00033'and a.ProviderID = @Provider AND b.BankCode ='SHRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00033' and a.ProviderID = @Provider AND b.BankCode ='SHRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00035'and a.ProviderID = @Provider AND b.BankCode ='HZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00035' and a.ProviderID = @Provider AND b.BankCode ='HZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00034'and a.ProviderID = @Provider AND b.BankCode ='CZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00034' and a.ProviderID = @Provider AND b.BankCode ='CZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00177'and a.ProviderID = @Provider AND b.BankCode ='HKB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00177' and a.ProviderID = @Provider AND b.BankCode ='HKB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00067'and a.ProviderID = @Provider AND b.BankCode ='CSCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00067' and a.ProviderID = @Provider AND b.BankCode ='CSCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00044'and a.ProviderID = @Provider AND b.BankCode ='GRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00044' and a.ProviderID = @Provider AND b.BankCode ='GRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00077'and a.ProviderID = @Provider AND b.BankCode ='EGBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00077' and a.ProviderID = @Provider AND b.BankCode ='EGBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00039'and a.ProviderID = @Provider AND b.BankCode ='HSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00039' and a.ProviderID = @Provider AND b.BankCode ='HSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00068'and a.ProviderID = @Provider AND b.BankCode ='BOD'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00068' and a.ProviderID = @Provider AND b.BankCode ='BOD'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00101'and a.ProviderID = @Provider AND b.BankCode ='XMBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00101' and a.ProviderID = @Provider AND b.BankCode ='XMBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00053'and a.ProviderID = @Provider AND b.BankCode ='JLBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00053' and a.ProviderID = @Provider AND b.BankCode ='JLBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00041'and a.ProviderID = @Provider AND b.BankCode ='GCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00041' and a.ProviderID = @Provider AND b.BankCode ='GCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00140'and a.ProviderID = @Provider AND b.BankCode ='DLB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00140' and a.ProviderID = @Provider AND b.BankCode ='DLB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00146'and a.ProviderID = @Provider AND b.BankCode ='TCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00146' and a.ProviderID = @Provider AND b.BankCode ='TCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00075'and a.ProviderID = @Provider AND b.BankCode ='ZZBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00075' and a.ProviderID = @Provider AND b.BankCode ='ZZBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00135'and a.ProviderID = @Provider AND b.BankCode ='NHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00135' and a.ProviderID = @Provider AND b.BankCode ='NHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00061'and a.ProviderID = @Provider AND b.BankCode ='HBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00061' and a.ProviderID = @Provider AND b.BankCode ='HBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00109'and a.ProviderID = @Provider AND b.BankCode ='QDCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00109' and a.ProviderID = @Provider AND b.BankCode ='QDCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00076'and a.ProviderID = @Provider AND b.BankCode ='CDCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00076' and a.ProviderID = @Provider AND b.BankCode ='CDCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00038'and a.ProviderID = @Provider AND b.BankCode ='BHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00038' and a.ProviderID = @Provider AND b.BankCode ='BHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00188'and a.ProviderID = @Provider AND b.BankCode ='ZJTLCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00188' and a.ProviderID = @Provider AND b.BankCode ='ZJTLCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00201'and a.ProviderID = @Provider AND b.BankCode ='WZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00201' and a.ProviderID = @Provider AND b.BankCode ='WZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00036'and a.ProviderID = @Provider AND b.BankCode ='FDB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00036' and a.ProviderID = @Provider AND b.BankCode ='FDB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00049'and a.ProviderID = @Provider AND b.BankCode ='ZJNX'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00049' and a.ProviderID = @Provider AND b.BankCode ='ZJNX'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00158'and a.ProviderID = @Provider AND b.BankCode ='NYBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00158' and a.ProviderID = @Provider AND b.BankCode ='NYBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00217'and a.ProviderID = @Provider AND b.BankCode ='BOSZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00217' and a.ProviderID = @Provider AND b.BankCode ='BOSZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00154'and a.ProviderID = @Provider AND b.BankCode ='CSRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00154' and a.ProviderID = @Provider AND b.BankCode ='CSRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00108'and a.ProviderID = @Provider AND b.BankCode ='ZYB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00108' and a.ProviderID = @Provider AND b.BankCode ='ZYB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00110'and a.ProviderID = @Provider AND b.BankCode ='ZBCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00110' and a.ProviderID = @Provider AND b.BankCode ='ZBCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00060'and a.ProviderID = @Provider AND b.BankCode ='CRCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00060' and a.ProviderID = @Provider AND b.BankCode ='CRCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00042'and a.ProviderID = @Provider AND b.BankCode ='GXRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00042' and a.ProviderID = @Provider AND b.BankCode ='GXRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00132'and a.ProviderID = @Provider AND b.BankCode ='HRXJB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00132' and a.ProviderID = @Provider AND b.BankCode ='HRXJB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00065'and a.ProviderID = @Provider AND b.BankCode ='CGNB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00065' and a.ProviderID = @Provider AND b.BankCode ='CGNB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00058'and a.ProviderID = @Provider AND b.BankCode ='GLBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00058' and a.ProviderID = @Provider AND b.BankCode ='GLBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00178'and a.ProviderID = @Provider AND b.BankCode ='CZRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00178' and a.ProviderID = @Provider AND b.BankCode ='CZRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00093'and a.ProviderID = @Provider AND b.BankCode ='WHRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00093' and a.ProviderID = @Provider AND b.BankCode ='WHRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00051'and a.ProviderID = @Provider AND b.BankCode ='BGB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00051' and a.ProviderID = @Provider AND b.BankCode ='BGB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00069'and a.ProviderID = @Provider AND b.BankCode ='RZB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00069' and a.ProviderID = @Provider AND b.BankCode ='RZB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00244'and a.ProviderID = @Provider AND b.BankCode ='QLBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00244' and a.ProviderID = @Provider AND b.BankCode ='QLBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00055'and a.ProviderID = @Provider AND b.BankCode ='JJBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00055' and a.ProviderID = @Provider AND b.BankCode ='JJBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00080'and a.ProviderID = @Provider AND b.BankCode ='GZB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00080' and a.ProviderID = @Provider AND b.BankCode ='GZB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00100'and a.ProviderID = @Provider AND b.BankCode ='HRBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00100' and a.ProviderID = @Provider AND b.BankCode ='HRBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00092'and a.ProviderID = @Provider AND b.BankCode ='TZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00092' and a.ProviderID = @Provider AND b.BankCode ='TZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00157'and a.ProviderID = @Provider AND b.BankCode ='GHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00157' and a.ProviderID = @Provider AND b.BankCode ='GHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00081'and a.ProviderID = @Provider AND b.BankCode ='SJBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00081' and a.ProviderID = @Provider AND b.BankCode ='SJBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00111'and a.ProviderID = @Provider AND b.BankCode ='DRCBCL'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00111' and a.ProviderID = @Provider AND b.BankCode ='DRCBCL'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00236'and a.ProviderID = @Provider AND b.BankCode ='FXCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00236' and a.ProviderID = @Provider AND b.BankCode ='FXCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00070'and a.ProviderID = @Provider AND b.BankCode ='YTBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00070' and a.ProviderID = @Provider AND b.BankCode ='YTBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00127'and a.ProviderID = @Provider AND b.BankCode ='H3CB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00127' and a.ProviderID = @Provider AND b.BankCode ='H3CB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00218'and a.ProviderID = @Provider AND b.BankCode ='BOYK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00218' and a.ProviderID = @Provider AND b.BankCode ='BOYK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00231'and a.ProviderID = @Provider AND b.BankCode ='JHBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00231' and a.ProviderID = @Provider AND b.BankCode ='JHBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00245'and a.ProviderID = @Provider AND b.BankCode ='DAQINGB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00245' and a.ProviderID = @Provider AND b.BankCode ='DAQINGB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00184'and a.ProviderID = @Provider AND b.BankCode ='TACCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00184' and a.ProviderID = @Provider AND b.BankCode ='TACCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00119'and a.ProviderID = @Provider AND b.BankCode ='LSBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00119' and a.ProviderID = @Provider AND b.BankCode ='LSBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00088'and a.ProviderID = @Provider AND b.BankCode ='DYCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00088' and a.ProviderID = @Provider AND b.BankCode ='DYCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00074'and a.ProviderID = @Provider AND b.BankCode ='XABANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00074' and a.ProviderID = @Provider AND b.BankCode ='XABANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00062'and a.ProviderID = @Provider AND b.BankCode ='ZJKCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00062' and a.ProviderID = @Provider AND b.BankCode ='ZJKCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00165'and a.ProviderID = @Provider AND b.BankCode ='BOCD'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00165' and a.ProviderID = @Provider AND b.BankCode ='BOCD'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00091'and a.ProviderID = @Provider AND b.BankCode ='TRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00091' and a.ProviderID = @Provider AND b.BankCode ='TRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00116'and a.ProviderID = @Provider AND b.BankCode ='SRBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00116' and a.ProviderID = @Provider AND b.BankCode ='SRBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00229'and a.ProviderID = @Provider AND b.BankCode ='NBYZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00229' and a.ProviderID = @Provider AND b.BankCode ='NBYZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00183'and a.ProviderID = @Provider AND b.BankCode ='BOQZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00183' and a.ProviderID = @Provider AND b.BankCode ='BOQZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00084'and a.ProviderID = @Provider AND b.BankCode ='LSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00084' and a.ProviderID = @Provider AND b.BankCode ='LSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00170'and a.ProviderID = @Provider AND b.BankCode ='KLB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00170' and a.ProviderID = @Provider AND b.BankCode ='KLB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00071'and a.ProviderID = @Provider AND b.BankCode ='GSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00071' and a.ProviderID = @Provider AND b.BankCode ='GSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00195'and a.ProviderID = @Provider AND b.BankCode ='UBCHN'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00195' and a.ProviderID = @Provider AND b.BankCode ='UBCHN'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00010'and a.ProviderID = @Provider AND b.BankCode ='HXBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00010' and a.ProviderID = @Provider AND b.BankCode ='HXBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00023'and a.ProviderID = @Provider AND b.BankCode ='GDB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00023' and a.ProviderID = @Provider AND b.BankCode ='GDB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00156'and a.ProviderID = @Provider AND b.BankCode ='GDRCC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00156' and a.ProviderID = @Provider AND b.BankCode ='GDRCC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00164'and a.ProviderID = @Provider AND b.BankCode ='CDRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00164' and a.ProviderID = @Provider AND b.BankCode ='CDRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00073'and a.ProviderID = @Provider AND b.BankCode ='GYCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00073' and a.ProviderID = @Provider AND b.BankCode ='GYCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00232'and a.ProviderID = @Provider AND b.BankCode ='DYCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00232' and a.ProviderID = @Provider AND b.BankCode ='DYCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00066'and a.ProviderID = @Provider AND b.BankCode ='FJHXBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00066' and a.ProviderID = @Provider AND b.BankCode ='FJHXBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00078'and a.ProviderID = @Provider AND b.BankCode ='ZYCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00078' and a.ProviderID = @Provider AND b.BankCode ='ZYCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00054'and a.ProviderID = @Provider AND b.BankCode ='BOHN'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00054' and a.ProviderID = @Provider AND b.BankCode ='BOHN'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00171'and a.ProviderID = @Provider AND b.BankCode ='KSRB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00171' and a.ProviderID = @Provider AND b.BankCode ='KSRB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00168'and a.ProviderID = @Provider AND b.BankCode ='XJRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00168' and a.ProviderID = @Provider AND b.BankCode ='XJRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00094'and a.ProviderID = @Provider AND b.BankCode ='WRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00094' and a.ProviderID = @Provider AND b.BankCode ='WRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00216'and a.ProviderID = @Provider AND b.BankCode ='WJRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00216' and a.ProviderID = @Provider AND b.BankCode ='WJRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00086'and a.ProviderID = @Provider AND b.BankCode ='XTB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00086' and a.ProviderID = @Provider AND b.BankCode ='XTB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00079'and a.ProviderID = @Provider AND b.BankCode ='WOORI'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00079' and a.ProviderID = @Provider AND b.BankCode ='WOORI'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00241'and a.ProviderID = @Provider AND b.BankCode ='ASCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00241' and a.ProviderID = @Provider AND b.BankCode ='ASCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00056'and a.ProviderID = @Provider AND b.BankCode ='CCQTGB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00056' and a.ProviderID = @Provider AND b.BankCode ='CCQTGB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00228'and a.ProviderID = @Provider AND b.BankCode ='ORBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00228' and a.ProviderID = @Provider AND b.BankCode ='ORBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00204'and a.ProviderID = @Provider AND b.BankCode ='HZCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00204' and a.ProviderID = @Provider AND b.BankCode ='HZCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00089'and a.ProviderID = @Provider AND b.BankCode ='JXBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00089' and a.ProviderID = @Provider AND b.BankCode ='JXBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00250'and a.ProviderID = @Provider AND b.BankCode ='TCRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00250' and a.ProviderID = @Provider AND b.BankCode ='TCRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00083'and a.ProviderID = @Provider AND b.BankCode ='LZYH'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00083' and a.ProviderID = @Provider AND b.BankCode ='LZYH'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00240'and a.ProviderID = @Provider AND b.BankCode ='BOQH'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00240' and a.ProviderID = @Provider AND b.BankCode ='BOQH'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00174'and a.ProviderID = @Provider AND b.BankCode ='QJCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00174' and a.ProviderID = @Provider AND b.BankCode ='QJCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00210'and a.ProviderID = @Provider AND b.BankCode ='SZSBK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00210' and a.ProviderID = @Provider AND b.BankCode ='SZSBK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00227'and a.ProviderID = @Provider AND b.BankCode ='SNCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00227' and a.ProviderID = @Provider AND b.BankCode ='SNCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00096'and a.ProviderID = @Provider AND b.BankCode ='LANGFB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00096' and a.ProviderID = @Provider AND b.BankCode ='LANGFB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00214'and a.ProviderID = @Provider AND b.BankCode ='SXCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00214' and a.ProviderID = @Provider AND b.BankCode ='SXCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00172'and a.ProviderID = @Provider AND b.BankCode ='JSB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00172' and a.ProviderID = @Provider AND b.BankCode ='JSB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00148'and a.ProviderID = @Provider AND b.BankCode ='NXBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00148' and a.ProviderID = @Provider AND b.BankCode ='NXBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00082'and a.ProviderID = @Provider AND b.BankCode ='CQBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00082' and a.ProviderID = @Provider AND b.BankCode ='CQBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00007'and a.ProviderID = @Provider AND b.BankCode ='CITIC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00007' and a.ProviderID = @Provider AND b.BankCode ='CITIC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00090'and a.ProviderID = @Provider AND b.BankCode ='HDBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00090' and a.ProviderID = @Provider AND b.BankCode ='HDBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00085'and a.ProviderID = @Provider AND b.BankCode ='BDCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00085' and a.ProviderID = @Provider AND b.BankCode ='BDCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00118'and a.ProviderID = @Provider AND b.BankCode ='BOCFCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00118' and a.ProviderID = @Provider AND b.BankCode ='BOCFCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00206'and a.ProviderID = @Provider AND b.BankCode ='BANKWF'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00206' and a.ProviderID = @Provider AND b.BankCode ='BANKWF'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00186'and a.ProviderID = @Provider AND b.BankCode ='JNBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00186' and a.ProviderID = @Provider AND b.BankCode ='JNBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00087'and a.ProviderID = @Provider AND b.BankCode ='BOJZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00087' and a.ProviderID = @Provider AND b.BankCode ='BOJZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00233'and a.ProviderID = @Provider AND b.BankCode ='CABANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00233' and a.ProviderID = @Provider AND b.BankCode ='CABANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00163'and a.ProviderID = @Provider AND b.BankCode ='DZBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00163' and a.ProviderID = @Provider AND b.BankCode ='DZBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00002'and a.ProviderID = @Provider AND b.BankCode ='ICBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00002' and a.ProviderID = @Provider AND b.BankCode ='ICBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00004'and a.ProviderID = @Provider AND b.BankCode ='ABC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00004' and a.ProviderID = @Provider AND b.BankCode ='ABC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00045'and a.ProviderID = @Provider AND b.BankCode ='JSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00045' and a.ProviderID = @Provider AND b.BankCode ='JSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00005'and a.ProviderID = @Provider AND b.BankCode ='CMB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00005' and a.ProviderID = @Provider AND b.BankCode ='CMB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00006'and a.ProviderID = @Provider AND b.BankCode ='COMM'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00006' and a.ProviderID = @Provider AND b.BankCode ='COMM'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00001'and a.ProviderID = @Provider AND b.BankCode ='BOC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00001' and a.ProviderID = @Provider AND b.BankCode ='BOC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00003'and a.ProviderID = @Provider AND b.BankCode ='CCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00003' and a.ProviderID = @Provider AND b.BankCode ='CCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00046'and a.ProviderID = @Provider AND b.BankCode ='FJNX'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00046' and a.ProviderID = @Provider AND b.BankCode ='FJNX'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00063'and a.ProviderID = @Provider AND b.BankCode ='SCRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00063' and a.ProviderID = @Provider AND b.BankCode ='SCRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00103'and a.ProviderID = @Provider AND b.BankCode ='HNRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00103' and a.ProviderID = @Provider AND b.BankCode ='HNRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00064'and a.ProviderID = @Provider AND b.BankCode ='YNRCC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00064' and a.ProviderID = @Provider AND b.BankCode ='YNRCC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00112'and a.ProviderID = @Provider AND b.BankCode ='GZRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00112' and a.ProviderID = @Provider AND b.BankCode ='GZRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00050'and a.ProviderID = @Provider AND b.BankCode ='HNRCC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00050' and a.ProviderID = @Provider AND b.BankCode ='HNRCC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00102'and a.ProviderID = @Provider AND b.BankCode ='JLRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00102' and a.ProviderID = @Provider AND b.BankCode ='JLRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00052'and a.ProviderID = @Provider AND b.BankCode ='RBOZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00052' and a.ProviderID = @Provider AND b.BankCode ='RBOZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00104'and a.ProviderID = @Provider AND b.BankCode ='HBRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00104' and a.ProviderID = @Provider AND b.BankCode ='HBRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00145'and a.ProviderID = @Provider AND b.BankCode ='TJBHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00145' and a.ProviderID = @Provider AND b.BankCode ='TJBHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00162'and a.ProviderID = @Provider AND b.BankCode ='ZRCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00162' and a.ProviderID = @Provider AND b.BankCode ='ZRCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00179'and a.ProviderID = @Provider AND b.BankCode ='JSRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00179' and a.ProviderID = @Provider AND b.BankCode ='JSRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00139'and a.ProviderID = @Provider AND b.BankCode ='DLRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00139' and a.ProviderID = @Provider AND b.BankCode ='DLRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00209'and a.ProviderID = @Provider AND b.BankCode ='GSRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00209' and a.ProviderID = @Provider AND b.BankCode ='GSRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00114'and a.ProviderID = @Provider AND b.BankCode ='LNRCC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00114' and a.ProviderID = @Provider AND b.BankCode ='LNRCC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00126'and a.ProviderID = @Provider AND b.BankCode ='NMGNXS'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00126' and a.ProviderID = @Provider AND b.BankCode ='NMGNXS'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00151'and a.ProviderID = @Provider AND b.BankCode ='YDRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00151' and a.ProviderID = @Provider AND b.BankCode ='YDRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00237'and a.ProviderID = @Provider AND b.BankCode ='SXRCCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00237' and a.ProviderID = @Provider AND b.BankCode ='SXRCCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00057'and a.ProviderID = @Provider AND b.BankCode ='SXRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00057' and a.ProviderID = @Provider AND b.BankCode ='SXRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00026'and a.ProviderID = @Provider AND b.BankCode ='PSBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00026' and a.ProviderID = @Provider AND b.BankCode ='PSBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00020'and a.ProviderID = @Provider AND b.BankCode ='HKBEA'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00020' and a.ProviderID = @Provider AND b.BankCode ='HKBEA'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00147'and a.ProviderID = @Provider AND b.BankCode ='WHCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00147' and a.ProviderID = @Provider AND b.BankCode ='WHCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00107'and a.ProviderID = @Provider AND b.BankCode ='ARCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00107' and a.ProviderID = @Provider AND b.BankCode ='ARCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00098'and a.ProviderID = @Provider AND b.BankCode ='SDEB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00098' and a.ProviderID = @Provider AND b.BankCode ='SDEB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00099'and a.ProviderID = @Provider AND b.BankCode ='SDRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00099' and a.ProviderID = @Provider AND b.BankCode ='SDRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00106'and a.ProviderID = @Provider AND b.BankCode ='HURCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00106' and a.ProviderID = @Provider AND b.BankCode ='HURCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00242'and a.ProviderID = @Provider AND b.BankCode ='HLJRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00242' and a.ProviderID = @Provider AND b.BankCode ='HLJRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00105'and a.ProviderID = @Provider AND b.BankCode ='SRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00105' and a.ProviderID = @Provider AND b.BankCode ='SRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HPT00022'and a.ProviderID = @Provider AND b.BankCode ='CEB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HPT00022' and a.ProviderID = @Provider AND b.BankCode ='CEB'