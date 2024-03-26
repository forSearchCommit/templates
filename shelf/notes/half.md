<details>

<summary>Request Model</summary>

```C#
public class RequestParam<T>
{
    [JsonProperty(PropertyName = "t")]
    public string TimeStamp { get; set; }

    [JsonProperty(PropertyName = "body")]
    public T Body { get; set; }

    public override string ToString()
    {
        return JsonConvert.SerializeObject(this);
    }
}

public class ParamBase
{
    [JsonProperty(PropertyName = "channelId")]
    public enumChannel ChannelId { get; set; }

    [JsonProperty(PropertyName = "timeZone")]
    public string TimeZone { get; set; }
}

public class ParamBaseWithToken : ParamBase
{
    [JsonProperty(PropertyName = "ssoToken")]
    public string SSoToken { get; set; }
}

public class reqAcceptPrize
    {
        public string PrizeEventId { get; set; }
        public string Currency { get; set; }
        public string Membercode { get; set; }
        public string RequestId { get; set; }
    }
public class reqAcceptReward
    {
        public string RewardEventId { get; set; }
        public string Membercode { get; set; }
        public string Currency { get; set; }
        public string RequestId { get; set; }
    }

public class reqGetDrawDetail
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
        public string RequestId { get; set; }
    }

public class reqGetEligibleMemberList
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
    }

 public class reqGetEligibleMemberListSpin
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
    }


 public class reqGetMemberClaimPrizeStatus
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
    }
public class reqGetMemberClaimStatus
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
    }
public class reqGetMemberPrize
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
        public long DrawId { get; set; }
        public string RequestId { get; set; }
    }
public class reqGetMemberPrizeWinningHistory
    {
        public long? CampaignId { get; set; }
        public string MemberCode { get; set; }
        public bool? Status { get; set; }
        public DateTime? DateFrom { get; set; }
        public DateTime? DateTo { get; set; }
        public int? PageNum { get; set; }
        public int? PageSize { get; set; }
        public string RequestId { get; set; }
    }

public class reqGetMemberReward
    {
        public string Membercode { get; set; }
        public string Currency { get; set; }
        public long DrawId { get; set; }
        public string RequestId { get; set; }
    }



public class RequestParam<T>
{
    public string TimeStamp { get; set; }

    public T Body { get; set; }

    public override string ToString()
    {
        return JsonConvert.SerializeObject(this);
    }
}

public class ParamBase
{
    public enumChannel ChannelId { get; set; }

    public string TimeZone { get; set; }
}

public class ParamBaseWithToken : ParamBase
{
    public string SSoToken { get; set; }
}
//===============
public class reqCampaignBaseParam
{
    public string Membercode { get; set; }
}
public class reqCampaignBaseParamWithCurrency : reqCampaignBaseParam
{
    public string Currency { get; set; }
}

public class reqParamWithRequestId : reqCampaignBaseParamWithCurrency
{
    public string RequestId { get; set; }
}

public class reqParamWithDrawId : reqParamWithRequestId
{
    public string DrawId { get; set; }
}


//========================
public class reqAcceptPrize : reqParamWithRequestId
{
    public string PrizeEventId { get; set; }
}
public class reqAcceptReward : reqParamWithRequestId
{
    public string RewardEventId { get; set; }
}

public class reqGetDrawDetail :  reqParamWithRequestId
{
}

public class reqGetEligibleMemberList : reqCampaignBaseParamWithCurrency
{
}

public class reqGetEligibleMemberListSpin : reqCampaignBaseParamWithCurrency
{
}


public class reqGetMemberClaimPrizeStatus : reqCampaignBaseParamWithCurrency
{
}
public class reqGetMemberClaimStatus : reqCampaignBaseParamWithCurrency
{
}
public class reqGetMemberPrize : reqParamWithDrawId
{
}
public class reqGetMemberPrizeWinningHistory : reqBaseParam
{
    public long? CampaignId { get; set; }
    public bool? Status { get; set; }
    public DateTime? DateFrom { get; set; }
    public DateTime? DateTo { get; set; }
    public int? PageNum { get; set; }
    public int? PageSize { get; set; }
    public string RequestId { get; set; }
}

public class reqGetMemberReward : reqParamWithDrawId
{
}







/********************************/



public class reqGetNextDrawDetail : reqCampaignBaseParamWithCurrency
{
}

public class reqGetNextSpinDetail: reqCampaignBaseParamWithCurrency
{
}
public class reqGetRecentPrizeWinning
{
    public long? CampaignId { get; set; }
    public string RequestId { get; set; }
}
public class reqGetSpinDetail : reqParamWithRequestId
{

}

public class reqGetSpinWheelLeaderboard
{
    public long? CampaignId { get; set; }
    public string RequestId { get; set; }
}

public class reqIsEligible: reqCampaignBaseParamWithCurrency
{

}

public class reqIsEligibleSpin : reqCampaignBaseParamWithCurrency
{

}
public class reqIsNextDrawEligible : reqIsEligible
{

}
public class reqIsNextSpinEligible : reqIsEligibleSpin
{

}

public class reqRejectPrize : reqParamWithRequestId
{
    public string PrizeEventId { get; set; }
}
public class reqRejectReward : reqParamWithRequestId
{
    public string RewardEventId { get; set; }
}
```

