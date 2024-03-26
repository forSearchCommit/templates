import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { AuthenticationService } from '../service/authentication/authentication.service';
import { SignInData } from '../model/signInData';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';

declare var require
const Swal = require('sweetalert2')

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  isFormValid = false;
  areCredentialsInvalid = false;

  constructor(private authenticationService: AuthenticationService) { }

  ngOnInit(): void {
    localStorage.setItem('promotionUserToken', '');

  }

  onSubmit(signInForm: NgForm) {
    this.isFormValid = false; //To clear "Fill All Field" msg display previously and check again
    const signInData = new SignInData(signInForm.value.userId, signInForm.value.password);

    if (!signInForm.valid) {
      this.isFormValid = true;
      this.areCredentialsInvalid = false;
      return;
    }

    this.authenticationService.authenticate(signInData);
  }

  ForgetPassword(){
    Swal.fire({
      title: 'Forgot your password ?',
      text: 'Please look for Ventem IT DART team for support.',
      icon: 'info',
      showConfirmButton: true,
    })
  }

}
