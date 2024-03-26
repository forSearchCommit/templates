import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';

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
  txtStatusId = "";

  cached_MbrCode = "";
  cached_txtCurrency = "";
  cached_txtPrizeId = "";
  cached_txtStatusId = "";

  constructor(private spwSvc: SpinwheelService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData();
  }

  getData(){
    this.loaded = false;
    
    var req = {
      drawId: this.drawId,
      mbrcode: this.txtMbrCode,
      currency: this.txtCurrency,
      prizeId: this.txtPrizeId,
      statusId: this.txtStatusId,
      page: this.page,
      size: this.showPerPage
    }

    this.spwSvc.GetDDPrizeList(this.drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data.IsSuccess) {
        this.prizeList = data.Data;
      }
    });

    this.spwSvc.ViewResult(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
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
    this.cached_txtStatusId = this.txtStatusId;

    this.getData();
  }

  export(){
    var req = {
      drawId: this.drawId,
      mbrcode: this.cached_MbrCode,
      currency: this.cached_txtCurrency,
      prizeId: this.cached_txtPrizeId,
      statusId: this.cached_txtStatusId
    }

    this.spwSvc.ExportWinner(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });  
  }

  exportAll(){
    var req = {
      drawId: this.drawId
    }

    this.spwSvc.ExportWinner(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });
  }
}
