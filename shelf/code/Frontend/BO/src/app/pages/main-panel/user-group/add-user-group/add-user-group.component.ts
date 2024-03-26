import { Component, Output, TemplateRef, ViewChild, EventEmitter } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import {UserGroupService} from 'src/app/service/user-group/user-group.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';

declare var require
const Swal = require('sweetalert2')


@Component({
  selector: 'app-add-user-group',
  templateUrl: './add-user-group.component.html',
  styleUrls: ['./add-user-group.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class AddUserGroupComponent  {
  @ViewChild('AddModalContent', { read: TemplateRef }) AddModalContent: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  modalReference: any;
  Details=null;
  destroy$: Subject<boolean> = new Subject<boolean>();
  formValidated = false;
  currencyList ={
    USDT:false,
    RMB:false,
  }

  constructor(private userGroupService: UserGroupService,public activeModal: NgbActiveModal, private modalService: NgbModal) { 

  }

  ngOnInit(): void {
  }

  openModal(){
    this.modalReference = this.modalService.open(this.AddModalContent, {  size: 'lg', centered: true });
  }

  submit(data : NgForm){
    var currency = [];
    if(data.value.currency_USDT == true){
      currency.push('USDT');
    }
    if(data.value.currency_RMB == true){
      currency.push('RMB');
    }
    var request = {
        "RoleType": data.value.RoleType,
        "RoleName": data.value.RoleName,
        "Currency": currency
    }
    this.userGroupService.AddUserGroup(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if(data&& data.IsSuccess && data.IsSuccess == true){
          Swal.fire("Success","Add User Group Success","success")
          this.modalReference.close();
          this.refreshData.emit();
        }
        else{
          Swal.fire("Error","Error Occur","error")
        }
    });
  }

}
