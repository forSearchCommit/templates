 SELECT a.Id, a.MbrCode, a.PrizeName, a.PrizeRank, a.[Status], a.ClaimedDate         FROM Spw_DrawResult a WITH (NOLOCK)        
  WHERE 1=1          
  AND a.MbrCode = 'adamem38' AND a.CreatedDate >= 'Jan 26 2024  9:00PM'
  AND a.CreatedDate < 'Jan 31 2024  4:00PM' ORDER BY a.CreatedDate DESC OFFSET 1 ROWS FETCH NEXT 99 ROWS ONLY 

  -- =============================================    -- AUTHOR   : JY  -- MODIFIED DATE : 20 MARCH 2023  
  -- DESCRIPTION  : Insert Reward  
  -- =============================================    
  CREATE PROCEDURE [dbo].[sp_SPW_CreateMemberResult]     
  -- Add the parameters for the stored procedure here        
  @AddReward [dbo].[SPW_Create_Member_Result] READONLY  AS    BEGIN      
  declare @UpdatedList as table ( RewardId bigint)    Update b set b.IsClaimed = 1 , 
  UpdatedDate = GETUTCDATE()  output inserted.Id into @UpdatedList  from @AddReward a   
  inner join [Spw_DrawPrizeList] b with (nolock) on a.[RewardId] = b.Id  
  inner join Spw_PrizeList d with (nolock) on a.PrizeId = d.Id  where b.IsClaimed = 0      
  insert into [Spw_DrawResult]  ([MbrCode] ,[DrawId],[PrizeId],[PrizeName],[PrizeRank]   ,[Status],[RoundNo],[CreatedDate],[CreatedBy],[UpdatedDate]   ,[UpdatedBy],[ClaimedDate],DrawPrizeId ,Amount)   select f.MbrCode , b.DrawId , d.Id , isnull(a.PrizeDisplayName, d.DisplayName),d.Rank   ,a.NewStatus , b.RoundNo , GETUTCDATE(),f.MbrCode,GETUTCDATE()   ,f.MbrCode , a.TransactionDate,a.[RewardId], A.CurrencyAmount   from @AddReward a    inner join @UpdatedList e on e.RewardId = a.[RewardId]  inner join [Spw_DrawPrizeList] b with (nolock) on a.[RewardId] = b.Id  inner join Spw_PrizeList d with (nolock) on a.PrizeId = d.Id   inner join [Spw_MbrList] f with (nolock) on a.[MemberRowId] = f.Id       update mt set mt.CurrentSpin = msn.maxSpin , mt.UpdatedDate = GETUTCDATE()   from [Spw_MbrList] mt   inner join    (    select a.[MemberRowId] , max( a.SpinNumber) as maxSpin   from @AddReward a   inner join @UpdatedList b on a.RewardId = b.[RewardId]    inner join [Spw_MbrList] c with (nolock) on a.[MemberRowId] = c.Id    
  Group by a.[MemberRowId]    ) msn on mt.Id = msn.[MemberRowId]          select * from @UpdatedList  END      




  -- =============================================    -- AUTHOR   :   -- CREATE DATE  :   
  -- DESCRIPTION  :     -- AUTHOR   : JACK SOO  -
  - MODIFIED DATE : 29 DEC 2022  -- DESCRIPTION  : ADD 2 COLUMNS (RMBMaxAmount and USDTMaxAmount)  -- 
  =============================================   
   CREATE PROCEDURE [dbo].[sp_GetCampaignCacheData]     
   -- Add the parameters for the stored procedure here     @
   CurrentUTCDate datetime    AS    BEGIN    Declare @CampaignDisableStatus smallint = 3;    D
   eclare @ActiveCampaign as table (CampaignID bigint , StartDate datetime , EndDate datetime , 
   WebUrl nvarchar(max) , MobileH5Url nvarchar(max),MobileAppUrl nvarchar(max),
     ShowFloatingIcon bit ,AppFloatingUrl nvarchar(max) , H5FloatingUrl nvarchar(max));        
     Declare @CurrentDraw as table (DrawId bigint , PreStart datetime , StartDate datetime , 
     EndDate datetime , RewardLimit int , Status smallint ,  MemberBatchId bigint ,  RewardBatchId bigint,
      RMBMaxAmount INT, USDTMaxAmount INT)      
        Declare @EligibleMember as table (RowId bigint,MemberCode nvarchar(50) ,
         Status smallint , Currency nvarchar(10))        
         Declare @RewardList As Table (RowId bigint , Status smallint ,
          Churn int , USDTAmount decimal(18,2) , RMBAmount decimal(18,2), RandomPick bit  ,
          DeductionFactor int , MemberCode nvarchar(50) , ClaimedAmount decimal(18,2))        Declare @MemberClaimList as table (MemberCode nvarchar(50) , Currency nvarchar(10) ,  IsClaimed bit ,  Amount decimal(18,2) , DeductionFactor int)        insert into @ActiveCampaign    select RowId , StartDate , EndDate , WebUrl , MobileH5Url , MobileAppUrl  ,FEShow , AppFloatingUrl,H5FloatingUrl   from tblPromotionCampaign a with (nolock) where CampaignTypeId = 1 AND status <>@CampaignDisableStatus and @CurrentUTCDate between StartDate and EndDate;        if(select count(1) from @ActiveCampaign ) >0    begin        insert into @CurrentDraw    select top 2 DrawId , PreStart ,StartDate , EndDate , rewardlimit , status ,MemberBatchID , RewardBatchID, RMBMaxAmount, USDTMaxAmount  from tblCampaignDetails b with (nolock) where campaignid = (select top 1 CampaignId from @ActiveCampaign) and EndDate>@CurrentUTCDate and Status in(2,3)  order by StartDate asc            declare @CDrawId bigint;    declare @CMemberBatchId bigint;    declare @CRewardBatchId bigint;        select top 1 @CDrawId = DrawId , @CMemberBatchId = MemberBatchId ,@CRewardBatchId = RewardBatchId  from  @CurrentDraw order by StartDate asc        if(@CDrawId is not null )    begin            insert into @RewardList    select RowID , Status ,churn , USDTAmount , RMBAmount , RandomPick , DeductionFactor , MemberId , ClaimedAmount     from tblReward with(nolock) where detailsid = @CDrawId and ImportBatchID = @CRewardBatchId;            insert into @EligibleMember    select RowId,MemberId , Status , Currency from tblrewardmember with(nolock) where detailsid = @CDrawId and ImportBatchID = @CMemberBatchId;        insert into @MemberClaimList    select a.MemberCode , a.Currency , case when a.Status =1 then 1 else 0 end , ISNULL( ClaimedAmount , 0) , isnull(DeductionFactor , 0)     from @EligibleMember  a left join @RewardList b on a.MemberCode = b.MemberCode where a.Status<>0        end    end        select * from @ActiveCampaign    select * from @CurrentDraw    
  select * from @EligibleMember    s

  elect * from @RewardList    
  select * from @MemberClaimList        END  

    -- =============================================    -- AUTHOR   : JACK SOO  
    -- CREATE DATE  : 28 DEC 2022 
     -- DESCRIPTION  : TO GET PENDING UPDATE RECORD OF NOTIFICATION  -- 
     =============================================  
       CREATE PROCEDURE [dbo].[sp_GetScheduledNotificationRecord]     
        AS     BEGIN     
        --  SELECT CAMPAIGN   SELECT     RowId,    Title,    StartDate,    EndDate,    Status,    WebUrl,   
         MobileH5Url,    MobileAppUrl  
          FROM     tblPromotionCampaign    WHERE   
           [Status] IN (1)   ORDER BY    CreatedDate DESC    
            -- SELECT DRAW   SELECT    tblCD.DrawId,    tblCD.CampaignId,    tblCD.TransactionId,  
              tblCD.DrawDate,    tblCD.PreStart,    tblCD.StartDate,    tblCD.EndDate,    tblCD.IsMemberImported,    
              tblCD.IsRewardImported,    tblCD.MemberBatchID,    tblCD.RewardBatchID,    tblCD.RewardLimit,   
               tblCD.Status,    tblCD.CreatedDate,    tblCD.CreatedBy,    tblCD.ModifiedDate,    
               tblCD.ModifiedBy,    tblCD.USDTMaxAmount,    tblCD.RMBMaxAmount  
                FROM     tblCampaignDetails tblCD WITH(NOLOCK)  
                  LEFT JOIN tblPromotionCampaign tblPC ON tblPC.RowId = tblCD.CampaignId   WHERE   
                   tblCD.[Status] IN (1, 2, 3)    AND tblPC.[Status] IN (1)     
                   -- SELECT NOTICE ANNOUNCEMENT   SELECT     tblNA.NoticeID,  
                     tblNA.DrawId,    tblNA.Title,    tblNA.SubContent,    tblNA.PushDate,    
                     tblNA.[Status],    tblNA.CreatedBy,    tblNA.CreatedDate,    tblNA.UpdatedBy,    
                     tblNA.UpdatedDate,    tblNA.Image   FROM   
                      tblNoticeAnnouncement tblNA WITH(NOLOCK)   
                       LEFT JOIN tblCampaignDetails tblCD ON tblCD.DrawId = tblNa.DrawId   WHERE     
                       tblNA.[Status] = 1     AND tblCD.[Status] IN (1, 2, 3)          END       

