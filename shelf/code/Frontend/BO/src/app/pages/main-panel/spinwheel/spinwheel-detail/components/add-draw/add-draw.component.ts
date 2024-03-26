import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';
import { catchError, map, takeUntil } from 'rxjs/operators';
import { Subject, throwError } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'new-spw-draw',
  templateUrl: './add-draw.component.html',
  styleUrls: ['./add-draw.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})

export class AddDrawComponent {
  @ViewChild('NewSpwDrawModal', { read: TemplateRef }) NewDrawModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$ = new Subject<any>();
  modalReference: any;

  loaded = true;
  campaignId = null;
  startDateLimit: any;
  endDateLimit: any;

  //  validation
  noPromotionName = false;
  noPreDrawDateTime = false;
  noStartDateTime = false;
  noEndDateTime = false;
  hasError = false;

  totalPcs = 8;
  totalPosition = [1,2,3,4,5,6,7,8];
  wheelList = [];
  cdnImgUrl = [];

  constructor(private spwSvc: SpinwheelService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
    this.resetWheel();
  }

  resetWheel(){
    this.wheelList = [];
    for (var i = 0; i < this.totalPcs; i++) {
      this.wheelList.push(new WheelPcs(i + 1))
    }
  }

  openModal(data) {
    this.resetWheel();
    
    this.campaignId = data[0].RowId;
    this.startDateLimit = { year: parseInt(data[0].StartDate.substring(0, 4)), month: parseInt(data[0].StartDate.substring(5, 7)), day: parseInt(data[0].StartDate.substring(8, 10)) };
    this.endDateLimit = { year: +parseInt(data[0].EndDate.substring(0, 4)), month: parseInt(data[0].EndDate.substring(5, 7)), day: parseInt(data[0].EndDate.substring(8, 10)) };
    this.modalReference = this.modalService.open(this.NewDrawModal, { size: 'lg', centered: true });
  }

  _FormValidate(data: NgForm) {
    this.noPreDrawDateTime = false;
    this.noStartDateTime = false;
    this.noEndDateTime = false;
    this.hasError = false;

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
  }

  _checkWheelCfg(){
    this.wheelList.forEach(ele => {
      if(ele.DisplayName == '' || ele.ImgSrc == null){
        Swal.fire({
          title: 'Error',
          text: 'Please complete all the mandatory fields',
          icon: 'error',
          showCloseButton: false,
        })
        this.hasError = true;
      }
    })
  
    if(this.hasError)
      return;

    var fixP = [];

    this.wheelList.forEach(ele => {
      ele.Code = ele.DisplayName;
      ele.Name = ele.DisplayName;

      var str = ''+ ele.Position +''
      var idx = fixP.findIndex(e => e == str);
      if (idx == -1){
        fixP.push(str);
      }
    })

    if(fixP.length < this.totalPcs){
      Swal.fire({
        title: 'Error',
        text: 'Duplicate position found.',
        icon: 'error',
        showCloseButton: false,
      })
      this.hasError = true;
    }
  }

  onFileChange(event, index) {
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.wheelList[index].ImgSrc = file;
      
      const reader = new FileReader();
      reader.readAsDataURL(file); // toBase64
      reader.onload = () => {
        this.wheelList[index].ImgPath = reader.result as string; // base64 Image src
      };
    }
  }

  submit(data: NgForm) {
    this._FormValidate(data)

    if(this.hasError){
      return
    }

    this._checkWheelCfg();

    if(this.hasError){
      return
    }

    var preDrawTime = ("0" + data.value.PreDrawTime.hour).slice(-2) + ":" + ("0" + data.value.PreDrawTime.minute).slice(-2) + ":" + ("0" + data.value.PreDrawTime.second).slice(-2);
    var startTime = ("0" + data.value.StartTime.hour).slice(-2) + ":" + ("0" + data.value.StartTime.minute).slice(-2) + ":" + ("0" + data.value.StartTime.second).slice(-2);
    var endTime = ("0" + data.value.EndTime.hour).slice(-2) + ":" + ("0" + data.value.EndTime.minute).slice(-2) + ":" + ("0" + data.value.EndTime.second).slice(-2);

    var req = {
      CampaignId: this.campaignId,
      PreDrawDate: data.value.PreDrawDate,
      PreDrawTime: preDrawTime,
      StartDate: data.value.StartDate,
      StartTime: startTime,
      EndDate: data.value.EndDate,
      EndTime: endTime
    }

    this.uploadImg(req);
  }

  uploadImg(req) {
    this.spwSvc.UploadImg(this.wheelList, req.CampaignId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (!data.IsSuccess || !data) {
        Swal.fire({
          title: 'error',
          text: 'Failed to upload images',
          icon: 'error',
          showCloseButton: false,
        })
        
        return;
      }

      this.cdnImgUrl = data.Image;

      var views = []
      this.wheelList.forEach(ele => {
        var url = this.cdnImgUrl.find(x => x.Position == ele.Position).Url
        views.push({
          Code: ele.Code,
          Name: ele.Name,
          DisplayName: ele.DisplayName,
          ImgUrl: url,
          Position: ele.Position
        });
      });
  
      req["Views"] = views;
      
      this.createDraw(req);
    });
  }

  createDraw(req) {
    this.spwSvc.CreateDraw(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (!data.IsSuccess || !data) {
        Swal.fire({
          title: 'error',
          text: 'Failed to create new draw',
          icon: 'error',
          showCloseButton: false,
        })

        return;
      }

      Swal.fire("Success", "Create New Draw Success", "success")
      this.modalReference.close();
      this.refreshData.emit();
    });
  }
}

export class WheelPcs {
  Code: string = '';
  Name: string = '';
  DisplayName: string = '';
  ImgSrc: any = null;
  Position: number = 0;
  ImgPath: any = null;

  constructor(position: number) {
    this.Position = position;
  }
}
