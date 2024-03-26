import { Component, Output, OnInit, ViewChild, OnDestroy, EventEmitter } from '@angular/core';
import { UserManagementService } from '../../../../service/admin-control/user-management.service'
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { EditUserModalContent } from './components/editUserModal.component';
import {ResetPasswordComponent} from './components/reset-password/reset-password.component';
import {Access, AccessList} from 'src/app/Common/access-right';
import { UserGroupService } from 'src/app/service/user-group/user-group.service';
declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-user-management',
  templateUrl: './user-management.component.html',
  styleUrls: ['./user-management.component.scss']
})
export class UserManagementComponent implements OnInit, OnDestroy {
  @ViewChild(EditUserModalContent) userEditModal: EditUserModalContent;
  @ViewChild(ResetPasswordComponent) resetPasswordModal: ResetPasswordComponent;
  @Output() refreshData = new EventEmitter();
  destroy$: Subject<boolean> = new Subject<boolean>();
  loaded = false;
  userLists;
  callMainListInterval;
  access = new Access();
  accesslist = AccessList;
  RoleDic = {};

  IsAccessible(id){
    return this.access.IsAccessible(id)
  }

  constructor(private userManagementService: UserManagementService, private userGroup : UserGroupService) { }

  ngOnInit() {
    this.getRoles();
    this.userManagementService.getUserList().pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data.UserList.length > 0) {
        this.userLists = data.UserList;
        /* data.UserList[3].Status = 2; */
        this.loaded = true;
      }
    })
  }

  ngOnDestroy() {
    this.destroy$.next(true);
    // Unsubscribe from the subject
    this.destroy$.unsubscribe();
  }

  public refreshCurrentUserListTable(event) {
    this.loaded = false;
    this.userManagementService.getUserList().pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if (data.UserList.length > 0) {
        this.userLists = data.UserList;
        this.loaded = true;
      }
    })
  }

  openEditUserModal(id) {
    this.userEditModal.openEditUserModal(id);
  }

  deleteUser(id) {
    Swal.fire({
      html: '<div>Confirmation to delete user : </div><div><h4 class="f-w-700 py-2">' + id + '</h4></div><div class="text-danger"><h6>Note: You are not able to revert once deleted !</h6></div>',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Yes, delete it !'
    }).then((result) => {
      if (result.isConfirmed) {
        this.userManagementService.DeleteUser(id).subscribe(resp => {
          if (resp) {
            this.loaded = false;
            this.userManagementService.getUserList().pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
              if (data.UserList.length > 0) {
                this.userLists = data.UserList;
                this.loaded = true;
              }
            })
            this.successDeleteUser();
            console.log("success");
          }
        });
      }
    })
  }

  successDeleteUser() {
    Swal.fire({
      type: 'success',
      title: 'User deleted!',
      icon: 'success',
      showConfirmButton: false,
      allowOutsideClick: false,
      timer: 1500
    })
  }

  resetPassword(Id){
    this.resetPasswordModal.openModal(Id);
  }

  getRoles(){
    this.userGroup.GetRoles().subscribe((resp:any) => {
      if(resp != null && resp.responsedata){
        var dic = {};
        resp.responsedata.forEach(function(item){
          dic[item.Value] = item.Text;
        });
        this.RoleDic = dic;
      }
    });
  }
}
