import { Component, ViewChild, TemplateRef, EventEmitter, Output } from '@angular/core';
import { NgbActiveModal, NgbModal, ModalDismissReasons, NgbModalConfig } from '@ng-bootstrap/ng-bootstrap';
import { PromotionService } from 'src/app/service/promotion/promotion.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { NgForm } from '@angular/forms';
import { NgbTimepickerConfig, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { environment } from 'src/environments/environment';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'announcement-modal',
  templateUrl: './announcement.component.html',
  styleUrls: ['./announcement.component.scss'],
  providers: [NgbModalConfig, NgbModal, NgbActiveModal]
})
export class Announcement {
  @ViewChild('AnnouncementModal', { read: TemplateRef }) AnnouncementModal: TemplateRef<any>;
  @Output() refreshData = new EventEmitter();
  modalReference: any;
  Details = null;
  destroy$: Subject<boolean> = new Subject<boolean>();
  formValidated = false;
  seconds = true;
  url = environment.cdnUrl;

  noTitle = false;
  noSubContent = false;
  noPushDateTime = false;
  noFile = false;
  hasError = false;

  startDateLimit: any;
  endDateLimit: any;
  drawId: any;
  fileUploaded: any;
  noticeId: any;
  status: any;

  loaded = true;
  AnnouncementList = null;
  TotalRecord = null;

  Title = null;
  SubContent = null;
  PushDate = null;
  PushTime = null;
  showEmojiPicker = false;
  showEmojiPicker2 = false;

  constructor(private promotionService: PromotionService, public activeModal: NgbActiveModal, private modalService: NgbModal, private config: NgbTimepickerConfig) {
    config.seconds = true;
    config.spinners = false;
  }

  set = 'google';
  toggleEmojiPicker() {
    this.showEmojiPicker = !this.showEmojiPicker;
  }

  toggleEmojiPicker2() {
    this.showEmojiPicker2 = !this.showEmojiPicker2;
  }

  addEmoji2(event) {
    console.log(this.SubContent);
    console.log(`${event.emoji.native}`);
    this.SubContent += event.emoji.native;
  }

  addEmoji(event) {
    console.log(this.Title);
    console.log(`${event.emoji.native}`);
    this.Title += event.emoji.native;
  }

  onFocus() {
    this.showEmojiPicker = false;
  }

  onFocus2() {
    this.showEmojiPicker2 = false;
  }

  ngOnInit(): void {
  }

  DeleteAnnouncement(noticeId){
    Swal.fire({
      title: 'Are you sure you want to delete?',
      showCancelButton: true,
      confirmButtonText: 'Yes',
    }).then((result) => {
      if (result.isConfirmed) {
        var request = {
          "NoticeId": noticeId,
          "DrawId": this.drawId
        }
    
        this.promotionService.DeleteAnnouncement(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
          if (data && data.IsSuccess && data.IsSuccess == true) {
            Swal.fire("Success", "Delete Announcement Success", "success")
            this.refreshData.emit();
            this.getData(this.drawId);
          }
          else {
            Swal.fire("Error", "Delete Announcement Failed", "error")
          }
        });
      }
    })
  }

  getData(drawId) {
    var request = {
      drawId: drawId
    }
    this.promotionService.GetAnnouncementList(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      this.loaded = true;
      this.AnnouncementList = data.Data;
      this.TotalRecord = data.TotalRecord;
    });
  }

  openModal(drawId, status) {
    this.drawId = drawId;
    this.status = status;
    this.Title = '';
    this.SubContent = '';
    this.PushDate = null;
    this.PushTime = null;
    this.fileUploaded = null;
    this.noTitle = false;
    this.noSubContent = false;
    this.noPushDateTime = false;
    this.noFile = false;
    this.hasError = false;
    console.log(this.url);
    this.modalReference = this.modalService.open(this.AnnouncementModal, { size: 'xl', centered: true });
    this.getData(drawId);
  }

  goToLink(url: string){
    window.open(url, "_blank");
}

  onFileChange(event) {
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.fileUploaded = file;
      console.log(this.fileUploaded.size);
      console.log(this.fileUploaded.type);
    }
  }

  submit(data: NgForm) {
    this.noTitle = false;
    this.noSubContent = false;
    this.noPushDateTime = false;
    this.noFile = false;
    this.hasError = false;

    if (data.value.Title == null || data.value.Title == '') {
      this.noTitle = true;
      this.hasError = true;
    }

    if (data.value.SubContent == null || data.value.SubContent == '' ) {
      this.noSubContent = true;
      this.hasError = true;
    }

    if (this.fileUploaded != null && this.fileUploaded.size > 307200) {
      this.noFile = true;
      this.hasError = true;
    }

    if (data.value.PushDate == null || data.value.PushTime == null) {
      this.noPushDateTime = true;
      this.hasError = true;
    }

    if (!this.hasError) {
      var pushTime = ("0" + data.value.PushTime.hour).slice(-2) + ":" + ("0" + data.value.PushTime.minute).slice(-2) + ":" + ("0" + data.value.PushTime.second).slice(-2);

      var request = {
        "DrawId": this.drawId,
        "Title": data.value.Title,
        "SubContent": data.value.SubContent,
        "PushDate": data.value.PushDate,
        "PushTime": pushTime,
        "FileData": this.fileUploaded,
      }

      this.promotionService.AddAnnouncement(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
        if (data && data.IsSuccess && data.IsSuccess == true) {
          Swal.fire("Success", "Add Announcement Success", "success")
          //this.modalReference.close();
          this.refreshData.emit();
          this.getData(this.drawId);
        }
        else {
          Swal.fire("Error", "Add Announcement Failed", "error")
        }
      });
      data.reset();
      (<HTMLInputElement>document.getElementById("import_file")).value = "";
      this.fileUploaded = null;
    }

  }
}