DECLARE   @CurrentUTCDate datetime  = GETUTCDATE()  , @CampType int = 2    BEGIN   
 Declare @CampaignDisableStatus smallint = 3;   
  Declare @ActiveCampaign as table (CampaignId bigint ,Title nvarchar(250), StartDate datetime  , 
  EndDate datetime, CampaignType smallint , WebUrl nvarchar(max) , MobileH5Url nvarchar(max),MobileAppUrl nvarchar(max) , 
  ShowFloatingIcon bit );      
    Declare @CurrentDraw as table (DrawId bigint , PreStart datetime , StartDate datetime , EndDate datetime , 
     Status smallint ,  LastUpdated datetime )       
      Declare @SpinWheelSetting as table (Code nvarchar(50) , DisplayName nvarchar(250) , ImgUrl nvarchar(max) ,
       Position int  , PrizeGroupId int)    Declare @EligibleMember as table (RowId bigint,MemberCode nvarchar(50),
       CurrentSpin smallint , TotalSpin smallint , IsFinish bit , 
       Currency nvarchar(10), Active bit)        
       Declare @PrizeList As Table (PrizeId bigint , DisplayName nvarchar(250) , PrizeCode nvarchar(50) , 
       Churn int , PrizeRank smallint  , USDTAmount decimal(18,2) , RMBAmount decimal(18,2) ,GroupId int,
        RemainingCount int)        Declare @MemberUnclaimedSpinPrize as table (RewardId bigint,MemberCode nvarchar(50) ,
         Currency nvarchar(10) , GroupId bigint , RoundNo int)     
            insert into @ActiveCampaign    select RowId , a.Title , StartDate , EndDate , CampaignTypeId , WebUrl , MobileH5Url , MobileAppUrl ,a.FEShow    from tblPromotionCampaign a with (nolock) where RowId = 420    --@CurrentUTCDate between StartDate and EndDate and (@CampType is null OR  CampaignTypeId=@CampType ) status <>@CampaignDisableStatus      select * from @ActiveCampaign    if(select count(1) from @ActiveCampaign ) >0    begin        insert into @CurrentDraw    select  b.DrawId , b.PreStart ,b.StartDate , b.EndDate  , b.status ,b.ModifiedDate   from @ActiveCampaign a   Inner join tblCampaignDetails b with (nolock) on a.CampaignId = b.campaignid  where  b.EndDate>@CurrentUTCDate and (case when a.CampaignType = 1 AND b.Status in(2,3) then 1 when a.CampaignType = 2 AND b.Status in(1,2,3) then 1 else 0 end) = 1 order by b.StartDate asc            declare @CDrawId bigint;        select top 1 @CDrawId = DrawId  from  @CurrentDraw order by StartDate asc        if(@CDrawId is not null )    begin      insert into @SpinWheelSetting  Select b.Code , b.DisplayName , b.ImgURL , b.Position , b.PrizeGrpId  from Spw_CfgList a with (nolock)  inner join Spw_ViewCfg b with(nolock) on a.ViewCfgId = b.Id  where a.DrawId = @CDrawId And a.Active = 1          insert into @PrizeList    select b.Id, b.DisplayName, b.Code, b.ChurnMultp ,b.Rank , b.USDTAmt , b.RMBAmt , A.Id , isnull( ( B.RemainCount),0)  from [Spw_PrizeGrpList] a with(nolock)   inner join  [Spw_PrizeList] b with(nolock) on a.Id = b.PrizeGrpId and b.Active = 1  where a.DrawId = @CDrawId  and a.Active = 1      insert into @EligibleMember    select Id,MbrCode ,CurrentSpin ,TotalSpin  ,case when CurrentSpin<TotalSpin then 0 else 1 end, Currency, Active from [Spw_MbrList] with(nolock) where Drawid = @CDrawId AND Active = 1 AND CurrentSpin<TotalSpin;            insert into @MemberUnclaimedSpinPrize    select Id ,MbrCode,b.Currency,a.PrizeGrpId,a.RoundNo  from Spw_DrawPrizeList a with (nolock)    left join @EligibleMember b on a.MbrCode = b.MemberCode and b.Active = 1    where drawid = @CDrawId AND a.IsClaimed = 0 AND a.Active = 1      end    end        select * from @ActiveCampaign    select * from @CurrentDraw    select * from @SpinWheelSetting  select * from @PrizeList    select * from @EligibleMember    select * from @MemberUnclaimedSpinPrize        END              