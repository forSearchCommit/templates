import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgbModule } from "@ng-bootstrap/ng-bootstrap";
import { FormsModule } from '@angular/forms';
import { SharedModule } from '../../../shared/shared.module';
import { PromotionRoutingModule } from './promotion-routing.module';
import { PromotionDetails } from './promotion-details/promotion-details.component';
import { AddDraw } from './promotion-details/components/add-draw/add-draw.component';
import { ImportEligible } from './promotion-details/components/import-eligible/import-eligible.component';
import { ImportRewards } from './promotion-details/components/import-rewards/import-rewards.component';
import { DrawDetails } from './promotion-details/components/draw-details/draw-details.component';
// import { Announcement } from './promotion-details/components/announcement/announcement.component';
// import { PickerModule } from '@ctrl/ngx-emoji-mart';

@NgModule({
  declarations: [
    PromotionDetails,
    AddDraw,
    ImportEligible,
    ImportRewards,
    DrawDetails,
    // Announcement
  ],
  imports: [
    CommonModule,
    SharedModule,
    NgbModule,
    FormsModule,
    PromotionRoutingModule,
    
  ]
})
export class PromotionModule { }
