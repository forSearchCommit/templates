import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'add-draw-modal',
  templateUrl: './add-draw.component.html',
  styleUrls: ['./add-draw.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class AddDraw {
  @ViewChild('AddDrawModal', { read: TemplateRef }) AddDrawModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  modalReference: any;
  Details = null;
  destroy$: Subject<boolean> = new Subject<boolean>();
  formValidated = false;
  seconds = true
  noPromotionName = false;
  noPreDrawDateTime = false;
  noStartDateTime = false;
  noEndDateTime = false;
  hasError = false;

  noMaxAmount = false;

  USDTMaxAmount: any;
  RMBMaxAmount: any;
  startDateLimit: any;
  endDateLimit: any;
  currentPromotionId: any;

  constructor(private promotionService: PromotionService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(currentPromotionData) {
    this.currentPromotionId = currentPromotionData[0].RowId;
    this.startDateLimit = { year: parseInt(currentPromotionData[0].StartDate.substring(0, 4)), month: parseInt(currentPromotionData[0].StartDate.substring(5, 7)), day: parseInt(currentPromotionData[0].StartDate.substring(8, 10)) };
    this.endDateLimit = { year: +parseInt(currentPromotionData[0].EndDate.substring(0, 4)), month: parseInt(currentPromotionData[0].EndDate.substring(5, 7)), day: parseInt(currentPromotionData[0].EndDate.substring(8, 10)) };

    this.modalReference = this.modalService.open(this.AddDrawModal, { size: 'xl', centered: true });
    this.RMBMaxAmount = "";
    this.USDTMaxAmount = "";
  }

  numberOnly(event:any){
    event.currentTarget.value =  event.currentTarget.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
  }

  submit(data: NgForm) {
    this.noPreDrawDateTime = false;
    this.noStartDateTime = false;
    this.noEndDateTime = false;
    this.hasError = false;
    this.noMaxAmount = false;

    if (data.value.PreDrawDate == null || data.value.PreDrawTime == null) {
      this.noPreDrawDateTime = true;
      this.hasError = true;
    }

    if (data.value.StartDate == null || data.value.StartTime == null) {
      this.noStartDateTime = true;
      this.hasError = true;
    }

    if (data.value.EndDate == null || data.value.EndTime == null) {
      this.noEndDateTime = true;
      this.hasError = true;
    }

    if (data.value.RMBMaxAmount == '' || data.value.USDTMaxAmount == '') {
      this.noMaxAmount = true;
      this.hasError = true;
    }

    if (!this.hasError) {
      var preDrawTime = ("0" + data.value.PreDrawTime.hour).slice(-2) + ":" + ("0" + data.value.PreDrawTime.minute).slice(-2) + ":" + ("0" + data.value.PreDrawTime.second).slice(-2);
      var startTime = ("0" + data.value.StartTime.hour).slice(-2) + ":" + ("0" + data.value.StartTime.minute).slice(-2) + ":" + ("0" + data.value.StartTime.second).slice(-2);
      var endTime = ("0" + data.value.EndTime.hour).slice(-2) + ":" + ("0" + data.value.EndTime.minute).slice(-2) + ":" + ("0" + data.value.EndTime.second).slice(-2);

      var request = {
        "CampaignId": this.currentPromotionId,
        "PreDrawDate": data.value.PreDrawDate,
        "PreDrawTime": preDrawTime,
        "StartDate": data.value.StartDate,
        "StartTime": startTime,
        "EndDate": data.value.EndDate,
        "EndTime": endTime,
        "RMBMaxAmount": data.value.RMBMaxAmount,
        "USDTMaxAmount": data.value.USDTMaxAmount

      }

      this.promotionService.AddDraw(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          Swal.fire("Success", "Add Promotion Success", "success")
          this.modalReference.close();
          this.refreshData.emit();
        }
        else {
          Swal.fire("Error", "Add Promotion Failed", "error")
        }
      });
    }

  }
}
