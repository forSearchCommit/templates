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
  selector: 'import-spw-randdraw-validate',
  templateUrl: './import-randdraw-validate.component.html',
  styleUrls: ['./import-randdraw-validate.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportRandDrawValidate {
  @ViewChild('ImportSpwRandDrawValidateMdl', { read: TemplateRef }) ImportRandDrawValidateModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;

  loaded = true;
  data = null;
  randdrawlst = [];
  importValid = false;
  totalRandDraw = 0;

 constructor(private spwService: SpinwheelService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(data) {
    this.data = data;
    this.randdrawlst = data.ImportedRandDrawList.randDrawList;
    this.totalRandDraw = this.randdrawlst.length;
    // var preLoad = [];
    // data.randdrawlst.forEach(e => {
    //   var itm = {
    //     Grp: e,
    //     Total: data.TtlGrpQty[e],
    //     Actual: data.MbrReward[e]
    //   }
    //   preLoad.push(itm);
    // });

    this.importValid = data.IsImportValid;

    this.modalReference = this.modalService.open(this.ImportRandDrawValidateModal, { size: 'xl' as any, centered: true, backdrop: 'static' });
  }

  submit(){
    if(!this.importValid){
      Swal.fire({
        title: 'error',
        text: 'Please ensure data is correct.',
        icon: 'error',
        showCloseButton: false,
      })
      return;
    }

    this.loaded = false;

    var req = {
      IsValid: this.importValid,
      DrawId: this.data.ImportedRandDrawList.DrawId,
      randDrawList: this.data.ImportedRandDrawList.randDrawList
    }

    this.loaded = true;
    this.spwService.ImportRandDrawValid(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;

      if (!data.IsSuccess || !data) {
        Swal.fire({
          title: 'error',
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
