import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Access, AccessList } from 'src/app/Common/access-right';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { AddDraw } from './components/add-draw/add-draw.component';
import { ImportEligible } from './components/import-eligible/import-eligible.component';
import { ImportRewards } from './components/import-rewards/import-rewards.component';
import { Announcement } from './components/announcement/announcement.component';
import * as moment from 'moment';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-promotion-details',
  templateUrl: './promotion-details.component.html',
  styleUrls: ['./promotion-details.component.scss']
})

export class PromotionDetails implements OnInit {
  loaded = true;
  showPerPage = 50;
  page = 1;
  DrawList = null;
  CurrentPromotionData = null;
  CurrentPromotionId = this.route.snapshot.paramMap.get('id');
  TotalRecord = null;
  DrawSelected = [];

  access = new Access();
  accesslist = AccessList;
  IsAccessible(id) {
    return this.access.IsAccessible(id)
  }

  @ViewChild(AddDraw) addDrawModal: AddDraw;
  @ViewChild(ImportEligible) importEligibleModal: ImportEligible;
  @ViewChild(ImportRewards) importRewardsModal: ImportRewards;
  @ViewChild(Announcement) announcementModal: Announcement;
  destroy$: Subject<boolean> = new Subject<boolean>();

  constructor(private promotionService: PromotionService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData();
    this.getPromotionDetail();
  }

  getData() {
    var request = {
      campaignId: this.route.snapshot.paramMap.get('id'),
      pageNumber: this.page,
      pageSize: this.showPerPage,
      sortingType: '3'
    }
    this.promotionService.GetPromotionDrawList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.DrawList = data.Data;
      this.TotalRecord = data.TotalRecord;
    });
  }

  getPromotionDetail() {
    var request = {
      rowId: this.route.snapshot.paramMap.get('id'),
    }
    this.promotionService.GetPromotionDetail(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.CurrentPromotionData = data.Data;
      // this.loaded = true;
      // console.log('sadada');
      // console.log(data.Data);
      // this.TotalRecord = data.TotalRecord;
    });
  }

  getRewardWinners(id, batchId) {
    var request = {
      drawId: id,
      importBatchId: batchId
    }
    this.promotionService.GetRewardWinnersExport(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });
  }

  onCheckboxChange(drawId, isChecked) {
    if (isChecked) {
      this.DrawSelected.push(drawId);
    } else {
      this.DrawSelected.splice(this.DrawSelected.indexOf(drawId), 1);
    }
  }

  DisableDraw() {
    Swal.fire({
      title: 'Are you sure want to disable this/these draw?',
      text: " ",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Confirm'
    }).then((result) => {
      if (result.isConfirmed) {
        let noError = true;
        let processCount = 0;

        this.DrawSelected.forEach(selected => {
          let request = {
            drawId: selected,
          }
          this.promotionService.DisableDraw(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
            if (data && data.IsSuccess && data.IsSuccess == true) {
            }
            else {
              noError = true;
            }
          });

          processCount++;
          if (processCount === this.DrawSelected.length) {
            if (noError) {
              Swal.fire("Success", "Draw Disable Success", "success");
              this.getData();
            } else {
              Swal.fire("Error", "Draw Disable Failed", "error")
              this.getData();
            }
          }
        })
      }
    })

  }

  AddDraw() {
    this.addDrawModal.openModal(this.CurrentPromotionData);
  }

  ImportEligible(drawId) {
    this.importEligibleModal.openModal(drawId);
  }

  ImportRewards(drawId) {
    this.importRewardsModal.openModal(drawId);
  }

  Announcement(drawId, status) {
    this.announcementModal.openModal(drawId, status);
  }

  checkDateRange(drawdata) {
    let drawStartDate = moment().isBetween
      (drawdata.StartDate, drawdata.EndDate);

    return drawStartDate
  }
}
