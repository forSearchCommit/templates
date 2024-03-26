import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Access, AccessList } from 'src/app/Common/access-right';
import { SpinwheelService } from 'src/app/service/spinwheel/spinwheel.service';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'spw-import-detail',
  templateUrl: './import-detail.component.html',
  styleUrls: ['./import-detail.component.scss']
})
export class ImportDetailComponent{

  destroy$: Subject<boolean> = new Subject<boolean>();
  access = new Access();
  accesslist = AccessList;

  loaded = false;
  showPerPage = 50;
  page = 1;

  drawId = this.route.snapshot.paramMap.get('drawId'); 
  campaignId = this.route.snapshot.paramMap.get('id'); 
  prizeList = [];
  wheelList = [];

  constructor(private spwSvc: SpinwheelService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.getData()
  }

  getData(){
    this.spwSvc.ViewImport(this.drawId).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;

      if (data.IsSuccess) {
        this.prizeList = data.PrizeList;
        this.wheelList = data.WheelList;
      }
    });
  }

  getPrizeIdx(ds) { 
    var idx = this.prizeList.indexOf(ds);
    return idx+1; 
  } 


  getWheelIdx(ds) { 
    var idx = this.wheelList.indexOf(ds);
    return idx+1; 
  } 
}
