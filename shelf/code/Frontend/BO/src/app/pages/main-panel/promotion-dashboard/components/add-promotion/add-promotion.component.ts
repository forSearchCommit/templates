import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig } from '@ng-bootstrap/ng-bootstrap';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-add-promotion',
  templateUrl: './add-promotion.component.html',
  styleUrls: ['./add-promotion.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class AddPromotionComponent {
  @ViewChild('AddPromotionModalContent', { read: TemplateRef }) AddPromotionModalContent: TemplateRef<any>;
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
  noDesktopTC = false;
  noH5tC = false;
  noMobileAppTC = false;
  PromotionType = "1";
  noAppFloating = false;
  noH5Floating = false;
  
  constructor(private promotionService: PromotionService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal() {
    this.modalReference = this.modalService.open(this.AddPromotionModalContent, { size: 'xl', centered: true });
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

    if (data.value.DesktopTC == null) {
      this.noDesktopTC = true;
      this.hasError = true;
    }

    if (data.value.H5tC == null) {
      this.noH5tC = true;
      this.hasError = true;
    }

    if (data.value.MobileAppTC == null) {
      this.noMobileAppTC = true;
      this.hasError = true;
    }

    if (data.value.AppFloating == null) {
      this.noAppFloating = true;
      this.hasError = true;
    }

    if (data.value.H5Floating == null) {
      this.noH5Floating = true;
      this.hasError = true;
    }

    if (!this.hasError) {
      var startTime = ("0" + data.value.StartTime.hour).slice(-2) + ":" + ("0" + data.value.StartTime.minute).slice(-2) + ":" + ("0" + data.value.StartTime.second).slice(-2);
      var endTime = ("0" + data.value.EndTime.hour).slice(-2) + ":" + ("0" + data.value.EndTime.minute).slice(-2) + ":" + ("0" + data.value.EndTime.second).slice(-2);

      var request = {
        "Title": data.value.PromotionName,
        "Type": data.value.PromotionType,
        "StartDate": data.value.StartDate,
        "StartTime": startTime,
        "EndDate": data.value.EndDate,
        "EndTime": endTime,
        "WebUrl": data.value.DesktopTC,
        "MobileH5Url": data.value.H5tC,
        "MobileAppUrl": data.value.MobileAppTC,
        "AppFloatingUrl" : data.value.AppFloating,
        "H5FloatingUrl" : data.value.H5Floating
      }

      this.promotionService.AddPromotion(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          Swal.fire("Success", "Add Promotion Success", "success").then(function () {
            if(request.Type == 1){
              window.location.href = "/dashboard/promotion/" + data.CampaignId;
            }else{
              window.location.href = "/dashboard/spinwheel/" + data.CampaignId;
            }
          });
          // this.modalReference.close();
          this.refreshData.emit();
        }
        else {
          Swal.fire("Error", "Add Promotion Failed", "error")
        }
      });
    }

  }

}
