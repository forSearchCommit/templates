import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { Subject, throwError } from 'rxjs';
import { NgForm, FormGroup, FormArray, FormBuilder, Validators } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { ImportPrizeMdl } from '../add-draw/import-prize/import-prize.component';
import { ImportedPrizeCheckMdl } from '../add-draw/imported-prize-check/imported-prize-check.component';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'edit-confirmation',
  templateUrl: './edit-confirmation.component.html',
  styleUrls: ['./edit-confirmation.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})

export class EditConfirmationComponent {
  @ViewChild('EditSlotDrawModal', { read: TemplateRef }) EditConfirmationModal: TemplateRef<any>;
  modalReference: any;
  loaded = true;
  drawId;
  
  constructor(public activeModal: NgbActiveModal, private modalService: NgbModal) {
    
  }

  openModal(drawId) {
    this.loaded = true;
    this.drawId = drawId;

    this.modalReference = this.modalService.open(this.EditConfirmationModal, { size: 'lg' as any, centered: true, backdrop: 'static' });
  }
}