import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgbModule } from "@ng-bootstrap/ng-bootstrap";
import { FormsModule } from '@angular/forms';
import { SharedModule } from '../../shared/shared.module';
import { MainPanelRoutingModule } from './main-panel-routing.module';
import { BankAccountSettingComponent } from './admin-control/bank-account-setting/bank-account-setting.component';
import { AddUserComponent } from './admin-control/add-user/add-user.component';
import { UserLogComponent } from './admin-control/user-log/user-log.component';
import { UserProfileComponent } from './user-profile/user-profile.component';
import { UserGroupComponent } from './user-group/user-group.component';
import { EditUserGroupComponent } from './user-group/edit-user-group/edit-user-group.component';
import { AddUserGroupComponent } from './user-group/add-user-group/add-user-group.component';
import { PromotionDashboardComponent } from './promotion-dashboard/promotion-dashboard.component';
import { StatisticsDashboardComponent } from './statistics-dashboard/statistics-dashboard.component';
import { AddPromotionComponent } from './promotion-dashboard/components/add-promotion/add-promotion.component';
import { EditPromotionComponent } from './promotion-dashboard/components/edit-promotion/edit-promotion.component';

@NgModule({
  declarations: [
    BankAccountSettingComponent,
    AddUserComponent,
    UserLogComponent,
    UserProfileComponent,
    UserGroupComponent,
    EditUserGroupComponent,
    AddUserGroupComponent,
    PromotionDashboardComponent,
    AddPromotionComponent,
    StatisticsDashboardComponent,
    EditPromotionComponent,
  ],
  imports: [
    CommonModule,
    SharedModule,
    NgbModule,
    FormsModule,
    MainPanelRoutingModule
  ]
})
export class MainPanelModule { }
