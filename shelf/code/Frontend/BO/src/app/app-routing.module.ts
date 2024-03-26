import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { ContentComponent } from "./shared/components/layout/content/content.component";
import { pages } from "./pages/pages.routes";
// import { SidebarComponent } from './components/sidebar/sidebar.component';
// import { ContentComponent } from "./shared/components/layout/content/content.component";
import { HomeComponent } from './components/home/home.component';
import { AdminControlComponent } from './components/admin-control/admin-control.component';
import { FullComponent } from "./shared/components/layout/full/full.component";
import { full } from "./shared/routes/full.routes";
import { content } from "./shared/routes/routes";
import { AuthGuard } from './guards/auth.guard';

const routes: Routes = [
  {
    path: '',
    component: LoginComponent
  },
  {
    path: '',
    component: ContentComponent,
    canActivate: [AuthGuard],
    children: pages
  },
  {
    path: '**',
    redirectTo: ''
  }
];

@NgModule({
  imports: [[RouterModule.forRoot(routes, {
    anchorScrolling: 'enabled',
    scrollPositionRestoration: 'enabled',
    relativeLinkResolution: 'legacy'
  })],
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
