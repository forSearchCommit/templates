import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';

import { AddDrawComponent } from './components/add-draw/add-draw.component';
import { ImportSpwMdl } from './components/import-eligable/import-eligable.component';
import { ImportValidate } from './components/import-validate/import-validate.component';
import { ImportSpwRandDrawMdl } from './components/import-randdraw/import-randdraw.component';
import { ImportRandDrawValidate } from './components/import-randdraw-validate/import-randdraw-validate.component';
import { SetWheel } from './components/set-wheel/set-wheel.component';

import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import * as moment from 'moment';
import { Announcement } from '../../promotion/promotion-details/components/announcement/announcement.component';
import { ViewWheelComponent } from './components/view-wheel/view-wheel.component';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-spinwheel-detail',
  templateUrl: './spinwheel-detail.component.html',
  styleUrls: ['./spinwheel-detail.component.scss']
})
export class SpinwheelDetailComponent implements OnInit {
  @ViewChild(AddDrawComponent) addDrawMdl: AddDrawComponent;
  @ViewChild(ImportSpwMdl) importMdl: ImportSpwMdl;
  @ViewChild(ImportSpwRandDrawMdl) importRandDrawMdl: ImportSpwRandDrawMdl;
  @ViewChild(ImportValidate) importValidateMdl: ImportValidate;
  @ViewChild(ImportRandDrawValidate) importRandDrawValidateMdl: ImportRandDrawValidate;
  @ViewChild(SetWheel) setWheelMdl: SetWheel;
  @ViewChild(Announcement) announcementMdl: Announcement;
  @ViewChild(ViewWheelComponent) viewWheelMdl: ViewWheelComponent;

  destroy$: Subject<boolean> = new Subject<boolean>();
  access = new Access();
  accesslist = AccessList;
  
  loaded = true;
  showPerPage = 50;
  page = 1;
  TotalRecord = null;
  
  spinData = null;
  drawList = [];
  campaignId =  this.route.snapshot.paramMap.get('id'); 

  drawSelected = [];


  constructor(private spwSvc: SpinwheelService, private promoSvc: PromotionService, private route: ActivatedRoute) { }

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
      typeId: 2,
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
    this.spwSvc.GetDrawList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
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

  viewWheel(drawId){
    var prizeGrp;
    var wheelLst;

    this.spwSvc.GetDrawStatus(drawId, false).pipe(takeUntil(this.destroy$)).subscribe((data3: any) => {
      if (data3.IsSuccess){
        this.spwSvc.GetWheelList(drawId).pipe(takeUntil(this.destroy$)).subscribe((data2: any) => {
          wheelLst = data2.Data;
    
          if(data2.IsSuccess){
            this.spwSvc.GetPrizeGrpList(drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
              prizeGrp = data.Data;
        
              if(data.IsSuccess){
                this.viewWheelMdl.openModal(drawId, this.campaignId, wheelLst, prizeGrp);
              }
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

  import(drawId){
    this.importMdl.openModal(drawId);
  }

  importRandDraw(drawId)
  {
    this.importRandDrawMdl.openModal(drawId);
  }

  clearImport(drawId){
    this.spwSvc.GetDrawStatus(drawId, false).pipe(takeUntil(this.destroy$)).subscribe((data3: any) => {
      if (data3.IsSuccess){
        Swal.fire({
          title: 'Are you sure want to clear import?',
          text: " ",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Confirm'
        }).then(result => {
          if (result.isConfirmed) {
            this.spwSvc.ClearImport(drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
              if (data && data.IsSuccess && data.IsSuccess == true) {
                Swal.fire("Success", "Clear Success", "success");
              }else{
                Swal.fire("Error", "Failed to clear import", "error")
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

  clearImportRandDraw(drawId){
    this.spwSvc.GetDrawStatus(drawId, true).pipe(takeUntil(this.destroy$)).subscribe((data3: any) => {
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
            this.spwSvc.ClearImportRandDraw(drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
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

  getValidate(event){
    this.importValidateMdl.openModal(event);
  }

  getRandDrawValidate(event){
    this.importRandDrawValidateMdl.openModal(event);
  }

  updateWheel(drawId){
    var prizeGrp;
    var wheelLst;

    this.spwSvc.GetWheelList(drawId).pipe(takeUntil(this.destroy$)).subscribe((data2: any) => {
      wheelLst = data2.Data;

      if(data2.IsSuccess){
        this.spwSvc.GetPrizeGrpList(drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
          prizeGrp = data.Data;
    
          if(data.IsSuccess){
            this.setWheelMdl.openModal(drawId, wheelLst, prizeGrp);
          }
        });
      }
    });
  }

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
