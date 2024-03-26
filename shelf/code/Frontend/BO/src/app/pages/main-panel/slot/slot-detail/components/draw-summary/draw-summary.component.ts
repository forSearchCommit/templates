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
  selector: 'draw-summary',
  templateUrl: './draw-summary.component.html',
  styleUrls: ['./draw-summary.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class DrawSummaryMdl {
  @ViewChild('DrawSummaryMdl', { read: TemplateRef }) DrawSummaryModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter<any>();
  destroy$: Subject<boolean> = new Subject<boolean>();
  modalReference: any;
  loaded = false;

  drawId = 0;
  ttlMbrRMB = 0;
  ttlMbrUSDT = 0;

  ttlBonusRMB = 0;
  ttlBonusUSDT = 0;
  normalBonusRMB = 0;
  conBonusRMB = 0;
  normalBonusUSDT = 0;
  conBonusUSDT = 0;
  prizeCountLst = [];
  prizeList = [];
  ttlWinningCombination = 0;
  conPrize = [];

  isMbrImported = false;



 constructor(private slotSvc: SlotService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  ngOnInit(): void {

  }

  getData(){
    this.slotSvc.ViewSummary(this.drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data.IsSuccess) {
        this.ttlMbrRMB = data.Data.NumberOfElligibleMember.RMB;
        this.ttlMbrUSDT = data.Data.NumberOfElligibleMember.USDT;
        this.ttlBonusRMB = data.Data.TotalEstimatedGiven.RMB.Normal + data.Data.TotalEstimatedGiven.RMB.Consolidation;
        this.ttlBonusUSDT = data.Data.TotalEstimatedGiven.USDT.Normal + data.Data.TotalEstimatedGiven.USDT.Consolidation;
        this.normalBonusRMB = data.Data.TotalEstimatedGiven.RMB.Normal;
        this.conBonusRMB = data.Data.TotalEstimatedGiven.RMB.Consolidation;
        this.normalBonusUSDT = data.Data.TotalEstimatedGiven.USDT.Normal;
        this.conBonusUSDT = data.Data.TotalEstimatedGiven.USDT.Consolidation;
        this.prizeCountLst = data.Data.TotalEstimatedPhsicalGiven;
        this.prizeList = data.Data.PrizeTypeList;
        this.ttlWinningCombination = data.Data.WinningCombination;
        this.conPrize = data.Data.ConsolidationPrizeGiven;
        this.loaded = true;
        this.isMbrImported = this.ttlMbrRMB !== 0 || this.ttlMbrUSDT !== 0;
      }
    });
  }

  openModal(drawId) {
    this.drawId = drawId;
    // this.data = data;
    // this.mbrlst = data.Member;
    // this.priz = data.Prize;
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

    this.modalReference = this.modalService.open(this.DrawSummaryModal, { size: 'xl' as any, centered: true, backdrop: 'static' });
    this.getData();
  }

}
