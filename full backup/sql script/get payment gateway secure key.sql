SELECT 
	PTGSK.* 
	FROM
		PaymentTypeGatewaySecureKey PTGSK (NOLOCK)
	WHERE PTGSK.PaymentTypeGatewaySettingID = (
        SELECT TOP 1 PaymentTypeGatewaySettingID 
        FROM PaymentTypeGatewaySetting WITH (NOLOCK) 
        WHERE PaymentTypeID = 86 AND PaymentOptionID = 9);