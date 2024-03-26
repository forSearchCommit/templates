import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';

@Component({
  selector: 'app-import-detail-member',
  templateUrl: './import-detail-member.component.html',
  styleUrls: ['./import-detail-member.component.scss']
})

export class ImportDetailMemberComponent {

  destroy$: Subject<boolean> = new Subject<boolean>();
  access = new Access();
  accesslist = AccessList;

  loaded = false;
  showPerPage = 50;
  page = 1;
  drawId = this.route.snapshot.paramMap.get('drawId'); 
  campaignId = this.route.snapshot.paramMap.get('id'); 
  drawList = [];
  totalRecord = null;
  MaxRound = 8;
  MaxRoundHeader = new Array(8);

  constructor(private spwSvc: SpinwheelService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData();
  }

  getData(){
    this.spwSvc.ViewMbr(this.drawId, this.page, this.showPerPage, null).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;

      if (data.IsSuccess) {
        this.MaxRound = data.DrawListMaxRound;
        this.MaxRoundHeader = new Array(this.MaxRound);
        this.drawList = data.DrawList;
        this.totalRecord = data.TotalRecord;
      }
    });
  }

  getDrawIdx(ds) { 
    var idx = this.drawList.indexOf(ds);
    return idx+1; 
  } 

  exportAll(){
    var req = {
      drawId: this.drawId
    }

    this.spwSvc.ExportMbrList(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });
  }
}
