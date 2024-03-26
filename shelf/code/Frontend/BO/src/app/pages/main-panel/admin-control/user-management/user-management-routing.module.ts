import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { UserManagementComponent } from './user-management.component';
import { AuthGuard } from '../../../../guards/auth.guard';
import {AccessGuard} from 'src/app/guards/access.guard';
import {AccessList} from 'src/app/Common/access-right'

const routes: Routes = [
  {
    path: '',
    component: UserManagementComponent,
    canActivate: [AuthGuard, AccessGuard],
    data: {accessId: AccessList.View_User_List}
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserManagementRoutingModule { }
