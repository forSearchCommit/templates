import { NgModule } from '@angular/core';
import { NgbModule } from "@ng-bootstrap/ng-bootstrap";
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { SharedModule } from '../../../shared/shared.module';

import { SpinwheelRoutingModule } from './spinwheel-routing.module';
import { SpinwheelDetailComponent } from './spinwheel-detail/spinwheel-detail.component';
import { AddDrawComponent } from './spinwheel-detail/components/add-draw/add-draw.component';
import { ImportSpwMdl } from './spinwheel-detail/components/import-eligable/import-eligable.component';
import { ImportValidate } from './spinwheel-detail/components/import-validate/import-validate.component';
import { ImportSpwRandDrawMdl } from './spinwheel-detail/components/import-randdraw/import-randdraw.component';
import { ImportRandDrawValidate } from './spinwheel-detail/components/import-randdraw-validate/import-randdraw-validate.component';
import { SetWheel } from './spinwheel-detail/components/set-wheel/set-wheel.component';
import { ImportDetailComponent } from './import-detail/import-detail.component';
import { ImportDetailMemberComponent } from './import-detail-member/import-detail-member.component';
import { ImportDetailRandDrawComponent } from './import-detail-randdraw/import-detail-randdraw.component';
import { ViewWheelComponent } from './spinwheel-detail/components/view-wheel/view-wheel.component';
import { DrawResultComponent } from './draw-result/draw-result.component';

@NgModule({
  declarations: [
    SpinwheelDetailComponent, 
    AddDrawComponent, 
    ImportSpwMdl, 
    ImportValidate, 
    ImportSpwRandDrawMdl, 
    ImportRandDrawValidate, 
    SetWheel, 
    ImportDetailComponent, 
    ImportDetailMemberComponent, ViewWheelComponent, DrawResultComponent,
    ImportDetailRandDrawComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    NgbModule,
    FormsModule,
    SpinwheelRoutingModule,
  ]
})
export class SpinwheelModule { }
