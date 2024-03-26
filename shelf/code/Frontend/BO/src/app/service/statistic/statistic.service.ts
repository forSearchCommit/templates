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
export class StatisticService {
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
      Swal.fire({
        title: 'Encountered Error!',
        html: error.error.ErrorCode,
        timer: 3000,
        confirmButtonText: "Back"
      }).then((result) => {

      })
    }
    // window.alert(errorMessage);
    return throwError(errorMessage);
  }

  public GetList(request) {
    let httpParams = new HttpParams({ fromObject: request })
    return this.httpClient.get(`${this.REST_API_SERVER}/Promotion/PromotionStatistic?${httpParams.toString()}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
        'accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).pipe(catchError(this.handleError));
  }
}
