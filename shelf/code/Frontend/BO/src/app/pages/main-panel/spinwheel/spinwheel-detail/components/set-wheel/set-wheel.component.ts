import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig } from '@ng-bootstrap/ng-bootstrap';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'spw-set-wheel',
  templateUrl: './set-wheel.component.html',
  styleUrls: ['./set-wheel.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class SetWheel {
  @ViewChild('SpwSetWheelMdl', { read: TemplateRef }) setWheelMdl: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;

  drawId;
  wheelList = [];
  prizeGrpList = [];
  loaded = false;

  constructor(private spwService: SpinwheelService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(drawId, wheel, prizeGrp) {
    this.loaded = true;
    this.drawId = drawId;
    this.prizeGrpList = prizeGrp;

    wheel.forEach(e => {
      e.PrizeGrpId = "";
    });

    this.wheelList = wheel;

    this.modalReference = this.modalService.open(this.setWheelMdl, { size: 'lg' as any, centered: true, backdrop: 'static' });
  }

  validate() {
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
        text: 'Duplicate position found.',
        icon: 'error',
        showCloseButton: false,
      })

      return false;
    }

    return true;
  }

  update() {
    if (!this.validate()) {
      return;
    };

    var lst = [];
    this.wheelList.forEach(e => {
      lst.push({ WheelId: e.Id, PrizeGrpId: e.PrizeGrpId });
    });

    var req = {
      DrawId: this.drawId,
      Wheel: lst
    }

    this.spwService.UpdateWheel(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {

      if (!data.IsSuccess) {
        Swal.fire({
          title: 'Error',
          text: 'Failed to set wheel',
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
