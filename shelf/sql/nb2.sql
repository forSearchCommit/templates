select a.DrawId, a.MbrCode, a.PrizeGrpId, b.WinCombinationCountId, c.Currency,
d.DisplayName, d.Rank, d.USDTAmt, d.RMBAmt, d.ChurnMultp, d.IsRandomized,
e.DisplayName, e.TotalCount, e.RemainCount, e.InitialAssignCount

from Spw_DrawPrizeList a
join Spw_PrizeGrpList b on a.PrizeGrpId = b.Id
join Spw_MbrList c on a.MbrCode  = c.MbrCode
join Spw_PrizeList d on d.PrizeGrpId = a.PrizeGrpId
join Slot_WinCombinationCount e on b.WinCombinationCountId = e.WinCombinationCountId

where a.drawid = 655
and a.Active = 1
and b.Active = 1
and c.Active = 1
and c.DrawId = 655
and d.Active = 1
and e.DrawId = 655
order by PrizeGrpId

select * from tblCampaignDetails where DrawId = 579 and IsMemberImported = 1

select a.DrawId, a.MbrCode, b.Currency, c.WinCombinationCountId
from Spw_DrawPrizeList a 
JOIN Spw_MbrList b ON a.MbrCode = b.MbrCode
Join Spw_PrizeGrpList c on a.WinCombinationId = c.WinCombinationCountId

where a.DrawId = 579 and a.Active = 1
group by a.DrawId, a.MbrCode, b.Currency, c.WinCombinationCountId
--SELEct * from Spw_MbrList

select * from Slot_WinCombinationCount where WinCombinationCountId = 395
select * from Spw_PrizeGrpList where id = 11052

SELECT 
	Slot_WinCombinationCount.DisplayName AS PrizeDisplayName, 
	Slot_WinCombinationCount.TotalCount,
	Slot_WinCombinationCount.InitialAssignCount AS GivenCount,
	USDTAmt, 
	RMBAmt, 
	ChurnMultp AS ChurnMultiplier,
	Spw_PrizeGrpList.WinCombinationCountId
FROM Spw_PrizeGrpList WITH (NOLOCK)
JOIN Spw_PrizeList ON Spw_PrizeGrpList.Id = Spw_PrizeList.PrizeGrpId
JOIN Slot_WinCombinationCount ON Spw_PrizeGrpList.WinCombinationCountId = Slot_WinCombinationCount.WinCombinationCountId
WHERE  Spw_PrizeGrpList.DrawId = 579
GROUP BY 
	Slot_WinCombinationCount.DisplayName, 
	Slot_WinCombinationCount.TotalCount,
	Slot_WinCombinationCount.InitialAssignCount,
	USDTAmt, 
	RMBAmt, 
	ChurnMultp,
	Spw_PrizeGrpList.WinCombinationCountId

select a.DrawId, a.MbrCode, b.WinCombinationCountId, c.Currency,
d.DisplayName, d.Rank, d.USDTAmt, d.RMBAmt, d.ChurnMultp, d.IsRandomized,
e.DisplayName, e.TotalCount, e.RemainCount, e.InitialAssignCount

from Spw_DrawPrizeList a
join Spw_PrizeGrpList b on a.PrizeGrpId = b.Id
join Spw_MbrList c on a.MbrCode  = c.MbrCode
join Spw_PrizeList d on d.PrizeGrpId = a.PrizeGrpId
join Slot_WinCombinationCount e on b.WinCombinationCountId = e.WinCombinationCountId

where a.drawid = 655
and a.Active = 1
and b.Active = 1
and c.Active = 1
and c.DrawId =655
and d.Active = 1

-- SELECT * FROM Spw_PrizeGrpList WHERE DrawId = 655

-- SELECT * FROM Slot_WinCombinationCount WHERE DrawId = 655

-- SELECT * FROM Spw_DrawPrizeList WHERE DrawId = 655 AND Id = 4246574


-- SELECT * FROM Spw_PrizeGrpList WHERE DrawId = 655 AND Id = 11052
--  WITH SELECTEDROWS AS (
--     SELECT * FROM Spw_DrawPrizeList WHERE DrawId = 655 AND PrizeGrpId NOT IN (
--     SELECT Id FROM Spw_PrizeGrpList WHERE DrawId = 655)
--  )
-- UPDATE SELECTEDROWS
-- SET  Active = 0

-- SELECT * FROM Slot_WinCombinationCount where  DrawId = 655


-- select * from Spw_DrawPrizeList where PrizeGrpId = 7698

-- IF(SELECT IsMemberImported FROM tblCampaignDetails WHERE DrawId = 655)

-- SELECT
--     -- Other columns,
DECLARE @IsMemberImported INT;

SELECT @IsMemberImported = IsMemberImported
FROM tblCampaignDetails
WHERE DrawId = 655;

