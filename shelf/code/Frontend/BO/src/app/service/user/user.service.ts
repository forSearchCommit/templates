import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { throwError } from 'rxjs';
import { retry, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { GlobalConstants } from '../../Common/global-constants';
declare var require
const Swal = require('sweetalert2')

@Injectable({
  providedIn: 'root'
})
export class UserService {
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

  public changePassword(data) {
    var post = data;
    return this.httpClient.post(`${this.REST_API_SERVER}/User/ChangePassword`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      observe: 'response'
    }).pipe();
  }

  public GetProfile() {
    return this.httpClient.post(`${this.REST_API_SERVER}/User/Profile`, {}, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      observe: 'response'
    }).pipe(catchError(this.handleError));
  }

  public EditProfile(name, email) {
    var post = {
      Name: name,
      Email: email
    }
    return this.httpClient.put(`${this.REST_API_SERVER}/User/EditProfile`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      observe: 'response'
    }).pipe(catchError(this.handleError));
  }

  public UpdateTimezone(gmtVal) {
    var post = { timezone: gmtVal }
    return this.httpClient.put(`${this.REST_API_SERVER}/User/UpdateTimezone`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      observe: 'response'
    }).pipe(catchError(this.handleError));
  }

  public LogOut(post) {
    // var post = {
    // Name: name,
    // Email: email
    // }
    return this.httpClient.post(`${this.REST_API_SERVER}/User/Logout`, post, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      observe: 'response'
    }).pipe(catchError(this.handleError));
  }

}
