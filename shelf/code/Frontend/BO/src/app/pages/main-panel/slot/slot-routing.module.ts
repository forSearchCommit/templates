import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from '../../../guards/auth.guard';
import { AccessList } from 'src/app/Common/access-right';
import { AccessGuard } from 'src/app/guards/access.guard';
import { SlotDetailComponent } from './slot-detail/slot-detail.component';
//import { ImportDetailComponent } from './import-detail/import-detail.component';
//import { ImportMemberComponent } from './import-member/import-member.component';
import { ImportDetailRandomResultComponent } from './import-detail-random-result/import-detail-random-result.component';
import { DrawResultComponent } from './draw-result/draw-result.component';

const routes: Routes = [
  {
    path: ':id',
    component: SlotDetailComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Group }
  },
  // {
  //   path: ':id/:drawId/config',
  //   component: ImportDetailComponent,
  //   canActivate: [AuthGuard, AccessGuard],
  //   data: { accessId: AccessList.View_User_Log }
  // },
  // {
  //    path: ':id/:drawId/member',
  //    component: ImportMemberComponent,
  //    canActivate: [AuthGuard, AccessGuard],
  //    data: { accessId: AccessList.View_User_Log }
  // },
  {
    path: ':id/:drawId/result',
    component: DrawResultComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
  {
    path: ':id/:drawId/fakemember',
    component: ImportDetailRandomResultComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SlotRoutingModule { }
