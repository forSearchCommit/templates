import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { UserManagementService } from '../../../../service/admin-control/user-management.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { UserGroupService } from 'src/app/service/user-group/user-group.service';

@Component({
  selector: 'app-user-log',
  templateUrl: './user-log.component.html',
  styleUrls: ['./user-log.component.scss']
})
export class UserLogComponent implements OnInit {

  destroy$: Subject<boolean> = new Subject<boolean>();
  userDetails = null;
  LogList = null;
  loaded = false;
  dataExist = false;
  RoleDic={};

  constructor(private userManagementService: UserManagementService, private route: ActivatedRoute, private userGroup:UserGroupService) { }


ngOnInit() {
  this.getRoles();
  this.userManagementService.getUserDetails(this.route.snapshot.paramMap.get('id')).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
    if (data.UserList.length > 0) {
      this.userDetails = data.UserList;
      this.loaded = true;
    } else {
      //no data alert here
    }
  })

  this.userManagementService.getUserLog(this.route.snapshot.paramMap.get('id')).pipe(takeUntil(this.destroy$)).subscribe((data: any) => {
    if (data.LogList.length > 0) {
      this.LogList = data.LogList;
      this.loaded = true;
      this.dataExist = true;
    } else {
      //no data alert here
      this.dataExist = false;
    }
  })
}

ngOnDestroy() {
  this.destroy$.next(true);
  // Unsubscribe from the subject
  this.destroy$.unsubscribe();
}
getRoles(){
  this.userGroup.GetRoles().subscribe((resp:any) => {
    if(resp != null && resp.responsedata){
      var dic = {};
      resp.responsedata.forEach(function(item){
        dic[item.Value] = item.Text;
      });
      this.RoleDic = dic;
    }
  });
}

}
