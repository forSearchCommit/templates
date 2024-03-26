import { Component, OnInit, ViewChild } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import {UserGroupService} from 'src/app/service/user-group/user-group.service';
import {EditUserGroupComponent} from './edit-user-group/edit-user-group.component';
import {AddUserGroupComponent} from './add-user-group/add-user-group.component';
import {Access, AccessList} from 'src/app/Common/access-right';
declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-user-group',
  templateUrl: './user-group.component.html',
  styleUrls: ['./user-group.component.scss']
})
export class UserGroupComponent implements OnInit {
  loaded = false;
  showPerPage = 50;
  page = 1;
  UserGroups = null;
  TotalRecord = null;

  access = new Access();
  accesslist = AccessList;
  IsAccessible(id){
    return this.access.IsAccessible(id)
  }

  destroy$: Subject<boolean> = new Subject<boolean>();
  @ViewChild(EditUserGroupComponent) editModal: EditUserGroupComponent;
  @ViewChild(AddUserGroupComponent) addModal: AddUserGroupComponent;
  constructor( private userGroupService: UserGroupService,) { }

  ngOnInit(): void {
    this.getData();
  }

  getData(){
    var request = {
      PageNumber: this.page,
      PageSize : this.showPerPage
    }
    this.userGroupService.GetList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.UserGroups = data.Data;
      this.TotalRecord=data.TotalRecord;
    });
  }

  EditUserGroup(role){
    this.editModal.openModal(role);
  }

  DeleteUserGroup(role){
    Swal.fire({
      html: '<div>Confirmation to delete user group : </div><div><h4 class="f-w-700 py-2">' + role + '</h4></div>',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Yes, delete it !'
    }).then((result) => {
      if (result.isConfirmed) {
        this.userGroupService.DeleteRole(role).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
          if(data && data.IsSuccess){
            Swal.fire(
              'Success',
              '',
              'success'
            );
            this.getData();
          }
        });
      }
    });
  }

  AddUserGroup(){
    this.addModal.openModal();
  }

}
