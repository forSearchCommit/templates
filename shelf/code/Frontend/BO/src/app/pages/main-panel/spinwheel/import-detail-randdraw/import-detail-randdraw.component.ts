import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';

@Component({
  selector: 'app-import-detail-randdraw',
  templateUrl: './import-detail-randdraw.component.html',
  styleUrls: ['./import-detail-randdraw.component.scss']
})

export class ImportDetailRandDrawComponent {

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

  constructor(private spwSvc: SpinwheelService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData();
  }

  getData(){
    this.spwSvc.ViewImportRandDraw(this.drawId, this.page, this.showPerPage).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;

      if (data.IsSuccess) {
 
        this.drawList = data.RandDrawList;
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
