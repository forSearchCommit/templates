import { Component,TemplateRef, ViewChild} from '@angular/core';
import {  NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Subject } from 'rxjs'; 
import {UserManagementService} from "src/app/service/admin-control/user-management.service";
import { takeUntil } from 'rxjs/operators';
declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-reset-password',
  templateUrl: './reset-password.component.html',
  styleUrls: ['./reset-password.component.scss']
})
export class ResetPasswordComponent {
  @ViewChild('resetPasswordModal', { read: TemplateRef }) resetModal: TemplateRef<any>;
  destroy$: Subject<boolean> = new Subject<boolean>();
  userId = null;
  modalReference: any;
  newpassword = "";
  constructor( private modalService: NgbModal, private userService : UserManagementService) { }

  ngOnInit(): void {
  }

  openModal(id){
    this.newpassword="";
    this.userId = id;
    this.modalReference = this.modalService.open(this.resetModal, { centered: true });
  }

  reset(){
    console.log(this.newpassword);
    this.userService.ResetPassword(this.userId, this.newpassword).pipe(takeUntil(this.destroy$)).subscribe((data) => {
        if(data && data["IsSuccess"]&& data["IsSuccess"] == true){
          Swal.fire({
            type: 'success',
            title: 'User Password reset! ['+this.userId+']',
            icon: 'success',
            showCloseButton: false,
            allowOutsideClick: false,
            timer: 1500
          });
        }
        else{
          Swal.fire({
            type: 'error',
            title: 'Error occur',
            icon: 'error',
            showCloseButton: false,
          })
        }
        this.modalReference.close()
    })
  }
}
