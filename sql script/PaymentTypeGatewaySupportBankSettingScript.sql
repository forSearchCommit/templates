DECLARE
    @Provider INT = 38, 
    @PaymentTypeGatewaySettingID INT = 1103

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SXCB'and a.ProviderID = @Provider AND b.BankCode ='SXCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SXCB' and a.ProviderID = @Provider AND b.BankCode ='SXCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='TACCB'and a.ProviderID = @Provider AND b.BankCode ='TACCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'TACCB' and a.ProviderID = @Provider AND b.BankCode ='TACCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='TRCB'and a.ProviderID = @Provider AND b.BankCode ='TRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'TRCB' and a.ProviderID = @Provider AND b.BankCode ='TRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='XTB'and a.ProviderID = @Provider AND b.BankCode ='XTB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'XTB' and a.ProviderID = @Provider AND b.BankCode ='XTB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='NXBANK'and a.ProviderID = @Provider AND b.BankCode ='NXBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'NXBANK' and a.ProviderID = @Provider AND b.BankCode ='NXBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='NXRCU'and a.ProviderID = @Provider AND b.BankCode ='NXRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'NXRCU' and a.ProviderID = @Provider AND b.BankCode ='NXRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='WJRCB'and a.ProviderID = @Provider AND b.BankCode ='WJRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'WJRCB' and a.ProviderID = @Provider AND b.BankCode ='WJRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='NMGNXS'and a.ProviderID = @Provider AND b.BankCode ='NMGNXS'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'NMGNXS' and a.ProviderID = @Provider AND b.BankCode ='NMGNXS'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SRCB'and a.ProviderID = @Provider AND b.BankCode ='SRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SRCB' and a.ProviderID = @Provider AND b.BankCode ='SRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ICBC'and a.ProviderID = @Provider AND b.BankCode ='ICBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ICBC' and a.ProviderID = @Provider AND b.BankCode ='ICBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CMB'and a.ProviderID = @Provider AND b.BankCode ='CMB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CMB' and a.ProviderID = @Provider AND b.BankCode ='CMB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CCB'and a.ProviderID = @Provider AND b.BankCode ='CCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CCB' and a.ProviderID = @Provider AND b.BankCode ='CCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOC'and a.ProviderID = @Provider AND b.BankCode ='BOC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOC' and a.ProviderID = @Provider AND b.BankCode ='BOC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ABC'and a.ProviderID = @Provider AND b.BankCode ='ABC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ABC' and a.ProviderID = @Provider AND b.BankCode ='ABC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CEB'and a.ProviderID = @Provider AND b.BankCode ='CEB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CEB' and a.ProviderID = @Provider AND b.BankCode ='CEB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CIB'and a.ProviderID = @Provider AND b.BankCode ='CIB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CIB' and a.ProviderID = @Provider AND b.BankCode ='CIB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CMBC'and a.ProviderID = @Provider AND b.BankCode ='CMBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CMBC' and a.ProviderID = @Provider AND b.BankCode ='CMBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='PSBC'and a.ProviderID = @Provider AND b.BankCode ='PSBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'PSBC' and a.ProviderID = @Provider AND b.BankCode ='PSBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='NBBANK'and a.ProviderID = @Provider AND b.BankCode ='NBBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'NBBANK' and a.ProviderID = @Provider AND b.BankCode ='NBBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BJBANK'and a.ProviderID = @Provider AND b.BankCode ='BJBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BJBANK' and a.ProviderID = @Provider AND b.BankCode ='BJBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CZBANK'and a.ProviderID = @Provider AND b.BankCode ='CZBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CZBANK' and a.ProviderID = @Provider AND b.BankCode ='CZBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GCB'and a.ProviderID = @Provider AND b.BankCode ='GCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GCB' and a.ProviderID = @Provider AND b.BankCode ='GCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CSCB'and a.ProviderID = @Provider AND b.BankCode ='CSCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CSCB' and a.ProviderID = @Provider AND b.BankCode ='CSCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BGB'and a.ProviderID = @Provider AND b.BankCode ='BGB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BGB' and a.ProviderID = @Provider AND b.BankCode ='BGB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOD'and a.ProviderID = @Provider AND b.BankCode ='BOD'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOD' and a.ProviderID = @Provider AND b.BankCode ='BOD'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HZCB'and a.ProviderID = @Provider AND b.BankCode ='HZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HZCB' and a.ProviderID = @Provider AND b.BankCode ='HZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JLBANK'and a.ProviderID = @Provider AND b.BankCode ='JLBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JLBANK' and a.ProviderID = @Provider AND b.BankCode ='JLBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='NJCB'and a.ProviderID = @Provider AND b.BankCode ='NJCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'NJCB' and a.ProviderID = @Provider AND b.BankCode ='NJCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='EGBANK'and a.ProviderID = @Provider AND b.BankCode ='EGBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'EGBANK' and a.ProviderID = @Provider AND b.BankCode ='EGBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SHBANK'and a.ProviderID = @Provider AND b.BankCode ='SHBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SHBANK' and a.ProviderID = @Provider AND b.BankCode ='SHBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HRBANK'and a.ProviderID = @Provider AND b.BankCode ='HRBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HRBANK' and a.ProviderID = @Provider AND b.BankCode ='HRBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='QDCCB'and a.ProviderID = @Provider AND b.BankCode ='QDCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'QDCCB' and a.ProviderID = @Provider AND b.BankCode ='QDCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='LSBANK'and a.ProviderID = @Provider AND b.BankCode ='LSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'LSBANK' and a.ProviderID = @Provider AND b.BankCode ='LSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='QLBANK'and a.ProviderID = @Provider AND b.BankCode ='QLBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'QLBANK' and a.ProviderID = @Provider AND b.BankCode ='QLBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='YTBANK'and a.ProviderID = @Provider AND b.BankCode ='YTBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'YTBANK' and a.ProviderID = @Provider AND b.BankCode ='YTBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CRCBANK'and a.ProviderID = @Provider AND b.BankCode ='CRCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CRCBANK' and a.ProviderID = @Provider AND b.BankCode ='CRCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HBC'and a.ProviderID = @Provider AND b.BankCode ='HBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HBC' and a.ProviderID = @Provider AND b.BankCode ='HBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZGCCB'and a.ProviderID = @Provider AND b.BankCode ='ZGCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZGCCB' and a.ProviderID = @Provider AND b.BankCode ='ZGCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='YZBANK'and a.ProviderID = @Provider AND b.BankCode ='YZBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'YZBANK' and a.ProviderID = @Provider AND b.BankCode ='YZBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOYK'and a.ProviderID = @Provider AND b.BankCode ='BOYK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOYK' and a.ProviderID = @Provider AND b.BankCode ='BOYK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='LZYH'and a.ProviderID = @Provider AND b.BankCode ='LZYH'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'LZYH' and a.ProviderID = @Provider AND b.BankCode ='LZYH'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='LSBC'and a.ProviderID = @Provider AND b.BankCode ='LSBC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'LSBC' and a.ProviderID = @Provider AND b.BankCode ='LSBC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HRXJB'and a.ProviderID = @Provider AND b.BankCode ='HRXJB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HRXJB' and a.ProviderID = @Provider AND b.BankCode ='HRXJB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='DLB'and a.ProviderID = @Provider AND b.BankCode ='DLB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'DLB' and a.ProviderID = @Provider AND b.BankCode ='DLB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CCQTGB'and a.ProviderID = @Provider AND b.BankCode ='CCQTGB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CCQTGB' and a.ProviderID = @Provider AND b.BankCode ='CCQTGB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='DYCCB'and a.ProviderID = @Provider AND b.BankCode ='DYCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'DYCCB' and a.ProviderID = @Provider AND b.BankCode ='DYCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GRCB'and a.ProviderID = @Provider AND b.BankCode ='GRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GRCB' and a.ProviderID = @Provider AND b.BankCode ='GRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='FJNX'and a.ProviderID = @Provider AND b.BankCode ='FJNX'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'FJNX' and a.ProviderID = @Provider AND b.BankCode ='FJNX'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GHB'and a.ProviderID = @Provider AND b.BankCode ='GHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GHB' and a.ProviderID = @Provider AND b.BankCode ='GHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CSRCB'and a.ProviderID = @Provider AND b.BankCode ='CSRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CSRCB' and a.ProviderID = @Provider AND b.BankCode ='CSRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CDCB'and a.ProviderID = @Provider AND b.BankCode ='CDCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CDCB' and a.ProviderID = @Provider AND b.BankCode ='CDCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HKB'and a.ProviderID = @Provider AND b.BankCode ='HKB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HKB' and a.ProviderID = @Provider AND b.BankCode ='HKB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SJBANK'and a.ProviderID = @Provider AND b.BankCode ='SJBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SJBANK' and a.ProviderID = @Provider AND b.BankCode ='SJBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOSZ'and a.ProviderID = @Provider AND b.BankCode ='BOSZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOSZ' and a.ProviderID = @Provider AND b.BankCode ='BOSZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='TZCB'and a.ProviderID = @Provider AND b.BankCode ='TZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'TZCB' and a.ProviderID = @Provider AND b.BankCode ='TZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='WZCB'and a.ProviderID = @Provider AND b.BankCode ='WZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'WZCB' and a.ProviderID = @Provider AND b.BankCode ='WZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZZBANK'and a.ProviderID = @Provider AND b.BankCode ='ZZBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZZBANK' and a.ProviderID = @Provider AND b.BankCode ='ZZBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='DLRCB'and a.ProviderID = @Provider AND b.BankCode ='DLRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'DLRCB' and a.ProviderID = @Provider AND b.BankCode ='DLRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GSBANK'and a.ProviderID = @Provider AND b.BankCode ='GSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GSBANK' and a.ProviderID = @Provider AND b.BankCode ='GSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GYCB'and a.ProviderID = @Provider AND b.BankCode ='GYCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GYCB' and a.ProviderID = @Provider AND b.BankCode ='GYCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZYCBANK'and a.ProviderID = @Provider AND b.BankCode ='ZYCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZYCBANK' and a.ProviderID = @Provider AND b.BankCode ='ZYCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HSBANK'and a.ProviderID = @Provider AND b.BankCode ='HSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HSBANK' and a.ProviderID = @Provider AND b.BankCode ='HSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='LANGFB'and a.ProviderID = @Provider AND b.BankCode ='LANGFB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'LANGFB' and a.ProviderID = @Provider AND b.BankCode ='LANGFB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='XABANK'and a.ProviderID = @Provider AND b.BankCode ='XABANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'XABANK' and a.ProviderID = @Provider AND b.BankCode ='XABANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CDRCB'and a.ProviderID = @Provider AND b.BankCode ='CDRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CDRCB' and a.ProviderID = @Provider AND b.BankCode ='CDRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HKBEA'and a.ProviderID = @Provider AND b.BankCode ='HKBEA'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HKBEA' and a.ProviderID = @Provider AND b.BankCode ='HKBEA'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BHB'and a.ProviderID = @Provider AND b.BankCode ='BHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BHB' and a.ProviderID = @Provider AND b.BankCode ='BHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ARCU'and a.ProviderID = @Provider AND b.BankCode ='ARCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ARCU' and a.ProviderID = @Provider AND b.BankCode ='ARCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BJRCB'and a.ProviderID = @Provider AND b.BankCode ='BJRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BJRCB' and a.ProviderID = @Provider AND b.BankCode ='BJRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CZCB'and a.ProviderID = @Provider AND b.BankCode ='CZCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CZCB' and a.ProviderID = @Provider AND b.BankCode ='CZCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GDRCC'and a.ProviderID = @Provider AND b.BankCode ='GDRCC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GDRCC' and a.ProviderID = @Provider AND b.BankCode ='GDRCC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GXRCU'and a.ProviderID = @Provider AND b.BankCode ='GXRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GXRCU' and a.ProviderID = @Provider AND b.BankCode ='GXRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GZRCU'and a.ProviderID = @Provider AND b.BankCode ='GZRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GZRCU' and a.ProviderID = @Provider AND b.BankCode ='GZRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HLJRCU'and a.ProviderID = @Provider AND b.BankCode ='HLJRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HLJRCU' and a.ProviderID = @Provider AND b.BankCode ='HLJRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HNRCU'and a.ProviderID = @Provider AND b.BankCode ='HNRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HNRCU' and a.ProviderID = @Provider AND b.BankCode ='HNRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HURCB'and a.ProviderID = @Provider AND b.BankCode ='HURCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HURCB' and a.ProviderID = @Provider AND b.BankCode ='HURCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JLRCU'and a.ProviderID = @Provider AND b.BankCode ='JLRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JLRCU' and a.ProviderID = @Provider AND b.BankCode ='JLRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JSRCU'and a.ProviderID = @Provider AND b.BankCode ='JSRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JSRCU' and a.ProviderID = @Provider AND b.BankCode ='JSRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JXRCU'and a.ProviderID = @Provider AND b.BankCode ='JXRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JXRCU' and a.ProviderID = @Provider AND b.BankCode ='JXRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='MTBANK'and a.ProviderID = @Provider AND b.BankCode ='MTBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'MTBANK' and a.ProviderID = @Provider AND b.BankCode ='MTBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SCRCU'and a.ProviderID = @Provider AND b.BankCode ='SCRCU'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SCRCU' and a.ProviderID = @Provider AND b.BankCode ='SCRCU'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SPDB'and a.ProviderID = @Provider AND b.BankCode ='SPDB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SPDB' and a.ProviderID = @Provider AND b.BankCode ='SPDB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='TCRCB'and a.ProviderID = @Provider AND b.BankCode ='TCRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'TCRCB' and a.ProviderID = @Provider AND b.BankCode ='TCRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='TJBHB'and a.ProviderID = @Provider AND b.BankCode ='TJBHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'TJBHB' and a.ProviderID = @Provider AND b.BankCode ='TJBHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='WHCCB'and a.ProviderID = @Provider AND b.BankCode ='WHCCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'WHCCB' and a.ProviderID = @Provider AND b.BankCode ='WHCCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='WHRCB'and a.ProviderID = @Provider AND b.BankCode ='WHRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'WHRCB' and a.ProviderID = @Provider AND b.BankCode ='WHRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='YNRCC'and a.ProviderID = @Provider AND b.BankCode ='YNRCC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'YNRCC' and a.ProviderID = @Provider AND b.BankCode ='YNRCC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZJNX'and a.ProviderID = @Provider AND b.BankCode ='ZJNX'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZJNX' and a.ProviderID = @Provider AND b.BankCode ='ZJNX'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZJTLCB'and a.ProviderID = @Provider AND b.BankCode ='ZJTLCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZJTLCB' and a.ProviderID = @Provider AND b.BankCode ='ZJTLCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOB'and a.ProviderID = @Provider AND b.BankCode ='BDCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOB' and a.ProviderID = @Provider AND b.BankCode ='BDCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CDBANK'and a.ProviderID = @Provider AND b.BankCode ='BOCD'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CDBANK' and a.ProviderID = @Provider AND b.BankCode ='BOCD'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CBHB'and a.ProviderID = @Provider AND b.BankCode ='BOHAIB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CBHB' and a.ProviderID = @Provider AND b.BankCode ='BOHAIB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='QHRC'and a.ProviderID = @Provider AND b.BankCode ='BOQH'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'QHRC' and a.ProviderID = @Provider AND b.BankCode ='BOQH'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='QZCCB'and a.ProviderID = @Provider AND b.BankCode ='BOQZ'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'QZCCB' and a.ProviderID = @Provider AND b.BankCode ='BOQZ'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CCAB'and a.ProviderID = @Provider AND b.BankCode ='CABANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CCAB' and a.ProviderID = @Provider AND b.BankCode ='CABANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='PWEB'and a.ProviderID = @Provider AND b.BankCode ='CGNB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'PWEB' and a.ProviderID = @Provider AND b.BankCode ='CGNB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='CNCB'and a.ProviderID = @Provider AND b.BankCode ='CITIC'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'CNCB' and a.ProviderID = @Provider AND b.BankCode ='CITIC'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BCM'and a.ProviderID = @Provider AND b.BankCode ='COMM'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BCM' and a.ProviderID = @Provider AND b.BankCode ='COMM'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JNRCB'and a.ProviderID = @Provider AND b.BankCode ='CZRCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JNRCB' and a.ProviderID = @Provider AND b.BankCode ='CZRCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='LJBANK'and a.ProviderID = @Provider AND b.BankCode ='DAQINGB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'LJBANK' and a.ProviderID = @Provider AND b.BankCode ='DAQINGB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='DRCB'and a.ProviderID = @Provider AND b.BankCode ='DRCBCL'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'DRCB' and a.ProviderID = @Provider AND b.BankCode ='DRCBCL'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='GLB'and a.ProviderID = @Provider AND b.BankCode ='GLBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'GLB' and a.ProviderID = @Provider AND b.BankCode ='GLBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOIMC'and a.ProviderID = @Provider AND b.BankCode ='H3CB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOIMC' and a.ProviderID = @Provider AND b.BankCode ='H3CB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='HXB'and a.ProviderID = @Provider AND b.BankCode ='HXBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'HXB' and a.ProviderID = @Provider AND b.BankCode ='HXBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JJCCB'and a.ProviderID = @Provider AND b.BankCode ='JJBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JJCCB' and a.ProviderID = @Provider AND b.BankCode ='JJBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='BOJN'and a.ProviderID = @Provider AND b.BankCode ='JNBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'BOJN' and a.ProviderID = @Provider AND b.BankCode ='JNBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='JSBC'and a.ProviderID = @Provider AND b.BankCode ='JSBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'JSBC' and a.ProviderID = @Provider AND b.BankCode ='JSBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='NRCB'and a.ProviderID = @Provider AND b.BankCode ='NHB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'NRCB' and a.ProviderID = @Provider AND b.BankCode ='NHB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='PAB'and a.ProviderID = @Provider AND b.BankCode ='SPABANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'PAB' and a.ProviderID = @Provider AND b.BankCode ='SPABANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='SZSCCB'and a.ProviderID = @Provider AND b.BankCode ='SZSBK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'SZSCCB' and a.ProviderID = @Provider AND b.BankCode ='SZSBK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='QSB'and a.ProviderID = @Provider AND b.BankCode ='ZBCB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'QSB' and a.ProviderID = @Provider AND b.BankCode ='ZBCB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='RCBOZ'and a.ProviderID = @Provider AND b.BankCode ='ZRCBANK'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'RCBOZ' and a.ProviderID = @Provider AND b.BankCode ='ZRCBANK'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZYBANK'and a.ProviderID = @Provider AND b.BankCode ='ZYB'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZYBANK' and a.ProviderID = @Provider AND b.BankCode ='ZYB'

SELECT * FROM ProviderBankCode a CROSS JOIN Bank b
WHERE a.code ='ZZB'and a.ProviderID = @Provider AND b.BankCode ='ZZYH'
AND NOT EXISTS(SELECT 1 FROM [dbo].[PaymentTypeGatewaySupportBankSetting] WITH (NOLOCK) WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID and BankID = b.BankID)
INSERT INTO PaymentTypeGatewaySupportBankSetting (PaymentTypeGatewaySettingID, BankID)
SELECT @PaymentTypeGatewaySettingID, b.BankID FROM ProviderBankCode a CROSS JOIN Bank b WHERE a.code = 'ZZB' and a.ProviderID = @Provider AND b.BankCode ='ZZYH'
