USE [GCT_P003]
GO

ALTER TABLE [dbo].[PaymentTypeGatewaySecureKey] DISABLE TRIGGER PaymentTypeGatewaySecureKeyUpdateAndInsertAuditLogTrigger;
GO

INSERT [dbo].[PaymentTypeGatewaySecureKey] ([PaymentTypeGatewaySettingID], [KeyName], [KeyValue], [KeyNameForDisplay], [InternalAuditID]) 
VALUES 
(1103, N'Key', N'MIR4CSTJ56PUL5KN', N'商户密钥', NULL)
GO

ALTER TABLE [dbo].[PaymentTypeGatewaySecureKey] ENABLE TRIGGER PaymentTypeGatewaySecureKeyUpdateAndInsertAuditLogTrigger;
GO
