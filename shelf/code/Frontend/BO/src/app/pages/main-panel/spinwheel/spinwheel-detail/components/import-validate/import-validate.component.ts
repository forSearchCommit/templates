import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'import-spw-validate',
  templateUrl: './import-validate.component.html',
  styleUrls: ['./import-validate.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportValidate {
  @ViewChild('ImportSpwValiateMdl', { read: TemplateRef }) ImportValidateModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;

  loaded = true;
  data = null;
  mbrlst = [];
  prizelst = [];
  ttlGrpQty = []
  ttlMbr = 0;
  ttlPrize = 0;
  importValid = false;
  amountValid = false;

 constructor(private spwService: SpinwheelService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(data) {
    this.data = data;
    this.mbrlst = data.Member;
    this.prizelst = data.Prize;
    this.ttlMbr = data.TtlMember;
    this.ttlPrize = data.TtlPrize;

    var preLoad = [];
    data.PrizeGrp.forEach(e => {
      var itm = {
        Grp: e,
        Total: data.TtlGrpQty[e],
        Actual: data.MbrReward[e]
      }
      preLoad.push(itm);
    });

    this.ttlGrpQty = preLoad;
    this.importValid = data.isImportValid;
    this.amountValid = data.isAmountValid;

    this.modalReference = this.modalService.open(this.ImportValidateModal, { size: 'xl' as any, centered: true, backdrop: 'static' });
  }

  isGreater(x, y){
    if(x > y) return true;
  }
  
  submit(){
    if(!this.importValid || !this.amountValid){
      Swal.fire({
        title: 'Error',
        text: 'Please ensure data is correct.',
        icon: 'error',
        showCloseButton: false,
      })
      return;
    }

    this.loaded = false;

    var req = {
      isValid: this.importValid ? 1 : 0,
      DrawId: this.data.DrawId,
      Member: this.data.Member,
      Prize: this.data.Prize,
      PrizeGrp: this.data.PrizeGrp
    }

    this.loaded = true;

    this.spwService.ImportValid(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;

      if (!data.IsSuccess || !data) {
        Swal.fire({
          title: 'Error',
          text: 'Failed to import',
          icon: 'error',
          showCloseButton: false,
        })
        return;
      }else{
        Swal.fire("Success", "Import Success", "success")
        this.modalReference.close();
        this.refreshData.emit();
      }

    });
  }
}
