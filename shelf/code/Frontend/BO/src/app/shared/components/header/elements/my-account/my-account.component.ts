import { Component, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { AuthenticationService } from '../../../../../service/authentication/authentication.service';
import { UserService } from '../../../../../service/user/user.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-my-account',
  templateUrl: './my-account.component.html',
  styleUrls: ['./my-account.component.scss']
})
export class MyAccountComponent implements OnInit {

  userName;
  userRole;

  destroy$: Subject<boolean> = new Subject<boolean>();

  constructor(public authenticationService: AuthenticationService, private router: Router, private userService: UserService) {

  }

  // logout(){
  //   this.authenticationService.logout();
  // }
  // constructor(private router: Router) { }

  ngOnInit() {
    this.userName = localStorage.getItem('promotionUserTokenName');
    this.userRole = localStorage.getItem('promotionUserTokenRole');
  }

  logOut() {

    var request = {
      LoginId: localStorage.getItem('promotionUserTokenId'),
    }
    this.userService.LogOut(request).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
      localStorage.setItem('promotionserToken', '');
      localStorage.removeItem('promotionUserTokenName');
      localStorage.removeItem('promotionUserTokenRole');
      localStorage.removeItem('promotionUserAccess');
      localStorage.removeItem('promotionUserCurrency');
      this.router.navigate(['']);
      // this.loaded = true;
      // console.log('sadada');
      // console.log(data);
      // this.TotalRecord = data.TotalRecord;
    });
  }

}
