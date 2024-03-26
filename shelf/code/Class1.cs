public string ParseWithdrawalNotify(HttpContext context,
                                   out PaymentEnum.PaymentWithdrawalStatus status,
                                   out string gatewayRefId,
                                   out string successDateTime,
                                   out string message,
                                   out string returnMessage)
{
    status = PaymentEnum.PaymentWithdrawalStatus.Successful;
    gatewayRefId = null;
    successDateTime = null;
    message = "fail";
    returnMessage = string.Empty;

    xxPayWithdrawalNotifyModel data;
    string transactionNo;

    ELKLog.LogAction(() =>
    {
        /*Deserialization - Json*/
        string json;
        using (var bodyStream = new StreamReader(context.Request.InputStream))
        {
            bodyStream.BaseStream.Seek(0, SeekOrigin.Begin);
            json = bodyStream.ReadToEnd();
        }
        data = ConvertWithdrawalNotify(json);

        PaymentLogger.Info($"[{_provider} Withdrawal] WD Notify => Content: {data}");
        FileLogger.Instance.Info($"[{_provider} Withdrawal Notify3 - ] [{data.paidAmount.ToString()}]");

        transactionNo = data.merchantOrderId;
        var paymentEntity = PaymentWithdrawalManager.Instance.GetPaymentByPayoutId(0, transactionNo);
        var gatewaySetting = PaymentSettingManager.Instance.GetPaymentTypeGatewaySettingDetails((int)paymentEntity.paymentType, paymentEntity.paymentOptionID);

        var dic = data.AsDictionary(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance, translator: xxPayHelper.Stringify, Query: (prop) => prop);
        var verifyResult = VerifyNotifyWDRequest(dic, gatewaySetting);

    }, OnAfterExecution: _log =>
    {
        _log.setLogIdentity(transactionNo);
        _log.SetValue(Actions: nameof(ParseWithdrawalNotify), _params: dic);
    });

    if (!verifyResult)
    {
        message = $"sign verify fail";
        return null;
    }

    successDateTime = DateTime.Now.ToString();
    returnMessage = string.Empty;

    var remark = $"transactionID:{data.payOrderId}";

    if (data.orderStatus.Equals("3"))
    {
        message = $"Notify success, remark => {remark}";
        status = PaymentEnum.PaymentWithdrawalStatus.Successful;
    }
    else
    {
        message = $"Notify fail, remark => {remark}";
        status = PaymentEnum.PaymentWithdrawalStatus.Failed;
    }

    return transactionNo;
}