</details>

<details>

<summary>Response Model</summary>

```C#
public class respGetDrawDetail
{
    public long? CampaignId { get; set; }
    public long? DrawId { get; set; }

    public string WebTNCUrl { get; set; }
    public string MobileTNCUrl { get; set; }
    public string AppsTNCUrl { get; set; }
    public string VersionNumber { get; set; }
    
    
    public DateTime CampaignStartDate { get; set; }
    public DateTime CampaignEndDate { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public DateTime PreStart { get; set; }

    public bool IsEligibleMember { get; set; }
    public bool IsClaimed { get; set; }
    public bool MemberFinishDraw { get; set; }
    public bool DrawFinish { get; set; }

    public int TotalReward { get; set; }
    public int RMBMaxAmount { get; set; }
    public int USDTMaxAmount { get; set; }
    public UpComingDrawModel NextDrawDetail { get; set; }
}
public class respGetEligibleMemberList
{
    public int TotalRecord { get; set; }
    public List<EligibleMemberInfo> Data { get; set; }
}
public class respGetEligibleMemberListSpin
{
    public int TotalRecord { get; set; }
    public List<EligibleMemberInfoSpin> Data { get; set; }
}
public class respGetMemberClaimPrizeStatus
{
    public int ClaimStatus { get; set; }
}
public class respGetMemberClaimStatus
{
    public int ClaimStatus { get; set; }
}
public class respGetMemberPrize : resWithStatus
{
    public string PrizeEventId { get; set; }
    public List<MemberPrizeModel> RewardList = new List<MemberPrizeModel>();
}
public class respGetMemberPrizeWinningHistory
{
    public long? CampaignId { get; set; }
    public List<MemberWinningHistory> winningHistory { get; set; }

    public class MemberWinningHistory
    {
        public long Id { get; set; }
        public string MbrCode { get; set; }
        public string PrizeName { get; set; }
        public int PrizeRank { get; set; }
        public string Status { get; set; }
    }
}
public class respGetMemberReward : resWithStatus
{
    public string RewardEventId { get; set; }

    public List<MemberRewardModel> RewardList = new List<MemberRewardModel>();
}
public class respGetRecentPrizeWinning
{
    public DateTime ClaimedDate { get; set; }

    public string DisplayName { get; set; }

    public string MemberCode { get; set; }
    public int Idx { get; set; }
}

public class respGetSpinDetail
{
    public string Message { get; set; }
    public string VersionNumber { get; set; }

    public long? CampaignId { get; set; }
    public long? SpinId { get; set; }
    
    public int CampaignTypeId { get; set; }
    public int RemainingSpin { get; set; }

    public DateTime CampaignStartDate { get; set; }
    public DateTime CampaignEndDate { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public DateTime PreStart { get; set; }
    
    public string MobileAppUrl { get; set; }
    public string MobileH5Url { get; set; }
    public string WebUrl { get; set; }

    
    public bool IsEligibleMember { get; set; }
    public bool IsFEShow { get; set; }
    public bool IsFinish { get; set; }
    

    public List<SpinDetail_ViewCfgModel> ViewSetting { get; set; }
    public UpComingSpinModel NextSpinDetail { get; set; }
}

public class respGetSpinWheelLeaderboard
{
    public string DisplayName { get; set; }
    public int Idx { get; set; }
    public string MemberCode { get; set; }
    public int Ranking { get; set; }
}
public class respIsEligible
{
    public bool IsEligible { get; set; }
}
public class respIsEligibleSpin
{
    public bool IsEligible { get; set; }
}
    public class respIsNextDrawEligible : respIsEligible
{
}
public class respIsNextSpinEligible : respIsEligibleSpin
{
}
public class respRejectPrize : resWithStatus
{
    
}
public class respRejectReward : respUpdateRewardStatus
{
    public UpComingDrawModel NextDrawDetail { get; set; }
}
public class respSummaryModel
{
    public int Reward { get; set; }
}
public class respUpdatePrizeStatus : resWithStatus
{
    public ClaimedPrizeModel PrizeInfo { get; set; }
}
public class respUpdateRewardStatus : resWithStatus
{
    public ClaimedRewardModel RewardInfo {get;set;}
}

public class resCampaignBaseParam
{
    public string Message { get; set; }
}

public class resWithStatus : resCampaignBaseParam
{
    public bool Success { get; set; }
}
/*************/

public class DrawBaseModel
{
    public long? DrawId { get; set; }
    public DateTime DrawDate { get; set; }
}

public class NextDrawDate : DrawModelBase
{
    public DateTime NextPreStart { get; set; }
    public DateTime NextDrawStartDate { get; set; }
    public DateTime NextDrawEndDate { get; set; }
}

public class CurrentDrawDate : DrawModelBase
{
    public DateTime PreStart { get; set; }
    public DateTime DrawStartDate { get; set; }
    public DateTime DrawEndDate { get; set; }
}


public class UpComingDrawModel : NextDrawDate
{
    public int TotalReward { get; set; }
    public int NextRMBMaxAmount { get; set; }
    public int NextUSDTMaxAmount { get; set; }
}

public class CampaignModel
{
    public long CampaignId { get; set; }
    public DateTime CampaignStartDate { get; set; }
    public DateTime CampaignEndDate { get; set; }
}

public class PlatformUrlModel
{
    public string WebUrl { get; set; }
    public string MobileH5Url { get; set; }
    public string MobileAppUrl { get; set; }
}

    public class DrawDetailModel : DrawModelBase
{
    //CampaignInfo
    //t1 campaign model

    //t2 url model

    // DrawInfo
    public string VersionNumber { get; set; }
    public string TransactionId { get; set; }

    //t3 currentdrawdate

    //t3
    public long MemberBatchId { get; set; }
    public long RewardBatchId { get; set; }
    public int RewardLimit { get; set; }
    public int RMBMaxAmount { get; set; }
    public int USDTMaxAmount { get; set; }
}

public class MemberRewardRedisModel
    {
        public long RowId { get; set; }
        public long BatchId { get; set; }
        public string RewardId { get; set; }
        public int DeductionFactor { get; set; }
        public int Churn { get; set; }
        public decimal USDTAmount { get; set; }
        public decimal RMBAmount { get; set; }
        public bool RandomPick { get; set; }
    }
public class MemberRewardBindingRedisModel : MemberRewardRedisModel
    {
        public string MemberCode { get; set; }
        public string Currency { get; set; }
        public DateTime ClaimDate { get; set; }
    }
    public class MemberPrizeRedisModel
    {
        public long RowId { get; set; } // For Update Member Spin Record Used
        public long PrizeGroupId { get; set; }
        public long PrizeId { get; set; }
        public int? Churn { get; set; }
        public int PrizeRank { get; set; }
        public decimal USDTAmount { get; set; }
        public decimal RMBAmount { get; set; }
    }
    public class MemberDrawStatusModel
    {
        public string MemberCode { get; set; }
        public string Currency { get; set; }
        public bool IsClaimed { get; set; }
        public bool IsFinishDraw { get; set; }

        //RewardModel
        public long RewardRecordId { get; set; }
        public int RewardDeductionFactor { get; set; }
    }
    public class EligibleMemberInfo // refer to Promotion.Data.Entity.sp_GetCampaignCacheData.EligibleMember
    {
        public long RowId { get; set; }
        public string MemberCode { get; set; }
        public int Status { get; set; }
    }
    /*****************************************/










 public class EligibleMemberInfoSpin : EligibleMemberInfo
    {
      /*  public long RowId { get; set; }
        public string MemberCode { get; set; }

        public int Status { get; set; }*/
    }

public class EligibleMemberSpinModel : MemberBaseModelWithCurrency
    {
        //public string MemberCode { get; set; }
        

        //public string Currency { get; set; }
        public long RecordId { get; set; }
        public int TotalSpin { get; set; }

        public List<MemberSpinRoundPrizeModel> SpinPrize { get; set; }
        public int CurrentSpin { get { return TotalSpin - SpinPrize.Count(); } }

        public int RemainingSpin { get { return SpinPrize.Count(); } }

        public MemberSpinRoundPrizeModel GetPrize() 
        {
            var prize = this.SpinPrize.OrderBy(x => x.SpinNumber).FirstOrDefault();

            if (prize != null)
            {
                this.SpinPrize.Remove(prize);
            }

            return prize;
        }

        public bool IsFinish { get { return SpinPrize.Count == 0; } }
    }//

    public class MemberSpinRoundPrizeModel
    {
        public int SpinNumber { get; set; }
        public long RecordId { get; set; }
        public long PrizeGroupId { get; set; }
    }

    public class MemberPendingPrizeModel
    {

        public string MemberCode { get; set; }
        
        public int ChurnMultiplier { get; set; }

        public bool IsAllowReject { get; set; }
        public int SpinNumber { get; set; }
        public long RecordId { get; set; }
        public int Position { get; set; }
        public long PrizeId { get; set; }
        public string PrizeEventId { get; set; }
        public string PrizeName { get; set; }
        public decimal PrizeAmount { get; set; }
        public string PrizeCurrency { get; set; }
        public long PrizeGroupId { get; set; }
        
    }
//
  public class LastSpinModel
    {
        public long? SpinId { get; set; }
        public DateTime PreStart { get; set; }
        public DateTime SpinStartDate { get; set; }
        public DateTime SpinEndDate { get; set; }
    }//
public class LeaderBoardItem
    {
        public int Idx { get; set; }
        public int Ranking { get; set; }

        public string DisplayName { get; set; }

        public string MemberCode { get; set; }
    }

public class MemberPrizeBindingRedisModel : MemberPrizeRedisModel
    {
        public string MemberCode { get; set; }
        public string Currency { get; set; }
        public int SpinNumber { get; set; }

        public decimal CurrencyAmount { get; set; }
        public string DisplayName { get; set; }

        public string PrizeName { get; set; } // Prize Original Name
        public DateTime ClaimDate { get; set; }

    }
public class MemberPrizeWinningHistoryModel
    {
        public List<MemberWinningHistory> winningHistory { get; set; }

        public class MemberWinningHistory
        {
            public long Id { get; set; }
            public string MbrCode { get; set; }
            public string PrizeName { get; set; }
            public int PrizeRank { get; set; }
            public bool Status { get; set; }
        }
    }
  public class MemberSpinStatusModel
    {
        public string MemberCode { get; set; }
        public string Currency { get; set; }
        public bool IsFinishSpin { get; set; }
    }

public class RecentTransactionItem
    {
        public DateTime ClaimedDate { get; set; }

        public string DisplayName { get; set; }

        public string MemberCode { get; set; }
        public int Idx { get; set; }
    }

public class SpinDetailModel
    {
        //CampaignInfo
        public long CampaignId { get; set; }
        public DateTime CampaignStartDate { get; set; }
        public DateTime CampaignEndDate { get; set; }
        public string WebUrl { get; set; }
        public string MobileH5Url { get; set; }
        public string MobileAppUrl { get; set; }
        // SpinInfo
        public string VersionNumber { get; set; }
        public long? SpinId { get; set; }
       // public string TransactionId { get; set; }
        //public DateTime SpinDate { get; set; }
        public DateTime PreStart { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int RMBMaxAmount { get; set; }
        public int USDTMaxAmount { get; set; }
        public int CampaignTypeId { get; set; }

        public List<SpinDetail_ViewCfgModel> ViewSetting { get; set; }
        public bool IsEligibleMember { get; set; }
        public bool FEShow { get; set; }
        //public int TotalLeft { get; set; } // deduction factor
    }

    public class SpinDetail_ViewCfgModel
    {
        public int Position { get; set; }
        public string DisplayName { get; set; }
        public string CdnUrl { get; set; }

    }

 public class SpinPrizeItemModel
    {

        public long PrizeId { get; set; }

        public string PrizeName { get; set; }

        public int Position { get; set; }

        public int? ChurnMultiplier { get; set; }
        public int PrizeRank { get; set; }

        public List<PrizeAmountCurrency> SpinPrizeList { get; set; }
        public string Currency { get; set; }
        public long CurrentSpin { get; set; }
        public bool IsFinish { get; set; }
        public string MemberCode { get; set; }
        public long RecordId { get; set; }
        public int RemainingSpin { get; set; }
        //public List<SpinPrize> SpinPrizeList { get; set; }
        public int TotalSpin { get; set; }

        public class PrizeAmountCurrency
        {
            public string CurrencyCode { get; set; }

            public decimal? Amount { get; set; }
            public int PrizeGroupId { get; set; }
            public long RecordId { get; set; }
            public int SpinNumber { get; set; }
        }

    }
     public class UpComingSpinModel
    {
        public long? SpinId { get; set; }
        public DateTime NextPreStart { get; set; }
        public DateTime NextSpinStartDate { get; set; }
        public DateTime NextSpinEndDate { get; set; }
    }







```

