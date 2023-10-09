DECLARE @PaymentTypeID INT ;
DECLARE @PaymentOptionID INT;  

SET @PaymentTypeID = 103     ;  
SET @PaymentOptionID = 9;
SELECT    
		PO.WebsiteID,                      
        PO.PaymentOptionTypeID ,        
        PO.TransactionTypeID ,        
        PTGS.PaymentTypeGatewaySettingID ,        
        PTGS.PaymentOptionID ,        
        PTGS.paymentTypeID ,        
        PTGS.TransactionPrefix ,        
        PTGS.MerchantID ,        
        PTGS.SecureKey ,        
        PTGS.ProviderDepositURL ,     
		PTGS.ProviderCancelTransactionURL ,  
        PTGS.ProxyDepositURL ,        
        PTGS.ProxyNotifyURL ,        
        PTGS.ProxyRedirectURL,        
        PTGS.IsAutoRejectActivated,        
        PTGS.TransRejectInterval,        
		PTGS.PaymentGatewayServerIP,        
		PTGS.MerchantAccountNo,        
		PTGS.SecureKey2,        
		PTGS.SecureKey3,        
		PTGS.AuthorizationURL,        
		PTGS.Status,  
		PTGS.MinPerTransaction,  
		PTGS.MaxPerTransaction,  
		PTGS.Currency,
		PTGS.IsFixedAmount,
		PTGS.CoinValue,
		PTGS.IsAnyAmount,
		PTGS.IsPopUpProviderPage,
		PTGS.IsActiveAmountBuffer,
		PTGS.AmountBufferInterval
    FROM      
		PaymentTypeGatewaySetting PTGS (NOLOCK)     
        INNER JOIN PaymentOption PO ON PO.PaymentOptionID = PTGS.PaymentOptionID        
    WHERE     
		PTGS.paymentTypeID = @PaymentTypeID        
        AND PTGS.PaymentOptionID = @PaymentOptionID        
                        
    SELECT    
		PTGSBS.BankID ,        
        B.BankCode ,        
        B.BankName ,        
		B.BankImage,        
		B.BankImageName,        
		B.BankStatus,      
		C.Name AS [CountryName],      
		C.CountryID,      
		C.Code AS [CountryCode]      
    FROM      
		PaymentTypeGatewaySupportBankSetting PTGSBS (NOLOCK)  
		INNER JOIN Bank B ON PTGSBS.BankID = B.BankID        
		INNER JOIN PaymentTypeGatewaySetting PTGS ON PTGS.PaymentTypeGatewaySettingID = PTGSBS.PaymentTypeGatewaySettingID        
		INNER JOIN Country C ON B.CountryID = C.CountryID      
    WHERE     
		PTGS.paymentTypeID = @PaymentTypeID        
        AND PTGS.PaymentOptionID = @PaymentOptionID        
    ORDER BY   
		PTGSBS.SupportBankSettingID    
  
  	SELECT 
	PTGSK.* 
	FROM
		PaymentTypeGatewaySecureKey PTGSK (NOLOCK)
	WHERE PTGSK.PaymentTypeGatewaySettingID = (SELECT TOP 1 PaymentTypeGatewaySettingID FROM PaymentTypeGatewaySetting WITH (NOLOCK) WHERE PaymentTypeID = @PaymentTypeID AND PaymentOptionID = @PaymentOptionID);