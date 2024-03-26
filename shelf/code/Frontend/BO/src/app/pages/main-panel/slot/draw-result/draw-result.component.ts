import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';
import { SlotService } from 'src/app/service/slot/slot.service';

@Component({
  selector: 'app-draw-result',
  templateUrl: './draw-result.component.html',
  styleUrls: ['./draw-result.component.scss']
})
export class DrawResultComponent {
  destroy$: Subject<boolean> = new Subject<boolean>();
  access = new Access();
  accesslist = AccessList;

  loaded = false;
  showPerPage = 50;
  page = 1;
  drawId = this.route.snapshot.paramMap.get('drawId'); 
  campaignId = this.route.snapshot.paramMap.get('id'); 
  resultList = [];
  prizeList = [];
  totalRecord = null;

  //  filter
  txtMbrCode;
  txtCurrency = "";
  txtPrizeId = "";
  txtVipLvlId = "";

  cached_MbrCode = "";
  cached_txtCurrency = "";
  cached_txtPrizeId = "";
  cached_txtVipLvlId = "";

  constructor(private slotSvc: SlotService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData();
  }

  getData(){
    this.loaded = true;
    
    var req = {
      drawId: this.drawId,
      mbrcode: this.txtMbrCode,
      currency: this.txtCurrency,
      prizeId: this.txtPrizeId,
      vipLvlId: this.txtVipLvlId,
      page: this.page,
      size: this.showPerPage
    }

    this.slotSvc.GetDDPrizeList(this.drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data.IsSuccess) {
        this.prizeList = data.Data;
      }
    });

    this.slotSvc.ViewResult(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;

      if (data.IsSuccess) {
        this.resultList = data.Data;
        // this.totalRecord = data.TotalRecord;
      }
    });
  }
  
  btnSearch(){

    this.cached_MbrCode = this.txtMbrCode;
    this.cached_txtCurrency = this.txtCurrency;
    this.cached_txtPrizeId = this.txtPrizeId;
    this.cached_txtVipLvlId = this.txtVipLvlId;

    this.getData();
  }

  export(){
    var req = {
      drawId: this.drawId,
      mbrcode: this.cached_MbrCode,
      currency: this.cached_txtCurrency,
      prizeId: this.cached_txtPrizeId,
      vipLvlId: this.cached_txtVipLvlId
    }

    this.slotSvc.ExportWinner(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });  
  }

  exportAll(){
    var req = {
      drawId: this.drawId
    }

    this.slotSvc.ExportWinner(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });
  }
}
