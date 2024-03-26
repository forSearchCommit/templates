USE [GCT_P003]
GO

ALTER TABLE [dbo].[PaymentTypeGatewaySecureKey] DISABLE TRIGGER PaymentTypeGatewaySecureKeyUpdateAndInsertAuditLogTrigger;
GO

INSERT [dbo].[PaymentTypeGatewaySecureKey] ([PaymentTypeGatewaySettingID], [KeyName], [KeyValue], [KeyNameForDisplay], [InternalAuditID]) 
VALUES 
(1047, N'Key', N'mmAutoTestDms2hJ1d04nD', N'商户密钥', NULL),
(1109, N'Key', N'mmAutoTestDms2hJ1d04nD', N'商户密钥', NULL),
(1110, N'Key', N'mmAutoTestDms2hJ1d04nD', N'商户密钥', NULL)
GO

ALTER TABLE [dbo].[PaymentTypeGatewaySecureKey] ENABLE TRIGGER PaymentTypeGatewaySecureKeyUpdateAndInsertAuditLogTrigger;
GO
