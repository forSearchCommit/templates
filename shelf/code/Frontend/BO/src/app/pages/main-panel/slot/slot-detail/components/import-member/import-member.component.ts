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
  selector: 'import-member',
  templateUrl: './import-member.component.html',
  styleUrls: ['./import-member.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportMemberMdl {
  @ViewChild('ImportMemberMdl', { read: TemplateRef }) ImportMemberModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter<any>();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;
  Details = null;
  formValidated = false;
  seconds = true

  noFile = false;
  hasError = false;

  startDateLimit: any;
  endDateLimit: any;
  drawId: any;
  fileUploaded: any;


  constructor(private slotSvc: SlotService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(drawId) {
    this.drawId = drawId;

    this.modalReference = this.modalService.open(this.ImportMemberModal, { size: 'xl', centered: true });
  }

  downloadMbrList(drawId) {
    var req = {
        drawId: this.drawId
      }
      
      this.slotSvc.DownloadMemberList(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        const url = window.URL.createObjectURL(blob);
        window.open(url);
      });
  }

  onFileChange(event) {
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.fileUploaded = file;
    }
  }

  exportAll(){
    var req = {
      drawId: this.drawId
    }

    this.slotSvc.ExportMbrList(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });
  }

  submit(data: NgForm) {
    this.noFile = false;
    this.hasError = false;

    if (this.fileUploaded == null) {
      this.noFile = true;
      this.hasError = true;
    }

    if (this.hasError){
      return;
    }

    var request = {
      "DrawId": this.drawId,
      "FileData": this.fileUploaded,
    }

    this.slotSvc.ImportMemberPreview(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data && data.IsSuccess && data.IsSuccess == true) {
        // Swal.fire("Success", "Import Success", "success")
        this.modalReference.close();
        this.refreshData.emit(data);
      }
      else {
        Swal.fire("Error", "Import Failed", "error")
      }
    });
  }
}
