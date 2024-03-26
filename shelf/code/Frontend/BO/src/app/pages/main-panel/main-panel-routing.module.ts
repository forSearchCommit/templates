import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent } from 'src/app/dashboard/dashboard.component';
import { AddUserComponent } from './admin-control/add-user/add-user.component';
import { UserLogComponent } from './admin-control/user-log/user-log.component';
import { BankAccountSettingComponent } from './admin-control/bank-account-setting/bank-account-setting.component';
import { AuthGuard } from '../../guards/auth.guard';
import { UserProfileComponent } from './user-profile/user-profile.component';
import { UserGroupComponent } from "./user-group/user-group.component";
import { AccessList } from "src/app/Common/access-right";
import { AccessGuard } from 'src/app/guards/access.guard';
import { PromotionDashboardComponent } from './promotion-dashboard/promotion-dashboard.component';
import { StatisticsDashboardComponent } from './statistics-dashboard/statistics-dashboard.component';

const routes: Routes = [
  {
    path: '',
    // component: DashboardComponent,
    // canActivate: [AuthGuard]
    component: PromotionDashboardComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Group } //Need to change
  },
  {
    path: 'user-management',
    loadChildren: () => import('./admin-control/user-management/user-management.module').then(m => m.UserManagementModule)
  },
  {
    path: 'promotion',
    loadChildren: () => import('./promotion/promotion.module').then(m => m.PromotionModule)
  },
  {
    path: 'spinwheel',
    loadChildren: () => import('./spinwheel/spinwheel.module').then(m => m.SpinwheelModule)
  },
  {
    path: 'slot',
    loadChildren: () => import('./slot/slot.module').then(m => m.SlotModule)
  },
  {
    path: 'add-user',
    component: AddUserComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.Add_User }
  },
  {
    path: 'user-log/:id',
    component: UserLogComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Log }
  },
  {
    path: "user-profile",
    component: UserProfileComponent,
    canActivate: [AuthGuard],

  },
  {
    path: "user-group",
    component: UserGroupComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Group }
  },
  {
    path: "promotion-dashboard",
    component: PromotionDashboardComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Group } //Need to change
  },
  {
    path: "statistic-report",
    component: StatisticsDashboardComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: { accessId: AccessList.View_User_Group } //Need to change
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MainPanelRoutingModule { }