</details>

<details>

```json
{
    "t": "2023-11-23 23:36:56:87",
    "code": "GNR00001",
    "message": "Success",
    "body": {
        "campaignEndDate": "2023-11-30T00:00:00",
        "campaignId": 206,
        "campaignStartDate": "2023-11-16T00:00:00",
        "campaignTypeId": 2,
        "endDate": "2023-11-24T12:10:00",
        "preStart": "2023-11-24T12:00:00",
        "spinId": 624,
        "startDate": "2023-11-24T12:05:00",
        "versionNumber": null,
        "viewSetting": [
            {
                "position": 1,
                "displayName": "1",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442530_1.jpg"
            },
            {
                "position": 2,
                "displayName": "2",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442546_2.jpg"
            },
            {
                "position": 3,
                "displayName": "3",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442561_3.jpg"
            },
            {
                "position": 4,
                "displayName": "4",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442561_4.jpg"
            },
            {
                "position": 5,
                "displayName": "5",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442577_5.jpg"
            },
            {
                "position": 6,
                "displayName": "6",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442593_6.jpg"
            },
            {
                "position": 7,
                "displayName": "7",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442593_7.jpg"
            },
            {
                "position": 8,
                "displayName": "8",
                "cdnUrl": "https://n8doca01.n8stg.com/CDN/Campaign//SpinWheel/20231124/spw_206_20231123233442608_8.jpg"
            }
        ],
        "prestartTimeRemaining": 1383,
        "startTimeRemaining": 1683,
        "endTimeRemaining": 1983,
        "timeZone": "GMT +08:00",
        "isEligible": true,
        "isFEShow": true,
        "promotionUrl": "test",
        "remainingSpin": 20,
        "spinCountDown": null,
        "mobileAppUrl": "test",
        "hasPendingPrize": false,
        "pendingPrizeDetail": null
    },
    "deviceIP": "211.24.62.57",
    "maintenanceChannel": {
        "startTime": "2022-08-31T12:45:00",
        "endTime": "2022-08-31T13:15:00",
        "channelId": 1,
        "maintenance": false,
        "type": "Emergency"
    }
}
lboards
{
    "t": "2023-11-24 03:53:46:29",
    "code": "GNR00001",
    "message": "Success",
    "body": {
        "campaignId": 206,
        "leaderboard": [
            {
                "displayName": "红包 500/1000 RMB 500",
                "idx": 1,
                "memberCode": "k*******1"
            }
        ]
    },
    "deviceIP": "211.24.62.57",
    "maintenanceChannel": {
        "startTime": "2022-08-31T12:45:00",
        "endTime": "2022-08-31T13:15:00",
        "channelId": 1,
        "maintenance": false,
        "type": "Emergency"
    }
}
rw
{
    "t": "2023-11-24 03:54:16:46",
    "code": "GNR00001",
    "message": "Success",
    "body": {
        "campaignId": 206,
        "winningPrizes": [
            {
                "claimedDate": "2023-11-24T07:47:59.053",
                "displayName": "红包 500/1000 RMB 500",
                "memberCode": "k*******1",
                "idx": 0
            }
        ]
    },
    "deviceIP": "211.24.62.57",
    "maintenanceChannel": {
        "startTime": "2022-08-31T12:45:00",
        "endTime": "2022-08-31T13:15:00",
        "channelId": 1,
        "maintenance": false,
        "type": "Emergency"
    }
}
```

</details>