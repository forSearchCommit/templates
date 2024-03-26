import { Component, Output, TemplateRef, ViewChild, EventEmitter } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { UserGroupService } from 'src/app/service/user-group/user-group.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';

declare var require
const Swal = require('sweetalert2')


@Component({
  selector: 'app-edit-user-group',
  templateUrl: './edit-user-group.component.html',
  styleUrls: ['./edit-user-group.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class EditUserGroupComponent {
  @ViewChild('EditModalContent', { read: TemplateRef }) EditModalContent: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  modalReference: any;
  Role = null;
  Details = null;
  destroy$: Subject<boolean> = new Subject<boolean>();
  currencyList = {};
  loaded = false;

  constructor(private userGroupService: UserGroupService, public activeModal: NgbActiveModal, private modalService: NgbModal) {

  }

  ngOnInit(): void {
  }


  getData() {
    this.userGroupService.GetUserGroupDetail(this.Role).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.Details = data;
      data.Currency.forEach(element => {
        this.currencyList[element] = true;
      });
    });
  }

  openModal(role) {
    this.Details=null;
    this.Role = role;
    this.currencyList = {};
    this.getData();
    this.modalReference = this.modalService.open(this.EditModalContent, { size: 'xl', centered: true });
  }

  Ismodulechecked(list) {
    return list.some(function (item) {
      return item.Selected == false;
    }) == false;
  }

  checkAll(moduleid, e) {
    var checked = e.target.checked;
    var index = this.Details.ModuleList.findIndex(function (element) { return element.ModuleId == moduleid });
    this.Details.ModuleList[index].MenuList.forEach(element => {
      element.Selected = checked;
    });
  }

  updateUserGroup() {
    console.log();
    var currency = [];
    var dummy =this.currencyList;
    Object.keys(this.currencyList).forEach(function(e){
      if(dummy[e]==true){
        currency.push(e);
      }
    });
    var accessright = [];
    this.Details.ModuleList.forEach(element => {
      element.MenuList.forEach(a => {
        if(a.Selected ==true){
          accessright.push(a.Value);
        }
      })
    });
    var request = {
      RoleType: this.Details.RoleType,
      Currency : currency,
      AccessRight:accessright
    }
    this.userGroupService.UpdateUserGroupDetail(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      if(data.IsSuccess && data.IsSuccess == true ){
        this.modalReference.close();
        this.refreshData.emit();
      }
      else{
        Swal.fire("Error","Error occur","error")
      }

    });
  }

}
