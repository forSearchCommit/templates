USE [Promotiondb]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Feng Wei>
-- Create date: <4/1/2024>
-- Description:	<Slot Result>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SPW_GetMemberDrawPrizeId_Slot]  
 -- Add the parameters for the stored procedure here  
    @RoundNo INT,
    @MemberCode NVARCHAR(50),
	@DrawId BIGINT	
AS  
BEGIN  
DECLARE @DrawPrizeId BIGINT

SELECT @DrawPrizeId = DrawPrizeId FROM [dbo].[Spw_DrawResult] 
WHERE MbrCode = @MemberCode AND DrawId = @DrawId AND RoundNo = @RoundNo

SELECT @DrawPrizeId AS RewardId
END  
GO
  
