import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { SlotService } from 'src/app/service/slot/slot.service';
import { catchError, map, takeUntil } from 'rxjs/operators';
import { Subject, throwError } from 'rxjs';
import { NgForm, FormGroup, FormArray, FormBuilder, Validators } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { ImportPrizeMdl } from './import-prize/import-prize.component';
import { ImportedPrizeCheckMdl } from './imported-prize-check/imported-prize-check.component';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'new-slot-draw',
  templateUrl: './add-draw.component.html',
  styleUrls: ['./add-draw.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})

export class AddDrawComponent {
  @ViewChild('NewSlotDrawModal', { read: TemplateRef }) NewDrawModal: TemplateRef<any>;
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

  isMemberImported = false;
  IsPrizeImported = false;

  prizeLst = [];
  conPrizeLst = [];
  winComLst = [];
  importedPrizeData: any;
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

  openModal(data) {
    this.campaignId = data[0].RowId;
    this.startDateLimit = { year: parseInt(data[0].StartDate.substring(0, 4)), month: parseInt(data[0].StartDate.substring(5, 7)), day: parseInt(data[0].StartDate.substring(8, 10)) };
    this.endDateLimit = { year: +parseInt(data[0].EndDate.substring(0, 4)), month: parseInt(data[0].EndDate.substring(5, 7)), day: parseInt(data[0].EndDate.substring(8, 10)) };
    this.modalReference = this.modalService.open(this.NewDrawModal, { size: 'xl', centered: true });
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
    debugger;
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

  import(drawId) {
    this.importPrize.openModal(drawId);
  }

  getImportedPrize(event){
    this.IsPrizeImported = true;
    this.prizeCheck.openModal(event);
    this.importedPrizeData = event;
  }

  checkImportedPrize(){
    this.prizeCheck.openModal(this.importedPrizeData);
  }
}