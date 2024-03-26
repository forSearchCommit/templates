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
-- Create date: <03/01/2024>
-- Description:	<GetHistoryWithDrawId _ Add SP>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCampaign_SPW_GetHistoryWithDrawId]
	-- Add the parameters for the stored procedure here
	@MbrCode		NVARCHAR(50) = NULL,
	@Status			NVARCHAR(1)	 = NULL,
	@DateFrom		DATETIME	 = NULL,
	@DateTo			DATETIME	 = NULL,
	@PageNum		INT			 = NULL,
	@PageSize		INT			 = NULL,
	@DrawId 		INT			 = NULL,
	@TotalRecord	INT OUTPUT
AS
BEGIN
	--	=================================
	--	DECLARE 
	--	=================================
	DECLARE 
	@SQLQuery	NVARCHAR(MAX) = '',
	@SQLFilter	NVARCHAR(MAX) = '',
	@SQLOrder	NVARCHAR(MAX) = ''

	--	=================================
	--	VALIDATION 
	--	=================================

	--	=================================
	--	FILTER
	--	=================================
	--IF ISNULL(@MbrCode, '') <> ''
	BEGIN
	   SET @SQLFilter = @SQLFilter + ' AND a.MbrCode = ''' + @MbrCode + '''';
       SET @SQLFilter = @SQLFilter + ' AND a.DrawId = ' + CAST(@DrawId AS NVARCHAR(MAX));
	END

	IF ISNULL(@Status, '') <> ''
	BEGIN
	   SET @SQLFilter = @SQLFilter + ' AND a.Status = ''' + @Status + '''';
	END

	IF ISNULL(@DateFrom, '') <> ''
	BEGIN
	   SET @SQLFilter = @SQLFilter + ' AND a.CreatedDate >= ''' + CONVERT(NVARCHAR(50), @DateFrom) + '''';
	END

	IF ISNULL(@DateTo, '') <> ''
	BEGIN
	   SET @SQLFilter = @SQLFilter + ' AND a.CreatedDate < ''' + CONVERT(NVARCHAR, DATEADD(DAY, 1, @DateTo)) + '''';
	END

	IF ISNULL(@PageSize, '') = ''
	BEGIN 
		SET @PageNum = 0;

		DECLARE @sql NVARCHAR(MAX) = ' SELECT @TotalRecord = COUNT(Id) FROM Spw_DrawResult a WITH (NOLOCK) WHERE 1=1 ' + @SQLFilter
		EXEC sp_executesql @sql, N'@TotalRecord INT OUTPUT', @TotalRecord OUTPUT
		
		SELECT @PageSize = @TotalRecord

		IF @PageSize = 0 
		BEGIN
			SELECT @PageSize = 1
		END
		
	END
	
	--	=================================
	--	PAGING
	--	=================================

	SET @SQLOrder = @SQLOrder + ' ORDER BY a.CreatedDate DESC OFFSET ' + CAST(@PageNum AS NVARCHAR) + ' ROWS FETCH NEXT ' + CAST(@PageSize AS NVARCHAR) + ' ROWS ONLY '

	--	=================================
	--	QUERY
	--	=================================
	SET @SQLQuery = ' SELECT a.Id, a.MbrCode, a.PrizeName, a.PrizeRank, a.[Status], a.ClaimedDate
					  FROM Spw_DrawResult a WITH (NOLOCK)
					  WHERE 1=1  
					' + @SQLFilter + @SQLOrder
	
	EXEC sp_executesql @SQLQuery

END
GO
