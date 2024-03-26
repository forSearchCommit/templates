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
  selector: 'import-randdraw',
  templateUrl: './import-randdraw.component.html',
  styleUrls: ['./import-randdraw.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportSpwRandDrawMdl {
  @ViewChild('ImportSpwRandDrawMdl', { read: TemplateRef }) ImportRandDrawModal: TemplateRef<any>;
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


  constructor(private spwService: SpinwheelService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(drawId) {

    this.drawId = drawId;

    this.modalReference = this.modalService.open(this.ImportRandDrawModal, { size: 'xl', centered: true });
  }

  onFileChange(event) {
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.fileUploaded = file;
    }
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

    this.spwService.ImportRandDrawPreview(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
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