import { Component, Output, TemplateRef, ViewChild, EventEmitter } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { UserManagementService } from '../../../../../service/admin-control/user-management.service'
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { UserGroupService } from 'src/app/service/user-group/user-group.service';
declare var require
const Swal = require('sweetalert2')

@Component({
    selector: 'editUser-modal',
    templateUrl: './editUserModal.component.html',
    styleUrls: ['./editUserModal.component.scss'],
    providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})

export class EditUserModalContent {
    @ViewChild('editUserModalContent', { read: TemplateRef }) editUserModalContent: TemplateRef<any>;
    @Output() refreshData = new EventEmitter();
    destroy$: Subject<boolean> = new Subject<boolean>();
    userDetails = null;
    loaded = false;
    formValidated = false;
    selectedUserId = null;
    modalReference: any;
    RoleList = [];

    constructor(public activeModal: NgbActiveModal, private modalService: NgbModal, private userManagementService: UserManagementService,
        private userGroup: UserGroupService) { }

    getData(id) {
        this.userManagementService.getUserDetails(id).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
            this.loaded = true;
            this.userDetails = data.UserList[0];
            this.selectedUserId = id;
        })
    }

    processEditUser(data) {
        if (!data.valid) {
            this.formValidated = true;
        } else {
            this.formValidated = false;
            this.userManagementService.SaveUserEdit(this.selectedUserId, data.value.name, data.value.email, data.value.roletype, data.value.status).subscribe(resp => {
                if (resp) {
                    this.refreshData.emit();
                    this.successNotif();
                    this.modalReference.close()
                }
            });
        }
    }

    openEditUserModal(id) {
        this.userDetails = null;
        this.getData(id)
        this.selectedUserId = id;
        this.modalReference = this.modalService.open(this.editUserModalContent, { centered: true });
    }

    successNotif() {
        Swal.fire({
            icon: 'success',
            title: 'Save Successful!',
            showConfirmButton: false,
            allowOutsideClick: false,
            timer: 1500
        })
    }

    ngOnInit(): void {
        this.getRoles();
    }

    getRoles() {
        this.userGroup.GetRoles().subscribe((resp: any) => {
            if (resp != null && resp.responsedata) {
                this.RoleList = resp.responsedata;
            }
        });
    }

}