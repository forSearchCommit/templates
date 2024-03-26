import { Component, OnInit, ViewChild, Input } from '@angular/core';

@Component({
  selector: 'draw-items',
  templateUrl: './draw-items.component.html',
  styleUrls: ['./draw-items.component.scss']
})

export class DrawItems implements OnInit {
  @Input() drawData: any;
  @Input() currentPromotionId: any;

  constructor() { }

  ngOnInit(): void {
  }

  onCheckboxChange(drawId, isChecked) {
    // if (isChecked) {
    //   this.DrawSelected.push(drawId);
    // } else {
    //   this.DrawSelected.splice(this.DrawSelected.indexOf(drawId), 1);
    // }
  }
}
