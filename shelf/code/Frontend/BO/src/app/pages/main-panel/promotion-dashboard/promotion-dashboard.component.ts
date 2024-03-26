import { Component, OnInit, ViewChild } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Access, AccessList } from 'src/app/Common/access-right';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { SlotService } from 'src/app/service/slot/slot.service';
import { AddPromotionComponent } from './components/add-promotion/add-promotion.component';
import { EditPromotionComponent } from './components/edit-promotion/edit-promotion.component';

import * as moment from 'moment';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-promotion-dashboard',
  templateUrl: './promotion-dashboard.component.html',
  styleUrls: ['./promotion-dashboard.component.scss']
})
export class PromotionDashboardComponent implements OnInit {

  loaded = true;
  showPerPage = 50;
  page = 1;
  PromotionList = null;
  TotalRecord = null;

  promoTypeId = "";

  access = new Access();
  accesslist = AccessList;
  IsAccessible(id) {
    return this.access.IsAccessible(id)
  }

  @ViewChild(AddPromotionComponent) addModal: AddPromotionComponent;
  @ViewChild(EditPromotionComponent) editModal: EditPromotionComponent;
  destroy$: Subject<boolean> = new Subject<boolean>();

  constructor(private promotionService: PromotionService, private slotService: SlotService) { }

  ngOnInit(): void {
    this.getData();
  }

  getData() {
    var request = {
      pageNumber: this.page,
      pageSize: this.showPerPage,
      sortingType: '3',
      typeId: this.promoTypeId
    }

    this.promotionService.GetList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.PromotionList = data.Data;
      this.TotalRecord = data.TotalRecord;
    });

  }

  DisablePromotion(promotionId, promotionName) {
    var request = {
      "RowId": promotionId
    }

    Swal.fire({
      html: '<div>Confirmation to disable promotion : </div><div><h4 class="f-w-700 py-2">' + promotionName + '</h4></div>',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Yes, disable it !'
    }).then((result) => {
      if (result.isConfirmed) {
        this.promotionService.DisablePromotion(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
          if (data && data.IsSuccess) {
            Swal.fire(
              'Success',
              'Promotion successfully disabled',
              'success'
            );
            this.getData();
          }
          else {
            Swal.fire(
              'Oops',
              'Something went wrong!',
              'error',
            );
          }
        });
      }
    });
  }

  AddPromotion() {
    this.addModal.openModal();
  }

  EditPromotion(promotionData) {
    this.editModal.openModal(promotionData);
  }

  checkDateRange(promodata) {
    let promoStartDate = moment().isBetween
      (promodata.StartDate, promodata.EndDate);

    return promoStartDate
  }

  cleanElement(className){
    const elements = document.getElementsByClassName(className);
    while(elements.length > 0){
        elements[0].parentNode.removeChild(elements[0]);
    }
  }

  toggleIcon(Id, Name, CurrentShow, Status){

    if(Status != 1){
      return;
    }

    var request = {
      "Id": Id,
      "Show": CurrentShow == 0 ? 1 : 0
    }

    var msg = request.Show == 0 ? "Hide Promotion ?" : "Show Promotion ?"

    Swal.fire({
      html: '<div>'+ msg +' : </div><div><h4 class="f-w-700 py-2">' + Name + '</h4></div>',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Yes'
    }).then((result) => {
      if (result.isConfirmed) {
        this.promotionService.ToggleIcon(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
          if(!data.IsSuccess || !data ){
            Swal.fire(
              'Oops',
              'Something went wrong!',
              'error',
            );
            return;
          }

          this.cleanElement("myTr")
          this.getData();
        });
      }
    });
  }

  btnSearch(){
    this.getData();
  }
}
