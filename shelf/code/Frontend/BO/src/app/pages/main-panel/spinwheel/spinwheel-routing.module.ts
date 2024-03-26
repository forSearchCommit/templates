import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from '../../../guards/auth.guard';
import { AccessList } from 'src/app/Common/access-right';
import { AccessGuard } from 'src/app/guards/access.guard';
import { SpinwheelDetailComponent } from './spinwheel-detail/spinwheel-detail.component';
import { ImportDetailComponent } from './import-detail/import-detail.component';
import { ImportDetailMemberComponent } from './import-detail-member/import-detail-member.component';
import { ImportDetailRandDrawComponent } from './import-detail-randdraw/import-detail-randdraw.component';
import { DrawResultComponent } from './draw-result/draw-result.component';

const routes: Routes = [
  {
    path: ':id',
    component: SpinwheelDetailComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Group }
  },
  {
    path: ':id/:drawId/config',
    component: ImportDetailComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
  {
    path: ':id/:drawId/member',
    component: ImportDetailMemberComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
  {
    path: ':id/:drawId/result',
    component: DrawResultComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
  {
    path: ':id/:drawId/fakemember',
    component: ImportDetailRandDrawComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SpinwheelRoutingModule { }
