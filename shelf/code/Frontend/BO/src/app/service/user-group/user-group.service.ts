import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { throwError } from 'rxjs';
import { retry, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
declare var require
const Swal = require('sweetalert2')

import { GlobalConstants } from '../../Common/global-constants';

@Injectable({
  providedIn: 'root'
})
export class UserGroupService {
  // private REST_API_SERVER = "http://207.46.237.238:902/API";
  private REST_API_SERVER = environment.apiUrl;

  constructor(private httpClient: HttpClient) { }


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
    // window.alert(errorMessage);
    return throwError(errorMessage);
  }

  public GetList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/UserGroup/List?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public AddUserGroup(data) {
    var post = {
      "RoleType": data.RoleType,
      "RoleName": data.RoleName,
      "Currency": data.Currency
    };
    return this.httpClient.post(`${this.REST_API_SERVER}/UserGroup/Add`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
    }).pipe(catchError(this.handleError));
  }

  public GetUserGroupDetail(usergroup) {
    var post = {
      "RoleType": usergroup
    };
    return this.httpClient.post(`${this.REST_API_SERVER}/UserGroup/GetMenuAccess`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      }
    }).pipe(catchError(this.handleError));
  }

  public UpdateUserGroupDetail(data) {
    var post = {
      "RoleType": data.RoleType,
      "Currency": data.Currency,
      "SelectedMenu": data.AccessRight
    }
    return this.httpClient.post(`${this.REST_API_SERVER}/UserGroup/SetMenuAccess`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      }
    }).pipe(catchError(this.handleError));
  }

  public GetRoles() {
    return this.httpClient.get(`${this.REST_API_SERVER}/UserGroup/DropDownList`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }

  public DeleteRole(role) {
    return this.httpClient.post(`${this.REST_API_SERVER}/UserGroup/Delete`, { RoleType: role }, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      }
    }).pipe(catchError(this.handleError));
  }
}
