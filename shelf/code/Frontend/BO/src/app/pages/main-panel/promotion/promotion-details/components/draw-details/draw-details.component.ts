import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Access, AccessList } from 'src/app/Common/access-right';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
// import { AddDraw } from './components/add-draw/add-draw.component';
// import { ImportEligible } from './components/import-eligible/import-eligible.component';
// import { ImportRewards } from './components/import-rewards/import-rewards.component';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'draw-details',
  templateUrl: './draw-details.component.html',
  styleUrls: ['./draw-details.component.scss']
})

export class DrawDetails implements OnInit {
  loaded = true;
  showPerPage = 50;
  page = 1;
  DrawList = null;
  CurrentDrawData = null;
  CurrentPromotionData = null;
  CurrentPromotionId = this.route.snapshot.paramMap.get('id');
  CurrentType = this.route.snapshot.paramMap.get('type');
  TotalRecord = null;

  access = new Access();
  accesslist = AccessList;
  IsAccessible(id) {
    return this.access.IsAccessible(id)
  }

  // @ViewChild(AddDraw) addDrawModal: AddDraw;
  // @ViewChild(ImportEligible) importEligibleModal: ImportEligible;
  // @ViewChild(ImportRewards) importRewardsModal: ImportRewards;
  destroy$: Subject<boolean> = new Subject<boolean>();

  constructor(private promotionService: PromotionService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getDrawDetailsData();
    this.getCurrentPromotionData();
  }

  getDrawDetailsData() {
    var request = {
      drawId: this.route.snapshot.paramMap.get('drawId'),
      campaignId: this.route.snapshot.paramMap.get('id')
    }
    this.promotionService.GetDrawDetailsData(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data.Data) {
        this.CurrentDrawData = data.Data;
        this.getDrawRewardsInfo(data.Data);
      }
    });
  }

  getDrawRewardsInfo(drawData) {
    var request = {
      detailsID: drawData[0].DrawId,
      importBatchID: this.route.snapshot.paramMap.get('type') === 'reward' || this.route.snapshot.paramMap.get('type') === 'promo' ? drawData[0].RewardBatchID : drawData[0].MemberBatchID,
      pageNumber: this.page,
      pageSize: this.showPerPage
    }

    if (this.route.snapshot.paramMap.get('type') === 'reward' || this.route.snapshot.paramMap.get('type') === 'promo') {
      this.promotionService.GetDrawRewardsInfoWinners(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        this.loaded = true;
        this.DrawList = data.Data;
        this.TotalRecord = data.TotalRecord;
      });
    } else {
      this.promotionService.GetDrawRewardsInfoMembers(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        this.loaded = true;
        this.DrawList = data.Data;
        this.TotalRecord = data.TotalRecord;
      });
    }
  }

  getCurrentPromotionData() {
    var request = {
      "RowId": this.route.snapshot.paramMap.get('id')
    }
    this.promotionService.GetPromotionDetail(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.CurrentPromotionData = data.Data;
    });
  }

  clearPromotionDraw() {
    var request = {
      "DrawId": this.route.snapshot.paramMap.get('drawId')
    }

    if (this.route.snapshot.paramMap.get('type') === 'reward') {
      this.promotionService.ClearRewardList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          var outerThis = this;
          Swal.fire("Success", "Clear Reward List Success", "success").then(function () {
            window.location.href = "/dashboard/promotion/" + outerThis.route.snapshot.paramMap.get('id');
          });
        }
        else {
          Swal.fire("Error", "Clear Reward List Failed", "error")
        }
      });
    } else {
      this.promotionService.ClearMemberList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          var outerThis = this;
          Swal.fire("Success", "Clear Member List Success", "success").then(function () {
            window.location.href = "/dashboard/promotion/" + outerThis.route.snapshot.paramMap.get('id');
          });
        }
        else {
          Swal.fire("Error", "Clear Member List Failed", "error")
        }
      });
    }
  }

  getRewardWinners() {
    var request = {
      drawId: this.route.snapshot.paramMap.get('drawId'),
      'importBatchId': this.route.snapshot.paramMap.get('type') === 'reward' || this.route.snapshot.paramMap.get('type') === 'promo' ? this.CurrentDrawData[0].RewardBatchID : this.CurrentDrawData[0].MemberBatchID,
    }

    if (this.route.snapshot.paramMap.get('type') === 'reward') {
      this.promotionService.GetRewardList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        const url = window.URL.createObjectURL(blob);
        window.open(url);
      });
    } else if (this.route.snapshot.paramMap.get('type') === 'promo') {
      this.promotionService.GetPromoStatus(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        const url = window.URL.createObjectURL(blob);
        window.open(url);
      });
    } else {
      this.promotionService.GetRewardWinners(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        const url = window.URL.createObjectURL(blob);
        window.open(url);
      });
    }
  }
}
