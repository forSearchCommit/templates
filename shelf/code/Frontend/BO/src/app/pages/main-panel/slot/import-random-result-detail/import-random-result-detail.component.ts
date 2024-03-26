import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';
import { SlotService } from 'src/app/service/slot/slot.service';

@Component({
  selector: 'app-import-random-result-detail',
  templateUrl: './import-random-result-detail.component.html',
  styleUrls: ['./import-random-result-detail.component.scss']
})

export class ImportRandomResultDetailComponent {

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

  constructor(private slotSvc: SlotService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData();
  }

  getData(){
    this.slotSvc.ViewImportRandomResult(this.drawId, this.page, this.showPerPage).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
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

    this.slotSvc.ExportMbrList(req).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    });
  }
}
