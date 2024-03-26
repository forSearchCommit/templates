import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { throwError } from 'rxjs';
import { retry, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { WheelPcs } from 'src/app/pages/main-panel/spinwheel/spinwheel-detail/components/add-draw/add-draw.component';

declare var require
const Swal = require('sweetalert2')

@Injectable({
  providedIn: 'root'
})
export class SpinwheelService {

  private REST_API_SERVER = environment.apiUrl;

  constructor(private httpClient: HttpClient) { }

  toNativeDate(date, time) {
    let hours = parseInt(time.substring(0, 2));
    let minutes = parseInt(time.substring(3, 5));
    let seconds = parseInt(time.substring(6, 8));
    let jsDate = new Date(Date.UTC(date.year, date.month - 1, date.day, hours, minutes, seconds));
    // jsDate.setFullYear(date.year);
    return jsDate;
  }

  handleError(error: HttpErrorResponse) {
    let errorMessage = 'Unknown error!';
    if (error.error instanceof ErrorEvent) {
      // Client-side errors
      errorMessage = `Error: ${error.error.message}`;
    } else {
      // Server-side errors
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }
    if (error.status == 401) {
      Swal.fire({
        title: 'Session Expired!',
        html: 'Please Login again',
        timer: 3000,
        confirmButtonText: "Back To Login"
      }).then((result) => {
        window.location.href = "";
      })
    }
    if (error.status == 400) {
      if (error.error.ErrorCode === 'PromotionDateTimeOverlap_Error') {
        Swal.fire({
          title: 'Add/Edit Promotion Failed!',
          html: "The date range is already exist, please select a new date",
          timer: 3000,
          confirmButtonText: "Back"
        }).then((result) => {

        })
      } else if (error.error.ErrorCode === 'DrawDateTimeOverlap_Error') {
        Swal.fire({
          title: 'Add/Edit Draw Failed!',
          html: "The date range is already exist, please select a new date",
          timer: 3000,
          confirmButtonText: "Back"
        })
      } else {
        Swal.fire({
          title: 'Encountered Error!',
          html: error.error.ErrorCode,
          timer: 3000,
          confirmButtonText: "Back"
        }).then((result) => { })
      }
    }
    // window.alert(errorMessage);
    return throwError(errorMessage);
  }

  public GetDrawList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/CampaignDetails?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public UploadImg(data: WheelPcs[], CampId) {
    const formData = new FormData();
    formData.append('CampId', CampId);

    data.forEach(ele => {
      formData.append(ele.Position.toString(), ele.ImgSrc);
    });

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/ViewImg`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      }
    }).pipe(catchError(this.handleError));
  }

  public CreateDraw(data) {
    var req = {
      CampaignId: data.CampaignId,
      PreStart: this.toNativeDate(data.PreDrawDate, data.PreDrawTime).toISOString().split('.')[0],
      StartDate: this.toNativeDate(data.StartDate, data.StartTime).toISOString().split('.')[0],
      EndDate: this.toNativeDate(data.EndDate, data.EndTime).toISOString().split('.')[0],
      Views: data.Views
    }
    
    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/NewDraw`, req, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public ImportPreview(data) {
    const formData = new FormData();
    formData.append('file', data.FileData);
    formData.append('DrawId', data.DrawId)

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/ImportPreview`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      }
    }).pipe(catchError(this.handleError));
  }

  public ImportRandDrawPreview(data) {
    const formData = new FormData();
    formData.append('file', data.FileData);
    formData.append('DrawId', data.DrawId);

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/ImportRandDrawPreview`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      }
    }).pipe(catchError(this.handleError));
  }

  public ImportValid(data) {

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/Import`, data, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  // 
  public ImportRandDrawValid(data) {

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/ImportRandDraw`, data, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public GetPrizeGrpList(drawId) {

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/Category?Id=${drawId}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public GetWheelList(drawId) {

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/Wheel?Id=${drawId}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public UpdateWheel(data) {

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/UpdateWheel`, data, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ViewImport(drawId) {
    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/ViewImport?Id=${drawId}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ViewImportRandDraw(drawId, page, size) {
    var param = `DrawId=${drawId}&Page=${page}&Size=${size}`

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/ViewImportRandDraw?${param}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ViewMbr(drawId, page, size, mbrcode) {

    var param = `Id=${drawId}&Page=${page}&Size=${size}`
    if(mbrcode != null){
      param = param + `&Code=${mbrcode}`
    }

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/ViewMember?${param}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ExportMbrList(req) {
    var param = `Id=${req.drawId}`
    
    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/ExportMember?${param}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/vnd.ms-excel',
      },
      responseType: 'blob'
    }).pipe(catchError(this.handleError));

  }

  public ClearImport(drawId) {
    var request = {
      drawId: drawId
    }

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/ClearImport`, request, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ClearImportRandDraw(drawId) {
    var request = {
      drawId: drawId
    }

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/ClearImportRandDraw`, request, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ViewResult(req) {
    var param = `Id=${req.drawId}&Page=${req.page}&Size=${req.size}`
    if(req.mbrcode != null){
      param = param + `&Code=${req.mbrcode}`
    }

    if(req.currency != null){
      param = param + `&Currency=${req.currency}`
    }

    if(req.statusId != null){
      param = param + `&Status=${req.statusId}`
    }

    if(req.prizeId != null){
      param = param + `&Pid=${req.prizeId}`
    }

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/Result?${param}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public GetDDPrizeList(drawId) {

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/DDPrize?Id=${drawId}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }

  public ExportWinner(req) {
    var param = `Id=${req.drawId}`
    if(req.mbrcode != null){
      param = param + `&Code=${req.mbrcode}`
    }

    if(req.currency != null){
      param = param + `&Currency=${req.currency}`
    }

    if(req.statusId != null){
      param = param + `&Status=${req.statusId}`
    }

    if(req.prizeId != null){
      param = param + `&Pid=${req.prizeId}`
    }

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/Export?${param}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/vnd.ms-excel',
      },
      responseType: 'blob'
    }).pipe(catchError(this.handleError));

  }

  public EditWheel(data: any[], drawId, campId) {

    var wheel = [];
    data.forEach(x => {
      var itm = {
        WheelId: x.Id,
        DisplayName: x.DisplayName,
        Position: x.Position,
        ImgURL: x.ImgURL
      }

      if (x.PrizeGrpId != null){
        itm["PrizeGrpId"] = x.PrizeGrpId;
      }
      wheel.push(itm)
    })

    var req = {
      CampId: campId,
      DrawId: drawId,
      Wheel: wheel
    }

    console.log(JSON.stringify(req));

    const formData = new FormData();
    formData.append('data', JSON.stringify(req));

    data.forEach(ele => {
      formData.append(ele.Position.toString(), ele.ImgSrc);
    });

    return this.httpClient.post(`${this.REST_API_SERVER}/Spw/EditWheel`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      }
    }).pipe(catchError(this.handleError));
  }

  public GetDrawStatus(drawId, IsImportRandDrawCheck) {

    return this.httpClient.get(`${this.REST_API_SERVER}/Spw/Status?Id=${drawId}&Rd=${IsImportRandDrawCheck}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
      }
    }).pipe(catchError(this.handleError));
  }
  
}
