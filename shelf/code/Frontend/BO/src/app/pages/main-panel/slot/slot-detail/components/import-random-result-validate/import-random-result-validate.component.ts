import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { SlotService } from 'src/app/service/slot/slot.service';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'import-random-result-validate',
  templateUrl: './import-random-result-validate.component.html',
  styleUrls: ['./import-random-result-validate.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportSlotRandomResultValidateMdl {
  @ViewChild('ImportSlotRandomResultValidateMdl', { read: TemplateRef }) ImportSlotRandomResultValidateModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;

  loaded = true;
  data = null;
  randdrawlst = [];
  importValid = false;
  totalRandDraw = 0;

 constructor(private slotSvc: SlotService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(data) {
    this.data = data;
    this.randdrawlst = data.ImportedRandDrawList.randDrawList;
    this.totalRandDraw = this.randdrawlst.length;

    this.importValid = data.IsImportValid;

    this.modalReference = this.modalService.open(this.ImportSlotRandomResultValidateModal, { size: 'xl' as any, centered: true, backdrop: 'static' });
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
    this.slotSvc.ImportRandDrawValid(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
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
        Swal.fire("Success", "Import Fake Member List Success", "success")
        this.modalReference.close();
        this.refreshData.emit();
      }
    });
  }
}
