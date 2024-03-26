import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'import-rewards-modal',
  templateUrl: './import-rewards.component.html',
  styleUrls: ['./import-rewards.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportRewards {
  @ViewChild('ImportRewardsModal', { read: TemplateRef }) ImportRewardsModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  modalReference: any;
  Details = null;
  destroy$: Subject<boolean> = new Subject<boolean>();
  formValidated = false;
  seconds = true

  noFile = false;
  hasError = false;

  startDateLimit: any;
  endDateLimit: any;
  drawId: any;
  fileUploaded: any;

  constructor(private promotionService: PromotionService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(drawId) {
    this.drawId = drawId;

    this.modalReference = this.modalService.open(this.ImportRewardsModal, { size: 'xl', centered: true });
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

    if (!this.hasError) {
      var request = {
        "DrawId": this.drawId,
        "FileData": this.fileUploaded,
      }

      this.promotionService.ImportRewards(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          Swal.fire("Success", "Import Eligible Success", "success")
          this.modalReference.close();
          this.refreshData.emit();
        }
        else {
          Swal.fire("Error", "Import Eligible Failed", "error")
        }
      });
    }

  }
}
