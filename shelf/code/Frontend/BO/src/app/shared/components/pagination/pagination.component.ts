import { Component, OnInit, Input, OnChanges, Output, EventEmitter, } from '@angular/core';

@Component({
  selector: 'v9-pagination',
  templateUrl: './pagination.component.html',
  styleUrls: ['./pagination.component.scss']
})
export class Pagination implements OnInit {

  @Input() collectionSize;
  @Input() pageSize;
  @Input() page;
  @Output() pageChange = new EventEmitter<number>(true);


  currentPage = 1;
  totalPage = 0;
  prevPage = 0;

  constructor() {
  }

  ngOnInit() {
    this.computePages();
  }

  ngOnChanges() {
    this.currentPage = this.page;
    this.computePages();
  }

  computePages() {
    this.totalPage = Number(this.collectionSize)> Number(this.pageSize)? Math.ceil(Number(this.collectionSize) / Number(this.pageSize)):1;

  }

  selectNewPage(event) {
    this.pageChange.emit(event);
    this.prevPage = this.currentPage;
    this.currentPage = event;
  }

  counter(i: number) {
    return new Array(i);
  }
}
