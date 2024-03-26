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
export class UserManagementService {
    // private REST_API_SERVER = "http://207.46.237.238:902/API";
    private REST_API_SERVER = environment.apiUrl;

    constructor(private httpClient: HttpClient) { }

    handleError(error: HttpErrorResponse) {
        let errorMessage = 'Unknown error!';
        let swalErrorMsg = 'Unknown error!';
        if (error.error instanceof ErrorEvent) {
            // Client-side errors
            errorMessage = `Error: ${error.error.message}`;
            Swal.fire({
                text: errorMessage,
                icon: 'error',
                showConfirmButton: true,
            })

        } else {
            // Server-side errors
            errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
            swalErrorMsg = `${error.error.ErrorMessage}`;
            Swal.fire({
                title: 'Failed',
                text: swalErrorMsg,
                icon: 'error',
                showConfirmButton: true,
            })
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

    public getUserList() {
        return this.httpClient.get(`${this.REST_API_SERVER}/User/List?PageSize=100&PageNumber=0`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`
            }
        }).pipe(catchError(this.handleError));
    }

    public addNewUser(userId, password, name, email, roletype, status) {
        return this.httpClient.post(`${this.REST_API_SERVER}/User/Add`, { "UserId": userId, "Password": password, "Name": name, "Email": email, "RoleType": roletype, "Status": status }, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
                'accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).pipe(catchError(this.handleError));
    }

    public getUserDetails(id) {
        return this.httpClient.get(`${this.REST_API_SERVER}/User/List?UserId=${id}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`
            }
        }).pipe(catchError(this.handleError));
    }

    public getUserLog(id) {
        return this.httpClient.get(`${this.REST_API_SERVER}/User/Log?UserId=${id}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
                'accept': 'application/json'
            }
        }).pipe(catchError(this.handleError));
    }

    public SaveUserEdit(userId, name, email, roletype, status) {
        return this.httpClient.put(`${this.REST_API_SERVER}/User/Edit`, { "UserId": userId, "Name": name, "Email": email, "RoleType": roletype, "Status": status }, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
                'accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).pipe(catchError(this.handleError));
    }

    public DeleteUser(userId) {
        return this.httpClient.delete(`${this.REST_API_SERVER}/User/Delete?UserId=${userId}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
                'accept': 'application/json'
            }
        }).pipe(catchError(this.handleError));
    }

    public ResetPassword(userid, password) {
        var post = {
            "UserId": userid,
            "NewPassword": password
        }
        return this.httpClient.post(`${this.REST_API_SERVER}/User/ResetPassword`, post, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`,
                'accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).pipe(catchError(this.handleError));
    }
}