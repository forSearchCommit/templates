import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { AuthenticationService } from '../service/authentication/authentication.service';
import { Observable, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  // private REST_API_SERVER = "http://207.46.237.238:902/API";
  private REST_API_SERVER = environment.apiUrl;
  constructor(private authenticationService: AuthenticationService, private router: Router, private httpClient: HttpClient) {

  }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    return this.httpClient.post<any>(`${this.REST_API_SERVER}/User/Profile`, '', {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('promotionUserToken')}`
      }
    }).pipe(
      map(res => {
        return true;
      }),
      catchError((err) => {
        this.router.navigate(['']);
        return of(false);
      })
    );
  }
}
