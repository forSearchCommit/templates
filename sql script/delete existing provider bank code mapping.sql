DECLARE @firstID NVARCHAR(50)
DECLARE @lastID NVARCHAR(50)

select Top 1 @firstID = ProviderBankCodeID
from ProviderBankCode
where providerID = 38
ORDER BY ProviderBankCodeID ASC;

select Top 1 @lastID = ProviderBankCodeID
from ProviderBankCode
where providerID = 38
ORDER BY ProviderBankCodeID DESC;
DELETE FROM ProviderBankCodeMapping
WHERE ProviderBankCodeID BETWEEN @firstID AND @lastID;


