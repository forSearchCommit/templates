import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate, NgbTimeStruct } from '@ng-bootstrap/ng-bootstrap';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-edit-promotion',
  templateUrl: './edit-promotion.component.html',
  styleUrls: ['./edit-promotion.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class EditPromotionComponent {
  @ViewChild('EditPromotionModalContent', { read: TemplateRef }) EditPromotionModalContent: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  modalReference: any;
  Details = null;
  destroy$: Subject<boolean> = new Subject<boolean>();
  formValidated = false;
  seconds = true
  noPromotionName = false;
  noStartDateTime = false;
  noEndDateTime = false;
  hasError = false;

  PromotionName = '';
  PromotionType = '';
  StartDate: any;
  EndDate: any;
  StartTime: any;
  EndTime: any;
  CurrentStatus: any;
  CurrentRowId: any;

  DesktopTC: any;
  H5tC: any;
  MobileAppTC: any;
  AppFloatingUrl: any;
  H5FloatingUrl: any;
  noDesktopTC = false;
  noH5tC = false;
  noMobileAppTC = false;
  noAppFloating = false;
  noH5Floating = false;

  constructor(private promotionService: PromotionService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(promotionData) {
    this.PromotionName = promotionData.Title;
    this.PromotionType = promotionData.TypeId;
    this.StartDate = new NgbDate(parseInt(promotionData.StartDate.substring(0, 4)), parseInt(promotionData.StartDate.substring(5, 7)), parseInt(promotionData.StartDate.substring(8, 10)));
    this.EndDate = new NgbDate(parseInt(promotionData.EndDate.substring(0, 4)), parseInt(promotionData.EndDate.substring(5, 7)), parseInt(promotionData.EndDate.substring(8, 10)));
    this.StartTime = { hour: parseInt(promotionData.StartDate.substring(11, 13)), minute: parseInt(promotionData.StartDate.substring(14, 16)), second: parseInt(promotionData.StartDate.substring(17, 19)) };
    this.EndTime = { hour: parseInt(promotionData.EndDate.substring(11, 13)), minute: parseInt(promotionData.EndDate.substring(14, 16)), second: parseInt(promotionData.EndDate.substring(17, 19)) };

    this.CurrentStatus = promotionData.Status;
    this.CurrentRowId = promotionData.RowId;
    this.DesktopTC = promotionData.WebUrl;
    this.H5tC = promotionData.MobileH5Url;
    this.MobileAppTC = promotionData.MobileAppUrl;
    this.AppFloatingUrl = promotionData.AppFloatingUrl;
    this.H5FloatingUrl = promotionData.H5FloatingUrl;

    this.modalReference = this.modalService.open(this.EditPromotionModalContent, { size: 'xl', centered: true });
  }

  submit(data: NgForm) {
    this.noPromotionName = false;
    this.noStartDateTime = false;
    this.noEndDateTime = false;
    this.hasError = false;

    if (data.value.PromotionName == null) {
      this.noPromotionName = true;
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

    if (data.value.AppFloatingUrl == null) {
      this.noAppFloating = true;
      this.hasError = true;
    }

    if (data.value.H5FloatingUrl == null) {
      this.noH5Floating = true;
      this.hasError = true;
    }

    if (!this.hasError) {
      var startTime = ("0" + data.value.StartTime.hour).slice(-2) + ":" + ("0" + data.value.StartTime.minute).slice(-2) + ":" + ("0" + data.value.StartTime.second).slice(-2);
      var endTime = ("0" + data.value.EndTime.hour).slice(-2) + ":" + ("0" + data.value.EndTime.minute).slice(-2) + ":" + ("0" + data.value.EndTime.second).slice(-2);

      var request = {
        "Title": data.value.PromotionName,
        "Type": this.PromotionType,
        "StartDate": data.value.StartDate,
        "StartTime": startTime,
        "EndDate": data.value.EndDate,
        "EndTime": endTime,
        "RowId": this.CurrentRowId,
        "Status": this.CurrentStatus,
        "WebUrl": data.value.DesktopTC,
        "MobileH5Url": data.value.H5tC,
        "MobileAppUrl": data.value.MobileAppTC,
        "AppFloatingUrl" : data.value.AppFloatingUrl,
        "H5FloatingUrl" : data.value.H5FloatingUrl
      }

      this.promotionService.UpdatePromotion(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          Swal.fire("Success", "Edit Promotion Success", "success")
          this.modalReference.close();
          this.refreshData.emit();
        }
        else {
          Swal.fire("Error", "Edit Promotion Failed", "error")
        }
      });
    }

  }

}
