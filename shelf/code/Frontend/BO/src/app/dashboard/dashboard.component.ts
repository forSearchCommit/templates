import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Access, AccessList } from 'src/app/Common/access-right';
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  constructor(private router: Router) { }
  access = new Access();
  ngOnInit(): void {
    // debugger;
    if (this.access.IsAccessible(AccessList.View_Transaction_History)) {
      this.router.navigate(['dashboard', "user-management"]);
    }
  }

}
