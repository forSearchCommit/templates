import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { SlotService } from 'src/app/service/slot/slot.service';
import { catchError, map, takeUntil } from 'rxjs/operators';
import { Subject, throwError } from 'rxjs';
import { NgForm, FormGroup, FormArray, FormBuilder, Validators } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { ImportPrizeMdl } from '../add-draw/import-prize/import-prize.component';
import { ImportedPrizeCheckMdl } from '../add-draw/imported-prize-check/imported-prize-check.component';
import {formatDate} from '@angular/common';
import { NgbTimeStruct } from '@ng-bootstrap/ng-bootstrap';
import {MomentTimezoneModule} from 'angular-moment-timezone';
//import { DatePipe } from '@angular/common';
declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'edit-slot-draw',
  templateUrl: './edit-draw.component.html',
  styleUrls: ['./edit-draw.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})

export class EditDrawComponent {
  @ViewChild('EditSlotDrawModal', { read: TemplateRef }) EditDrawModal: TemplateRef<any>;
  @ViewChild(ImportPrizeMdl) importPrize: ImportPrizeMdl;
  @ViewChild(ImportedPrizeCheckMdl) prizeCheck: ImportedPrizeCheckMdl;
  @Output() refreshData = new EventEmitter();
  destroy$ = new Subject<any>();
  modalReference: any;

  loaded = true;
  campaignId = null;
  startDateLimit: any;
  endDateLimit: any;

  // validation
  noPromotionName = false;
  noPreDrawDateTime = false;
  noStartDateTime = false;
  noEndDateTime = false;
  noFromDateTime = false;
  noToDateTime = false;
  hasError = false;
  //pipe : any;
  isMemberImported = false;
  IsPrizeImported = false;


  PreDrawDate :any;
  StartDrawDate :any;
  EndDrawDate :any;
  FromDate :any;
  ToDate :any;
  PreDrawTime :any;
  StartTime :any;
  EndTime :any;
  ToTime:any;
  FromTime: any;



  importedPrizeData: any;

  drawId : any;
  drawData : any;
  event: any;
  freeSpinForm: FormGroup;

  constructor(private spwSvc: SlotService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig, private fb: FormBuilder) {
    config.seconds = true;
    config.spinners = false;
  }

 // free spin counts [start]
  ngOnInit() {
    this.freeSpinForm = this.fb.group({
      counts: this.fb.array([
        this.initCounts()
      ])
    });
    this.spins.valueChanges.subscribe(value => {
      //console.log('values has changed:', value)
    });
  }

  trackByFn(index: number, item: any) {
    return item.trackingId;
  }

  parseTime(timeString: string): NgbTimeStruct {
    const date = new Date(timeString); // Use a dummy date for parsing time
    return { hour: date.getHours(), minute: date.getMinutes(), second: date.getSeconds() };
  }

  initCounts() {
    return this.fb.group({
      StakeRmb: this.fb.control('', Validators.required),
      StakeUsdt: this.fb.control('', Validators.required),
      Vip1: this.fb.control('', Validators.required),
      Vip2: this.fb.control('', Validators.required),
      Vip3: this.fb.control('', Validators.required),
      Vip4: this.fb.control('', Validators.required),
      Vip5: this.fb.control('', Validators.required),
      Vip6: this.fb.control('', Validators.required),
      Vip7: this.fb.control('', Validators.required),
      Vip8: this.fb.control('', Validators.required),
      trackingId: this.generateUniqueId()
    });
  }

  generateUniqueId() {
    return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
  }

  get spins() {
    return this.freeSpinForm.get('counts') as FormArray;
  }

  addGroup() {
    if (this.spins.length < 50){
      this.spins.push(this.initCounts());
    }
    else {
      Swal.fire({
        title: 'Caution',
        text: 'Maximum 50 records only',
        icon: 'warning',
        showCloseButton: false,
      });
    }
  }

  removeGroup(i: number) {
    if (this.spins.length > 1){
      this.spins.removeAt(i);
    }
    else {
      Swal.fire({
        title: 'Caution',
        text: 'Minimum 1 record is required',
        icon: 'warning',
        showCloseButton: false,
      });
    }
  }
 // free spin counts [end]

  openModal(drawId, drawData) {
    debugger;
    //pipe = new DatePipe();
    this.loaded = true;
    this.drawId = drawId;
    this.drawData = drawData;
    this.PreDrawDate = formatDate(drawData.PreStart, 'yyyy-MM-dd', 'en-US');
    this.StartDrawDate = formatDate(drawData.StartDate, 'yyyy-MM-dd', 'en-US');
    this.EndDrawDate = formatDate(drawData.EndDate, 'yyyy-MM-dd', 'en-US');
    this.ToDate = formatDate(drawData.FreeSpin.FromDate, 'yyyy-MM-dd', 'en-US');
    this.FromDate = formatDate(drawData.FreeSpin.ToDate, 'yyyy-MM-dd', 'en-US');
    this.ToTime = this.parseTime(drawData.FreeSpin.ToDate);
    this.FromTime = this.parseTime(drawData.FreeSpin.FromDate);
    this.StartTime = this.parseTime(drawData.StartDate);
    this.EndTime = this.parseTime(drawData.EndDate);
    this.PreDrawTime = this.parseTime(drawData.PreStart);
    //this.importedPrizeData.ImportedRandSpunList.prizeDrawList = drawData.prizeDrawList;
    //this.importedPrizeData.ImportedRandSpunList.consolationList = drawData.consolationList;
    //this.importedPrizeData.ImportedRandSpunList.windCombinationList = drawData.windCombinationList;
    debugger;
    //data.Data.NumberOfElligibleMember.RMB
    //this.freeSpinForm.
    this.modalReference = this.modalService.open(this.EditDrawModal, { size: 'xl' as any, centered: true, backdrop: 'static' });
  }

  _FormValidate(data: NgForm) {
    this.noPreDrawDateTime = false;
    this.noStartDateTime = false;
    this.noEndDateTime = false;
    this.noFromDateTime = false;
    this.noToDateTime = false;
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

    if (data.value.FromDate == null || data.value.FromTime == null) {
      this.noFromDateTime = true;
      this.hasError = true;
    }

    if (data.value.ToDate == null || data.value.ToTime == null) {
      this.noToDateTime = true;
      this.hasError = true;
    }
  }

  getDrawList() {

  }

  submit(data: NgForm) {
    this._FormValidate(data)

    if (this.hasError){
      return
    }
    if (!this.freeSpinForm.valid){
      Swal.fire({
        title: 'Incomplete',
        text: 'Please fill in all the fields in Free Spin Counts',
        icon: 'error',
        showCloseButton: false,
      })
    }

    var preDrawTime = ("0" + data.value.PreDrawTime.hour).slice(-2) + ":" + ("0" + data.value.PreDrawTime.minute).slice(-2) + ":" + ("0" + data.value.PreDrawTime.second).slice(-2);
    var startTime = ("0" + data.value.StartTime.hour).slice(-2) + ":" + ("0" + data.value.StartTime.minute).slice(-2) + ":" + ("0" + data.value.StartTime.second).slice(-2);
    var endTime = ("0" + data.value.EndTime.hour).slice(-2) + ":" + ("0" + data.value.EndTime.minute).slice(-2) + ":" + ("0" + data.value.EndTime.second).slice(-2);
    var fromTime = ("0" + data.value.FromTime.hour).slice(-2) + ":" + ("0" + data.value.FromTime.minute).slice(-2) + ":" + ("0" + data.value.FromTime.second).slice(-2);
    var toTime = ("0" + data.value.ToTime.hour).slice(-2) + ":" + ("0" + data.value.ToTime.minute).slice(-2) + ":" + ("0" + data.value.ToTime.second).slice(-2);
    var dtFrom =  (data.value.FromDate.year) + "-" + (data.value.FromDate.month) + "-" + (data.value.FromDate.day);
    var dtTo =  (data.value.ToDate.year) + "-" + (data.value.ToDate.month) + "-" + (data.value.ToDate.day);

debugger;
    var req = {
      CampaignId: this.campaignId,
      PreDrawDate: data.value.PreDrawDate,
      PreDrawTime: preDrawTime,
      StartDate: data.value.StartDate,
      StartTime: startTime,
      EndDate: data.value.EndDate,
      EndTime: endTime,
      FreeSpin: {
        FromDate: dtFrom,
        FromTime: fromTime,
        ToDate: dtTo,
        ToTime: toTime,
        Product: '',
        Counts: this.freeSpinForm.value.counts,
        SeparatedStakes: []
      },
      File: {
        prizeDrawList: this.importedPrizeData.ImportedRandSpunList.prizeDrawList,
        consolationList: this.importedPrizeData.ImportedRandSpunList.consolationList,
        windCombinationList: this.importedPrizeData.ImportedRandSpunList.windCombinationList,
      }
    }
    //console.log(req);
    this.createDraw(req);
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

      Swal.fire("Success", "Create Edit Draw Success", "success")
      this.modalReference.close();
      this.refreshData.emit();
    });
  }

  import(drawId) {
    this.importPrize.openModal(drawId);
  }

  getImportedPrize(event){
    this.IsPrizeImported = true;
    this.prizeCheck.openModal(event);
    debugger;
    this.event = event;
  }

  checkImportedPrize(){
    debugger;
    this.prizeCheck.openModal(this.event);
  }
}