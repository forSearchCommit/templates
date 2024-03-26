USE GCT_P003
GO 

DECLARE @PaymentTypeGatewaySettingID INT = 999, -- MMPay
		@AuthUrl NVARCHAR(500) = 'pay.wlb.prod'

ALTER TABLE [dbo].[PaymentTypeGatewaySetting] DISABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;

UPDATE [dbo].[PaymentTypeGatewaySetting] SET [AuthorizationURL] = @AuthUrl WHERE PaymentTypeGatewaySettingID = @PaymentTypeGatewaySettingID

ALTER TABLE [dbo].[PaymentTypeGatewaySetting] ENABLE TRIGGER PaymentTypeGatewaySettingAuditLogTrigger;