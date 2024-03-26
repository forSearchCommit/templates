import { NgModule } from '@angular/core';
import { NgbModule } from "@ng-bootstrap/ng-bootstrap";
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { SharedModule } from '../../../shared/shared.module';

import { SlotRoutingModule } from './slot-routing.module';
import { SlotDetailComponent } from './slot-detail/slot-detail.component';
import { AddDrawComponent } from './slot-detail/components/add-draw/add-draw.component';
import { EditDrawComponent } from './slot-detail/components/edit-draw/edit-draw.component';
import { EditConfirmationComponent } from './slot-detail/components/edit-confirmation/edit-confirmation.component';
import { ImportPrizeMdl } from './slot-detail/components/add-draw/import-prize/import-prize.component';
import { ImportedPrizeCheckMdl } from './slot-detail/components/add-draw/imported-prize-check/imported-prize-check.component';
import { ImportMemberMdl } from './slot-detail/components/import-member/import-member.component';
// import { ImportMemberComponent } from './import-member/import-member.component';
import { ImportSlotRandomResultMdl } from './slot-detail/components/import-random-result/import-random-result.component';
import { ImportSlotRandomResultValidateMdl } from './slot-detail/components/import-random-result-validate/import-random-result-validate.component';
import { DrawSummaryMdl } from './slot-detail/components/draw-summary/draw-summary.component';

// import { ImportValidate } from './slot-detail/components/import-validate/import-validate.component';
// import { ImportSpwRandDrawMdl } from './slot-detail/components/import-randdraw/import-randdraw.component';
// import { ImportRandDrawValidate } from './slot-detail/components/import-randdraw-validate/import-randdraw-validate.component';
// import { SetWheel } from './slot-detail/components/set-wheel/set-wheel.component';
// import { ImportDetailComponent } from './import-detail/import-detail.component';
// import { ImportDetailMemberComponent } from './import-detail-member/import-detail-member.component';
import { ImportDetailRandomResultComponent } from './import-detail-random-result/import-detail-random-result.component';
// import { ViewWheelComponent } from './slot-detail/components/view-wheel/view-wheel.component';
import { DrawResultComponent } from './draw-result/draw-result.component';

@NgModule({
  declarations: [
    SlotDetailComponent, 
    AddDrawComponent,
    EditDrawComponent,
    EditConfirmationComponent,
    ImportPrizeMdl,
    ImportedPrizeCheckMdl,
    ImportSlotRandomResultMdl,
    DrawSummaryMdl,
    DrawResultComponent,
    ImportMemberMdl,
    ImportSlotRandomResultValidateMdl,
    ImportDetailRandomResultComponent
    // ImportSpwMdl, 
    // ImportValidate, 
    // ImportSpwRandDrawMdl, 
    // ImportRandDrawValidate, 
    // SetWheel, 
    // ImportDetailComponent, 
    // ImportDetailMemberComponent, ViewWheelComponent, DrawResultComponent,
    // ImportDetailRandDrawComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    NgbModule,
    FormsModule,
    SlotRoutingModule,
  ]
})
export class SlotModule { }
