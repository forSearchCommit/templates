import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { UserGroupService } from 'src/app/service/user-group/user-group.service';
import { UserManagementService } from '../../../../service/admin-control/user-management.service'
declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.scss']
})
export class AddUserComponent implements OnInit {

  formValidated = false;
  RoleList=[];

  constructor(private userManagementService: UserManagementService, private userGroup : UserGroupService) { }

  createNewUser(data: NgForm) {
    if (!data.valid) {
      this.formValidated = true;
    } else {
      this.formValidated = false;
      this.userManagementService.addNewUser(data.value.userid, data.value.password, data.value.name, data.value.email, data.value.roletype, data.value.status).subscribe(resp => {
        this.successNotif();
      });
    }
  }

  ngOnInit(): void {
    this.getRoles();
  }

  successNotif() {
    Swal.fire({
      type: 'success',
      title: 'Create Successful!',
      icon: 'success',
      allowOutsideClick: false,
      showConfirmButton: true,
    }).then((result) => {
      if (result.isConfirmed) {
        window.location.href = "/dashboard/user-management";
      }
    })
  }

  getRoles(){
    this.userGroup.GetRoles().subscribe((resp:any) => {
      if(resp != null && resp.responsedata){
        this.RoleList = resp.responsedata;
      }
    });
  }

}
