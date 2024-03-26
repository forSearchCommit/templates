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
  selector: 'imported-prize-check',
  templateUrl: './imported-prize-check.component.html',
  styleUrls: ['./imported-prize-check.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class ImportedPrizeCheckMdl {
  @ViewChild('ImportedPrizeCheckMdl', { read: TemplateRef }) importedPrizeModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;

  loaded = true;
  data = null;

  prizeLst = [];
  conPrizeLst = [];
  winComLst = [];
  

 constructor(private slotService: SlotService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {
  }

  openModal(data) {
    this.data = data;
    debugger;
    this.prizeLst = data.ImportedRandSpunList.prizeDrawList;
    this.conPrizeLst = data.ImportedRandSpunList.consolationList;
    this.winComLst = data.ImportedRandSpunList.windCombinationList;
    // this.ttlMbr = data.TtlMember;
    // this.ttlPrize = data.TtlPrize;

    // var preLoad = [];
    // data.PrizeGrp.forEach(e => {
    //   var itm = {
    //     Grp: e,
    //     Total: data.TtlGrpQty[e],
    //     Actual: data.MbrReward[e]
    //   }
    //   preLoad.push(itm);
    // });

    // this.ttlGrpQty = preLoad;
    // this.importValid = data.isImportValid;
    // this.amountValid = data.isAmountValid;

    this.modalReference = this.modalService.open(this.importedPrizeModal, { size: 'xl' as any, centered: true, backdrop: 'static' });
  }
}
