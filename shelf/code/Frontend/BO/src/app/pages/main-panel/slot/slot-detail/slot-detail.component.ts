import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';

import { AddDrawComponent } from './components/add-draw/add-draw.component';
import { EditDrawComponent } from './components/edit-draw/edit-draw.component';
import { EditConfirmationComponent } from './components/edit-confirmation/edit-confirmation.component';
//import { ImportMemberComponent } from '../import-member/import-member.component';
import { ImportSlotRandomResultMdl } from './components/import-random-result/import-random-result.component';
import { ImportSlotRandomResultValidateMdl } from './components/import-random-result-validate/import-random-result-validate.component';
import { DrawSummaryMdl } from './components/draw-summary/draw-summary.component';
import { ImportMemberMdl } from './components/import-member/import-member.component';
// import { ImportValidate } from './components/import-validate/import-validate.component';
// import { ImportSpwRandDrawMdl } from './components/import-randdraw/import-randdraw.component';
// import { ImportRandDrawValidate } from './components/import-randdraw-validate/import-randdraw-validate.component';

import { SlotService } from 'src/app/service/slot/slot.service';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import * as moment from 'moment';
import { Announcement } from '../../promotion/promotion-details/components/announcement/announcement.component';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-slot-detail',
  templateUrl: './slot-detail.component.html',
  styleUrls: ['./slot-detail.component.scss']
})
export class SlotDetailComponent implements OnInit {
  @ViewChild(AddDrawComponent) addDrawMdl: AddDrawComponent;
  @ViewChild(EditDrawComponent) editDrawMdl: EditDrawComponent;
  @ViewChild(EditConfirmationComponent) editConfirmationMdl: EditConfirmationComponent;
  @ViewChild(ImportMemberMdl) ImportMemberMdl: ImportMemberMdl;
  //@ViewChild(ImportMemberComponent) importMemberMdl: ImportMemberComponent;
  @ViewChild(ImportSlotRandomResultMdl) importRandomResultMdl: ImportSlotRandomResultMdl;
  @ViewChild(ImportSlotRandomResultValidateMdl) importRandomResultValidateMdl: ImportSlotRandomResultValidateMdl;
  @ViewChild(DrawSummaryMdl) drawSummaryMdl: DrawSummaryMdl;
  // @ViewChild(ImportSpwRandDrawMdl) importRandDrawMdl: ImportSpwRandDrawMdl;
  // @ViewChild(ImportValidate) importValidateMdl: ImportValidate;
  // @ViewChild(ImportRandDrawValidate) importRandDrawValidateMdl: ImportRandDrawValidate;
  @ViewChild(Announcement) announcementMdl: Announcement;

  destroy$: Subject<boolean> = new Subject<boolean>();
  access = new Access();
  accesslist = AccessList;
  
  loaded = true;
  showPerPage = 50;
  page = 1;
  TotalRecord = null;
  
  spinData = null;
  getEditDrawData : any;
  drawList = [];
  campaignId =  this.route.snapshot.paramMap.get('id'); 

  drawSelected = [];

  constructor(private slotSvc: SlotService, private promoSvc: PromotionService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getCampDtl();
  }

  IsAccessible(id) {
    return true;
    return this.access.IsAccessible(id)
  }

  cleanElement(className){
    const elements = document.getElementsByClassName(className);
    while(elements.length > 0){
        elements[0].parentNode.removeChild(elements[0]);
    }
  }

  getCampDtl(){
    var request = {
      rowId: this.campaignId,
      typeId: 3,
    }
    this.promoSvc.GetPromotionDetail(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.spinData = data.Data;

      this.getDrawList();
    });
  }

  getDrawList() {
    this.loaded = false;
    this.drawList = [];
    
    var request = {
      campaignId: this.campaignId,
      pageNumber: this.page,
      pageSize: this.showPerPage,
      // sortingType: '3'
    }
    this.slotSvc.GetDrawList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.drawList = data.Data;
    });
  }

  Announcement(drawId, status) {
    this.announcementMdl.openModal(drawId, status);
  }

  addDraw(){
    this.addDrawMdl.openModal(this.spinData);
  }

  disableDraw(){
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
        
        this.drawSelected.forEach(selected => {
          let request = {
            drawId: selected,
          }
          this.promoSvc.DisableDraw(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
            if (data && data.IsSuccess && data.IsSuccess == true) {
            }
            else {
              noError = true;
            }
          });

          processCount++;
          if (processCount === this.drawSelected.length) {
            if (noError) {
              Swal.fire("Success", "Draw Disable Success", "success");
              this.getDrawList();
            } else {
              Swal.fire("Error", "Draw Disable Failed", "error")
              this.getDrawList();
            }
          }
        })
      }
    })
  }

  editSlotCfg(drawId, preStart)
  {
    
    const preStartInTime = new Date(preStart).getTime();
    const dtNow: Date = new Date();
    dtNow.setHours(8);
    const dtNowInTime: number = dtNow.getTime();
    const timeDifInMs: number = new Date(preStart).getTime(); - dtNow.getTime();
    //debugger;
    if ((timeDifInMs / (1000 * 60)) < 30)
    {
      Swal.fire({
        title: 'Not allow to update due to now is less than 30 minutes from Pre Start Date!',
        text: "Refresh page and continue",
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'OK'
      }).then((result) => {
        this.getDrawList();
      })
    }
    //debugger;
    var request = {
      DrawId: drawId
    }
    //debugger;
    this.slotSvc.GetEditDraw(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      //this.loaded = true;
      //debugger;
      //this.getEditDrawData = data;
      //debugger;
      if (data.IsSuccess)
      {
        this.editDraw(data.DrawId, data);
      }
      else{
        Swal.fire({
          title: 'Status Changed!',
          text: "Refresh page and continue",
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK'
        }).then((result) => {
          this.getDrawList();
        })
      }
    });/*
    this.slotSvc.GetEditDraw(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (!data.IsSuccess || !data) {
        Swal.fire({
          title: 'error',
          text: 'Failed to create new draw',
          icon: 'error',
          showCloseButton: false,
        })

        return;
      }
      this.getEditDrawData = data;
      var test = this.getEditDrawData;
      Swal.fire("Success", "Create New Draw Success", "success")
      debugger;
    });*/

    //var test = this.getEditDrawData;


    //debugger;
