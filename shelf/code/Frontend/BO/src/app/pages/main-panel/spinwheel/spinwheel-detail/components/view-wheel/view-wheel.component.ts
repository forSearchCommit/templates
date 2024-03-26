import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';
import { NgForm } from '@angular/forms';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'spw-view-wheel',
  templateUrl: './view-wheel.component.html',
  styleUrls: ['./view-wheel.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ViewWheelComponent {
  @ViewChild('SpwViewWheelMdl', { read: TemplateRef }) viewWheelMdl: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;
  
  campId;
  drawId;
  wheelList = [];
  prizeGrpList = [];
  loaded = false;
  totalPosition = [1,2,3,4,5,6,7,8];
  hasError = false;
  ImgIdx = [];

  constructor(private spwService: SpinwheelService, public activeModal: NgbActiveModal, private modalService: NgbModal) {
    
  }

  ngOnInit(): void {
  }

  openModal(drawId, campId, wheel, prizeGrp) {
    this.loaded = true;
    this.drawId = drawId;
    this.prizeGrpList = prizeGrp;
    this.wheelList = wheel;
    this.campId = campId;


    this.wheelList.forEach(ele => {
      if(ele.PrizeGrpId == null){
        ele.PrizeGrpId = ""
      }
    })

    this.modalReference = this.modalService.open(this.viewWheelMdl, { size: 'lg' as any, centered: true });
  }

  onFileChange(event, index){
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      var idx = this.ImgIdx.findIndex(x => x == index);
      if(idx == -1){
        this.ImgIdx.push(index);
      }
      this.wheelList[index].ImgSrc = file;

      const reader = new FileReader();
      reader.readAsDataURL(file); // toBase64
      reader.onload = () => {
        this.wheelList[index].ImgPath = reader.result as string; // base64 Image src
      };
    }
  }

  _validate() {
    this.hasError = false;

    this.wheelList.forEach(ele => {
      if(ele.DisplayName == ''){
        Swal.fire({
          title: 'Error',
          text: 'Please complete all the fields',
          icon: 'error',
          showCloseButton: false,
        })
        this.hasError = true;
      }

      if(this.prizeGrpList.length > 0){
        if(ele.PrizeGrpId == ''){
          Swal.fire({
            title: 'Error',
            text: 'Please Insert Prize Category',
            icon: 'error',
            showCloseButton: false,
          })
          this.hasError = true;
        }
      }
    })
  }

  _duplicatePosition() {
    this.hasError = false;

    var totalPcs = 8;
    var fixP = [];

    this.wheelList.forEach(ele => {
      var str = '' + ele.Position + ''
      var idx = fixP.findIndex(e => e == str);
      if (idx == -1) {
        fixP.push(str);
      }
    })

    if (fixP.length < totalPcs) {
      Swal.fire({
        title: 'Error',
        text: 'Duplicate position found.',
        icon: 'error',
        showCloseButton: false,
      })

      this.hasError = true;
    }
  }

  _duplicateGrp() {
    this.hasError = false;

    var totalPcs = this.prizeGrpList.length;
    var fixP = [];

    this.wheelList.forEach(ele => {
      var str = '' + ele.PrizeGrpId + ''
      var idx = fixP.findIndex(e => e == str);
      if (idx == -1) {
        fixP.push(str);
      }
    })

    if (fixP.length != totalPcs) {
      Swal.fire({
        title: 'Error',
        text: 'Duplicate prize category found.',
        icon: 'error',
        showCloseButton: false,
      })

      this.hasError = true;
    }
  }

  submit() {
    this._validate(); 
    
    if(this.hasError)
    return;

    this._duplicatePosition();

    if(this.hasError)
    return;

    if(this.prizeGrpList.length > 0){
      this._duplicateGrp();
    }
    
    if(this.hasError)
      return;

    this.spwService.EditWheel(this.wheelList, this.drawId, this.campId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (!data.IsSuccess || !data) {
        Swal.fire({
          title: 'error',
          text: 'Failed to create new draw',
          icon: 'error',
          showCloseButton: false,
        })

        return;
      }

      Swal.fire("Success", "Update Success", "success")
      this.modalReference.close();
      this.refreshData.emit();
    });
  }
}
