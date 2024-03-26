import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { throwError } from 'rxjs';
import { retry, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';

declare var require
const Swal = require('sweetalert2')

@Injectable({
  providedIn: 'root'
})
export class PromotionService {
  // private REST_API_SERVER = "http://207.46.237.238:902/API";
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

  public GetList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/List?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public AddPromotion(data) {
    var post = {
      "Title": data.Title,
      "Type": data.Type,
      "StartDate": this.toNativeDate(data.StartDate, data.StartTime).toISOString().split('.')[0],
      "EndDate": this.toNativeDate(data.EndDate, data.EndTime).toISOString().split('.')[0],
      "WebUrl": data.WebUrl,
      "MobileH5Url": data.MobileH5Url,
      "MobileAppUrl": data.MobileAppUrl,
      "AppFloatingUrl": data.AppFloatingUrl,
      "H5FloatingUrl": data.H5FloatingUrl
    };

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/AddPromotion`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public UpdatePromotion(data) {
    var post = {
      "Title": data.Title,
      "Type": data.Type,
      "StartDate": this.toNativeDate(data.StartDate, data.StartTime).toISOString().split('.')[0],
      "EndDate": this.toNativeDate(data.EndDate, data.EndTime).toISOString().split('.')[0],
      "RowId": data.RowId,
      "Status": data.Status,
      "WebUrl": data.WebUrl,
      "MobileH5Url": data.MobileH5Url,
      "MobileAppUrl": data.MobileAppUrl,
      "AppFloatingUrl": data.AppFloatingUrl,
      "H5FloatingUrl": data.H5FloatingUrl
    };

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/UpdatePromotion`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public DisablePromotion(data) {
    var post = {
      "RowId": data.RowId,
    }

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/DisablePromotion`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      }
    }).pipe(catchError(this.handleError));
  }

  public ToggleIcon(data) {
    var post = {
      "Id": data.Id,
      "Show": data.Show
    }

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/ShowHidePromo`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      }
    }).pipe(catchError(this.handleError));
  }

  public DisableDraw(data) {
    var post = {
      "DrawId": data.drawId,
    }
    console.log(post);
    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/DisableDraw`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      }
    }).pipe(catchError(this.handleError));
  }

  public GetPromotionDetail(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/List?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public GetPromotionDrawList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/CampaignDetails?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public AddDraw(data) {
    var post = {
      "CampaignId": data.CampaignId,
      "PreStart": this.toNativeDate(data.PreDrawDate, data.PreDrawTime).toISOString().split('.')[0],
      "StartDate": this.toNativeDate(data.StartDate, data.StartTime).toISOString().split('.')[0],
      "EndDate": this.toNativeDate(data.EndDate, data.EndTime).toISOString().split('.')[0],
      "RMBMaxAmount": data.RMBMaxAmount,
      "USDTMaxAmount": data.USDTMaxAmount
    };

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/AddDraw`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public ImportEligible(data) {
    const formData = new FormData();
    formData.append('file', data.FileData);
    formData.append('DrawId', data.DrawId)

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/ImportMember`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      }
    }).pipe(catchError(this.handleError));
  }

  public ImportRewards(data) {
    const formData = new FormData();
    formData.append('file', data.FileData);
    formData.append('DrawId', data.DrawId)

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/ImportReward`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      }
    }).pipe(catchError(this.handleError));
  }

  public AddAnnouncement(data) {
    const formData = new FormData();
    formData.append('file', data.FileData);
    formData.append('DrawId', data.DrawId);
    formData.append('Title', data.Title);
    formData.append('SubContent', data.SubContent);
    formData.append('PushDate', this.toNativeDate(data.PushDate, data.PushTime).toISOString().split('.')[0]);

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/AddAnnouncement`, formData, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'enctype': 'multipart/form-data'
      },
    }).pipe(catchError(this.handleError));
  }

  public GetAnnouncementList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/AnnouncementList?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public DeleteAnnouncement(data) {
    var post = {
      "NoticeId": data.NoticeId,
      "DrawId": data.DrawId
    };

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/DeleteAnnouncement`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public GetDrawDetailsData(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/CampaignDetails?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public GetDrawRewardsInfoWinners(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/RewardList?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public GetDrawRewardsInfoMembers(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/RewardMemberList?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public GetRewardWinners(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/ExportMemberList?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/vnd.ms-excel',
      },
      responseType: 'blob'
    }).pipe(catchError(this.handleError));
  }

  public GetRewardList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/ExportRewardList?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/vnd.ms-excel',
      },
      responseType: 'blob',
    }).pipe(catchError(this.handleError));
  }

  public GetPromoStatus(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/ExportRewardStatus?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/vnd.ms-excel',
      },
      responseType: 'blob',
    }).pipe(catchError(this.handleError));
  }

  public GetRewardWinnersExport(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/ExportRewardWinners?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/vnd.ms-excel',
      },
      responseType: 'blob'
    }).pipe(catchError(this.handleError));
  }

  public ClearMemberList(data) {
    var post = {
      "DrawId": data.DrawId,
    };

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/ClearMemberList`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public ClearRewardList(data) {
    var post = {
      "DrawId": data.DrawId,
    };

    return this.httpClient.post(`${this.REST_API_SERVER}/Promotion/ClearRewardList`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }
}