/*
    this.slotSvc.GetDrawStatus(drawId, false).pipe(takeUntil(this.destroy$)).subscribe((data3: any) => {
      debugger;
      if (data3.IsSuccess)
      {
        this.editConfirmationMdl.openModal(drawId);
      }
      else{
        Swal.fire({
          title: 'Status Changed!',
          text: "Refresh page and continue",
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK'
        }).then((result) => {
          this.getDrawList();
        })
      }
    });*/

    //this.addDrawMdl.openModal(this.spinData);
  }

  editDraw(drawId, data){
    //debugger;
    //this.addDrawMdl.openModal2(this.spinData, data);
    var drawData = data;/*{
      "DrawId" : 125,
      "CampaignId" : 189,
      "PreStart" : "2024-01-06 23:15:09.000",
      "StartDate" : "2024-01-06 23:25:09.0000",
      "EndDate" : "2024-01-06 23:35:09.000",
      "FreeSpin" : {
        "FromDate" : "2024-01-06 23:25:09.000",
        "ToDate" : "2024-01-06 23:35:09.000",
        "FromTime" : "2024-01-06 23:25:09.000",
        "ToTime" : "2024-01-06 23:35:09.000",
        "Product" : "",
        "Counts" : [
            {
                "StakeUsdt" : 100,
                "StakeRmb" : 200,
                "Vip1" : 1,
                "Vip2" : 1,
                "Vip3" : 1,
                "Vip4" : 2,
                "Vip5" : 2,
                "Vip6" : 2,
                "Vip7" : 3,
                "Vip8" : 3 
            }
        ]
      },
      "File" : {
        "IsValid" : 1,
        "DrawId" : "580",
        "windCombinationList" : [
            {
                "ColumnA" : "A",
                "ColumnB" : "A",
                "ColumnC" : "C",
                "PrizeName" : "FirstPrize"
            }
        ],
        "prizeDrawList" : [
            {
                "PrizeName" : "FirstPrize",
                "Qty" : 5,
                "BonusRMB" : 20.00,
                "BonusUSDT" : 20.00,
                "ChurnRollover" : 2,
                "RandAssign" : "",
                "Rank" : 1
            }
        ],
        "consolationList" : [
            {
                "PrizeName" : "Consolation",
                "BonusRMB" : 10.00,
                "BonusUSDT" : 10.00,
                "ChurnRollover" : 5
            }
        ]
      }
    };*/

    // this.slotSvc.GetDraw(drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
    //   if(data.IsSuccess){
    //     drawData = data.Data;
    //     this.editDrawMdl.openModal(drawId, drawData);
    //   }
    // });
    
    this.editDrawMdl.openModal(drawId, drawData);
  }

  viewSummary(drawId)
  {
    this.drawSummaryMdl.openModal(drawId);
  }

  getRandDrawValidate(event){
    this.importRandomResultValidateMdl.openModal(event);
  }

  // importRandDraw(drawId)
  // {
  //   this.importRandDrawMdl.openModal(drawId);
  // }

  importMember(drawId){
    this.ImportMemberMdl.openModal(drawId);
 }

  importRandomResult(drawId) {
    this.importRandomResultMdl.openModal(drawId);
  }

  clearImportRandomResult(drawId){
    this.slotSvc.GetDrawStatus(drawId, true).pipe(takeUntil(this.destroy$)).subscribe((data3: any) => {
      if (data3.IsSuccess){
        Swal.fire({
          title: 'Are you sure want to clear fake member import?',
          text: " ",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Confirm'
        }).then(result => {
          if (result.isConfirmed) {
            this.slotSvc.clearImportRandomResult(drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
              if (data && data.IsSuccess && data.IsSuccess == true) {
                Swal.fire("Success", "Clear Success", "success");
              }else{
                Swal.fire("Error", "Failed to clear fake member import", "error")
              }        
              this.getDrawList();
            });
          }
        });
      }else{
        Swal.fire({
          title: 'Status Changed!',
          text: "Refresh page and continue",
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK'
        }).then((result) => {
          this.getDrawList();
        })
      }
    });
  }

  // getValidate(event){
  //   this.importValidateMdl.openModal(event);
  // }

  checkDateRange(drawdata) {
    let drawStartDate = moment().isBetween
      (drawdata.StartDate, drawdata.EndDate);

    return drawStartDate
  }

  onCheckboxChange(drawId, isChecked){
    if (isChecked) {
      this.drawSelected.push(drawId);
    } else {
      this.drawSelected.splice(this.drawSelected.indexOf(drawId), 1);
    }
  }
}
