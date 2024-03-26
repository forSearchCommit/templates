import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { UserLogComponent } from '../admin-control/user-log/user-log.component';
import { AuthGuard } from '../../../guards/auth.guard';
import { AccessList } from "src/app/Common/access-right";
import { AccessGuard } from 'src/app/guards/access.guard';
import { PromotionDashboardComponent } from '../promotion-dashboard/promotion-dashboard.component';
import { PromotionDetails } from './promotion-details/promotion-details.component';
import { DrawDetails } from './promotion-details/components/draw-details/draw-details.component';

const routes: Routes = [
  // {
  //   path: '',
  //   // component: DashboardComponent,
  //   // canActivate: [AuthGuard]
  //   component: PromotionDashboardComponent,
  //   canActivate: [AuthGuard, AccessGuard],
  //   data: { accessId: AccessList.View_User_Group } //Need to change
  // },
  {
    path: ':id',
    component: PromotionDetails,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
  {
    path: ':id/:drawId/:type',
    component: DrawDetails,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PromotionRoutingModule { }
