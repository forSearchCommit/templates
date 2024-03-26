import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AccessGuard implements CanActivate {
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    var access_list = JSON.parse(localStorage.getItem('promotionUserAccess'));
    var access_id = route.data.accessId;
    var allowed = false;
    var allowed = true;
    // if(Array.isArray(access_id)){
    //   allowed = access_id.some(function(i){
    //     return access_id.some(function(e){
    //       return i == e;
    //     })
    //   })
    // }
    // else{
    //   allowed = access_list.some(function(i){
    //     return i == access_id;
    //   });
    // }

    return allowed;
  }

}