IF @IsMemberImported = 1
BEGIN
    SELECT 
        @IsMemberImported AS IsMemberImported,
        C.DisplayName AS PrizeDisplayName,
        C.TotalCount, 
        C.InitialAssignCount AS GivenCount, 
        E.USDTAmt, E.RMBAmt, 
        E.ChurnMultp AS ChurnMultiplier,
        C.WinCombinationCountId,
        D.Currency,
        COUNT(*) AS RecordCount
    FROM Spw_DrawPrizeList A
    JOIN Spw_PrizeGrpList B ON A.PrizeGrpId = B.Id
    JOIN  Slot_WinCombinationCount C ON B.WinCombinationCountId = C.WinCombinationCountId
    JOIN Spw_MbrList D ON D.MbrCode = A.MbrCode
    JOIN Spw_PrizeList E ON E.PrizeGrpId = A.PrizeGrpId
    WHERE 
    A.DrawId = 655
    AND A.Active = 1
    AND B.Active = 1
    AND D.DrawId = 655
    AND E.Active = 1
    GROUP BY
        C.TotalCount, C.RemainCount, C.InitialAssignCount, C.DisplayName, c.WinCombinationCountId,
        D.Currency,
        E.USDTAmt, E.RMBAmt, E.ChurnMultp, E.Rank, E.IsRandomized


END
ELSE
BEGIN
    -- Your logic when the condition is false
    SELECT 
		Slot_WinCombinationCount.DisplayName AS PrizeDisplayName, 
		Slot_WinCombinationCount.TotalCount,
		Slot_WinCombinationCount.InitialAssignCount AS GivenCount,
		USDTAmt, 
		RMBAmt, 
		ChurnMultp AS ChurnMultiplier,
		Spw_PrizeGrpList.WinCombinationCountId
	FROM Spw_PrizeGrpList WITH (NOLOCK)
	JOIN Spw_PrizeList ON Spw_PrizeGrpList.Id = Spw_PrizeList.PrizeGrpId
	JOIN Slot_WinCombinationCount ON Spw_PrizeGrpList.WinCombinationCountId = Slot_WinCombinationCount.WinCombinationCountId
	WHERE  Spw_PrizeGrpList.DrawId = 655
	GROUP BY 
		Slot_WinCombinationCount.DisplayName, 
		Slot_WinCombinationCount.TotalCount,
		Slot_WinCombinationCount.InitialAssignCount,
		USDTAmt, 
		RMBAmt, 
		ChurnMultp,
		Spw_PrizeGrpList.WinCombinationCountId
END

SELECT
        CampaignId,
        COUNT(DrawId) AS DrawCount,
        SUM(TotalPending) AS Pending,
        SUM(TotalSuccess) AS Success,
        SUM(TotalClaimedRMB) AS ClaimedRMB,
        SUM(TotalUnclaimedRMB) AS UnclaimedRMB,
        SUM(TotalClaimedUSDT) AS ClaimedUSDT,
        SUM(TotalUnclaimedUSDT) AS UnclaimedUSDT
    FROM dbo.tblStatisticSummary AS a WITH (NOLOCK) 
    GROUP BY CampaignId
    ORDER By CampaignId DESC


	
SELECT DISTINCT 
    o.name AS ObjectName
FROM sys.sql_modules m
INNER JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition LIKE '%tblReward%'
ORDER BY  o.name;



--                       FROM      dbo.tblStatisticSummary AS a WITH (nolock)
-- vwPromotionStatistic
--                       vwDrawStatistic



-- CREATE VIEW [dbo].[vwPromotionStatistic]
-- AS
-- WITH s AS (SELECT CampaignId, COUNT(DrawId) AS DrawCount, SUM(TotalPending) AS Pending, SUM(TotalSuccess) AS Success, SUM(TotalClaimedRMB) AS ClaimedRMB, SUM(TotalUnclaimedRMB) AS UnclaimedRMB, SUM(TotalClaimedUSDT) 
--                                         AS ClaimedUSDT, SUM(TotalUnclaimedUSDT) AS UnclaimedUSDT
--                       FROM      dbo.tblStatisticSummary AS a WITH (nolock)
--                       GROUP BY CampaignId)
--     SELECT b.CampaignTypeId, b.Title, b.StartDate, b.EndDate, c.DrawCount, b.Status, c.Pending, c.Success, c.ClaimedRMB, c.UnclaimedRMB, c.ClaimedUSDT, c.UnclaimedUSDT
--     FROM     s AS c LEFT OUTER JOIN
--                       dbo.tblPromotionCampaign AS b WITH (nolock) ON c.CampaignId = b.RowId

EXEC sp_helptext 'vwPromotionStatistic';
EXEC sp_helptext 'vwDrawStatistic';
EXEC sp_helptext 'Trigger_UpdateStatistic';

SELECT 
        C.TotalCount, C.RemainCount, C.InitialAssignCount, C.DisplayName,
        D.Currency,
        E.USDTAmt, E.RMBAmt, E.ChurnMultp, E.Rank, E.IsRandomized,
        COUNT(*) AS RecordCount
    FROM Spw_DrawPrizeList A
    JOIN Spw_PrizeGrpList B ON A.PrizeGrpId = B.Id
    JOIN  Slot_WinCombinationCount C ON B.WinCombinationCountId = C.WinCombinationCountId
    JOIN Spw_MbrList D ON D.MbrCode = A.MbrCode
    JOIN Spw_PrizeList E ON E.PrizeGrpId = A.PrizeGrpId
    WHERE 
    A.DrawId = 655
    AND A.Active = 1
    AND B.Active = 1
    AND D.DrawId = 655
    AND E.Active = 1
    GROUP BY
        C.TotalCount, C.RemainCount, C.InitialAssignCount, C.DisplayName,
        D.Currency,
        E.USDTAmt, E.RMBAmt, E.ChurnMultp, E.Rank, E.IsRandomized