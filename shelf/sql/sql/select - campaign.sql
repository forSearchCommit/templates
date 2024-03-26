SELECT TOP 3 * from tblCampaignDetails ORDER BY CreatedDate DESC 
SELECT TOP 5 * from Slot_WinCombinationCount ORDER BY CreatedDate DESC
-- SELECT TOP 3 * from Slot_SpinSetting ORDER BY CreatedDate DESC
-- SELECT Top 17 * from Slot_SpinSettingDetail ORDER BY CreatedDate DESC
-- SELECT TOP 1 * from tblCampaignDetails ORDER BY CreatedDate DESC
-- SELECT TOP 1 * from tblCampaignDetails ORDER BY CreatedDate DESC
-- SELECT TOP 1 * from tblCampaignDetails ORDER BY CreatedDate DESC
-- SELECT TOP 1 * from tblCampaignDetails ORDER BY CreatedDate DESC
-- SELECT TOP 1 * from tblCampaignDetails ORDER BY CreatedDate DESC
-- SELECT * FROM Spw_DrawPrizeList
SELECT top 5 * FROM Spw_PrizeList ORDER BY CreatedDate DESC 
SELECT top 5 * FROM Spw_PrizeGrpList ORDER BY CreatedDate DESC
-- SELECT top 3 * FROM Slot_WinCombinationCount ORDER BY CreatedDate DESC


-- SELECT
--     StakeAmtRMB AS StakeRmb,
--     StakeAmtUSDT AS StakeUsdt,
--     MAX(CASE WHEN VIPLevel = 1 THEN TotalSpin END) AS "Vip1",
--     MAX(CASE WHEN VIPLevel = 2 THEN TotalSpin END) AS "Vip2",
--     MAX(CASE WHEN VIPLevel = 3 THEN TotalSpin END) AS "Vip3",
--     MAX(CASE WHEN VIPLevel = 4 THEN TotalSpin END) AS "Vip4",
--     MAX(CASE WHEN VIPLevel = 5 THEN TotalSpin END) AS "Vip5",
--     MAX(CASE WHEN VIPLevel = 6 THEN TotalSpin END) AS "Vip6",
--     MAX(CASE WHEN VIPLevel = 7 THEN TotalSpin END) AS "Vip7",
--     MAX(CASE WHEN VIPLevel = 8 THEN TotalSpin END) AS "Vip8"
-- FROM Slot_SpinSettingDetail WITH (NOLOCK)
-- WHERE SpinSettingId = 30 
-- GROUP BY StakeAmtRMB, StakeAmtUSDT;

select * from Slot_SpinSetting where DrawId = 626
SELECT * from Slot_SpinSettingDetail where SpinSettingId = 47
SELECT CampaignId, PreStart, StartDate, EndDate FROM tblCampaignDetails WHERE DrawId = 625
SELECT Id, DateFrom, DateTo from Slot_SpinSetting WHERE DrawId = 609

-- select Id from Slot_SpinSetting
-- SELECT 
-- CD.CampaignId AS CampaignId,
-- CD.PreStart AS PreStart, 
-- CD.StartDate AS StartDate, 
-- CD.EndDate AS EndDate, 
-- SS.DateFrom AS FromDate, 
-- SS.DateTo AS ToDate,
-- SS.Id AS SpinSettingId
-- FROM tblCampaignDetails CD
-- JOIN Slot_SpinSetting SS ON CD.DrawId = SS.DrawId
-- WHERE CD.DrawId = 609;
-- SELECT
--     StakeAmtRMB AS StakeRmb,
--     StakeAmtUSDT AS StakeUsdt,
--     MAX(CASE WHEN VIPLevel = 1 THEN TotalSpin END) AS "Vip1",
--     MAX(CASE WHEN VIPLevel = 2 THEN TotalSpin END) AS "Vip2",
--     MAX(CASE WHEN VIPLevel = 3 THEN TotalSpin END) AS "Vip3",
--     MAX(CASE WHEN VIPLevel = 4 THEN TotalSpin END) AS "Vip4",
--     MAX(CASE WHEN VIPLevel = 5 THEN TotalSpin END) AS "Vip5",
--     MAX(CASE WHEN VIPLevel = 6 THEN TotalSpin END) AS "Vip6",
--     MAX(CASE WHEN VIPLevel = 7 THEN TotalSpin END) AS "Vip7",
--     MAX(CASE WHEN VIPLevel = 8 THEN TotalSpin END) AS "Vip8"
-- FROM Slot_SpinSettingDetail
-- WHERE SpinSettingId = 30
-- GROUP BY StakeAmtRMB, StakeAmtUSDT;
-- WITH (NOLOCK)

-- SELECT *
-- from Slot_SpinSettingDetail WHERE SpinSettingId = 10


-- SELECT

-- SELECT * FROM Spw_PrizeGrpList WHERE DrawId = 625

SELECT 
A.Code, 
A.DisplayName, 
A.USDTAmt, 
A.RMBAmt, 
A.ChurnMultp, 
A.IsRandomized, 
A.Rank,
C.TotalCount
From Spw_PrizeList AS A
Join Spw_PrizeGrpList AS B On A.PrizeGrpId = B.Id
Join Slot_WinCombinationCount AS C On B.WinCombinationCountId = C.WinCombinationCountId
where 
PrizeGrpId in (select Id from Spw_PrizeGrpList where DrawId = 625)


SELECT