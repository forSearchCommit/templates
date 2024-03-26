import { Component, ComponentFactoryResolver, OnInit } from '@angular/core';
import { FormControl, FormGroup, NgForm, Validators } from '@angular/forms';
import { UserService } from "../../../service/user/user.service";
import { UserManagementService } from '../../../service/admin-control/user-management.service';
import { UserGroupService } from 'src/app/service/user-group/user-group.service';
declare var require
const Swal = require('sweetalert2')


@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.scss']
})
export class UserProfileComponent implements OnInit {
  formValidated = false;
  formValidated2 = false;
  loaded = false;
  profile = null;
  RoleDic={};
  UserTimezoneSelect = ""; //[VV-222] NIA 20210812
  
  constructor(private userService: UserService, private userGroup:UserGroupService) {

  }

  ngOnInit(): void {
    this.GetProfile();
    this.getRoles();
  }

  GetProfile() {
    this.userService.GetProfile().subscribe((data) => {
      if (data && data.body) {
        this.loaded = true;
        this.profile = data.body;   
        //[VV-222] NIA 20210812    
        var tmzone = this.profile.TimeZone / 60; //calculation to get timezone in hour
        this.UserTimezoneSelect = tmzone.toString(); //so that timezone select dropdown shown user timezone
      }
    })
  }

  //[VV-222] NIA 20210811
  TimezoneOnChanged(event: any) {
    this.userService.UpdateTimezone(event.target.value).subscribe((data) => {
      if (data && data.body && data.body["IsSuccess"] && data.body["IsSuccess"] == true) {
        Swal.fire("Success", "Success to Update Timezone", "success");//popup after successful update
        this.GetProfile();//load back data after successfully update timezone
      }
      else{
        //popup after failed update
        Swal.fire({
          title: 'Failed',
          text: "Failed to Update Timezone",
          icon: 'error',
          showConfirmButton: true,
        })
      }
    })
  }

  ChangePassword(data: NgForm) {
    if (!data.valid) {
      this.formValidated = true;
    } else {
      this.formValidated = false;
      if (data.value.conPass != data.value.newPass) {
        Swal.fire("Error", "Confirmation Password does not match with New Password.", "error");
      }
      else {
        var request = {
          CurrentPassword: data.value.currentPass,
          NewPassword: data.value.newPass,
          UserId: this.profile.UserId
        }
        this.userService.changePassword(request).subscribe((data) => {
          if (data && data.body && data.body["IsSuccess"] && data.body["IsSuccess"] == true) {
            Swal.fire("Success", "", "success");
          }
        },
          (error) => {                              //Error callback
            var swalErrorMsg = `${error.error.ErrorMessage}`;
            Swal.fire({
              title: 'Failed',
              text: swalErrorMsg,
              icon: 'error',
              showConfirmButton: true,
            })
          })
      }
    }
  }

  // EditProfile(data: NgForm) {
  //   if (!data.valid) {
  //     this.formValidated2 = true;
  //   } else {
  //     this.formValidated2 = false;
  //     this.userService.EditProfile(data.value.name, data.value.email).subscribe(resp => {
  //       if (resp && resp.body["IsSuccess"] && resp.body["IsSuccess"] == true) {
  //         Swal.fire("Success", "Edit Profile Success", "success");
  //       }
  //     });
  //   }
  // }

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