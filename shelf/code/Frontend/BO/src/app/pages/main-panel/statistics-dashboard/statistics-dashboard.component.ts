import { Component, OnInit, ViewChild } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Access, AccessList } from 'src/app/Common/access-right';
import { StatisticService } from 'src/app/service/statistic/statistic.service';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-statistics-dashboard',
  templateUrl: './statistics-dashboard.component.html',
  styleUrls: ['./statistics-dashboard.component.scss']
})
export class StatisticsDashboardComponent implements OnInit {

  loaded = true;
  showPerPage = 50;
  page = 1;
  StatisticList = null;
  TotalRecord = null;

  access = new Access();
  accesslist = AccessList;
  IsAccessible(id) {
    return this.access.IsAccessible(id)
  }

  //@ViewChild(AddPromotionComponent) addModal: AddPromotionComponent;
  destroy$: Subject<boolean> = new Subject<boolean>();

  constructor(private statisticService: StatisticService, ) { }

  ngOnInit(): void {
    this.getData();
  }

  getData() {
    var request = {
      PageNumber: this.page,
      PageSize: this.showPerPage
    }
    this.statisticService.GetList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.StatisticList = data.Data;
      this.TotalRecord = data.TotalRecord;
    });

  }
}
