USE [Promotiondb]
GO
/****** Object:  StoredProcedure [dbo].[sp_Slot_Summary_Get_Actual]    Script Date: 1/30/2024 9:44:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Feng Wei>
-- Create date: <30/1/2024>
-- Description:	<Slot Result>
-- =============================================
ALTER PROCEDURE [dbo].[sp_Slot_Summary_Get_Actual]  
 -- Add the parameters for the stored procedure here  
	@DrawId BIGINT	
AS  
BEGIN  
    DECLARE @IsMemberImported INT;

    SELECT @IsMemberImported = IsMemberImported
    FROM tblCampaignDetails
    WHERE DrawId = @DrawId;

	IF @IsMemberImported = 1
    BEGIN
        SELECT 
            1 AS IsMemberImported,
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
        A.DrawId = @DrawId
        AND A.Active = 1
        AND B.Active = 1
        AND D.DrawId = @DrawId
        AND E.Active = 1
        GROUP BY
            C.TotalCount, C.RemainCount, C.InitialAssignCount, C.DisplayName, c.WinCombinationCountId,
            D.Currency,
            E.USDTAmt, E.RMBAmt, E.ChurnMultp, E.Rank, E.IsRandomized

        UNION
        -- Your logic when the condition is false
        SELECT 
            0 AS IsMemberImported,
            Slot_WinCombinationCount.DisplayName AS PrizeDisplayName, 
            Slot_WinCombinationCount.TotalCount,
            Slot_WinCombinationCount.InitialAssignCount AS GivenCount,
            USDTAmt, 
            RMBAmt, 
            ChurnMultp AS ChurnMultiplier,
            Spw_PrizeGrpList.WinCombinationCountId,
            NULL As Currency,
            NULL As RecordCount
        FROM Spw_PrizeGrpList WITH (NOLOCK)
        JOIN Spw_PrizeList ON Spw_PrizeGrpList.Id = Spw_PrizeList.PrizeGrpId
        JOIN Slot_WinCombinationCount ON Spw_PrizeGrpList.WinCombinationCountId = Slot_WinCombinationCount.WinCombinationCountId
        WHERE  Spw_PrizeGrpList.DrawId = @DrawId
        GROUP BY 
            Slot_WinCombinationCount.DisplayName, 
            Slot_WinCombinationCount.TotalCount,
            Slot_WinCombinationCount.InitialAssignCount,
            USDTAmt, 
            RMBAmt, 
            ChurnMultp,
            Spw_PrizeGrpList.WinCombinationCountId

    END
    ELSE
    BEGIN
        -- Your logic when the condition is false
        SELECT 
            @IsMemberImported AS IsMemberImported,
            Slot_WinCombinationCount.DisplayName AS PrizeDisplayName, 
            Slot_WinCombinationCount.TotalCount,
            Slot_WinCombinationCount.InitialAssignCount AS GivenCount,
            USDTAmt, 
            RMBAmt, 
            ChurnMultp AS ChurnMultiplier,
            Spw_PrizeGrpList.WinCombinationCountId,
            NULL As Currency,
            NULL As RecordCount
        FROM Spw_PrizeGrpList WITH (NOLOCK)
        JOIN Spw_PrizeList ON Spw_PrizeGrpList.Id = Spw_PrizeList.PrizeGrpId
        JOIN Slot_WinCombinationCount ON Spw_PrizeGrpList.WinCombinationCountId = Slot_WinCombinationCount.WinCombinationCountId
        WHERE  Spw_PrizeGrpList.DrawId = @DrawId
        GROUP BY 
            Slot_WinCombinationCount.DisplayName, 
            Slot_WinCombinationCount.TotalCount,
            Slot_WinCombinationCount.InitialAssignCount,
            USDTAmt, 
            RMBAmt, 
            ChurnMultp,
            Spw_PrizeGrpList.WinCombinationCountId
    END


END  
