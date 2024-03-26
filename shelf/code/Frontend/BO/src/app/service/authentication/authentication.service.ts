import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { SignInData } from 'src/app/model/signInData';
import { GlobalConstants } from '../../Common/global-constants';
import { environment } from 'src/environments/environment';

declare var require
const Swal = require('sweetalert2')

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  // private REST_API_SERVER = "http://207.46.237.238:902/API";
  private REST_API_SERVER = environment.apiUrl;
  /* readonly rootUrl = 'http://localhost:4200/'; */
  /* constructor(private http: HttpClient){} */

  /* private readonly mockedUser = new SignInData('admin', 'test123'); */
  isAuthenticated = false;
  loginFailedMsg;

  constructor(private router: Router, private http: HttpClient) {

  }

  authenticate(signInData: SignInData): boolean {
    var validationPass = false;
    this.isAuthenticated = false;
    validationPass = this.prePostChecking(signInData);
    if (validationPass) {
      validationPass = true;
      // debugger;
      this.postLogin(signInData);
    }

    return validationPass;
  }

  private postLogin(signInData: SignInData): boolean {
    var validMember = false;
    let swalErrorMsg = 'Unknown error!';
    const headersContent = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };
    const body = { Password: signInData.getPassword(), UserId: signInData.getUserId() };


    // GlobalConstants.accessToken = resp.body.AccessToken;
    // GlobalConstants.accessTokenName = resp.body.Name;
    // GlobalConstants.accessTokenRole = resp.body.UserRole;
    // localStorage.setItem('promotionUserToken', resp.body.AccessToken);
    // localStorage.setItem('promotionUserTokenId', resp.body.UserId);
    // localStorage.setItem('promotionUserTokenName', resp.body.Name);
    // localStorage.setItem('promotionUserTokenRole', resp.body.UserRole);
    // localStorage.setItem('promotionUserAccess', JSON.stringify(resp.body.MenuList));
    // localStorage.setItem('promotionUserCurrency', JSON.stringify(resp.body.Currency));
    this.isAuthenticated = true;
    // this.router.navigate(['dashboard']);

    this.http.post<any>(`${this.REST_API_SERVER}/User/Login`, body, { headers: headersContent, observe: 'response' }).subscribe(resp => {
      // console.log(resp);
      if (resp.ok) {
        GlobalConstants.accessToken = resp.body.AccessToken;
        GlobalConstants.accessTokenName = resp.body.Name;
        GlobalConstants.accessTokenRole = resp.body.UserRole;
        localStorage.setItem('promotionUserToken', resp.body.AccessToken);
        localStorage.setItem('promotionUserTokenId', resp.body.UserId);
        localStorage.setItem('promotionUserTokenName', resp.body.Name);
        localStorage.setItem('promotionUserTokenRole', resp.body.UserRole);
        localStorage.setItem('promotionUserAccess', JSON.stringify(resp.body.MenuList));
        localStorage.setItem('promotionUserCurrency', JSON.stringify(resp.body.Currency));
        this.isAuthenticated = true;
        this.router.navigate(['dashboard']);
      }
    },
      (error) => {
        // console.log("aa");                    //Error callback
        this.isAuthenticated = false;
        swalErrorMsg = `${error.error.ErrorMessage}`;
        Swal.fire({
          title: 'Failed',
          text: swalErrorMsg,
          icon: 'error',
          showConfirmButton: true,
        })
        // alert("Login Failed !! ");
      });

    return validMember;
  }

  private prePostChecking(signInData: SignInData): boolean {
    var isValid = true;

    if (signInData.getUserId() == "") {
      isValid = false;
    }
    else if (signInData.getPassword() == "") {
      isValid = false;
    }
    return isValid;
  }

  /*   private checkCredentials(signInData: SignInData): boolean {
      return this.checkUserId(signInData.getUserId()) && this.checkPassword(signInData.getPassword());
    }
  
    private checkUserId(userId: string): boolean {
      return userId === this.mockedUser.getUserId();
    }
  
    private checkPassword(password: string): boolean {
      return password === this.mockedUser.getPassword();
    } */

  logout() {
    this.isAuthenticated = false;
    this.router.navigate(['']);
  }
}
