import { Routes } from '@angular/router';
import { AuthGuard } from '../guards/auth.guard';

export const pages: Routes = [
    {
        path: 'dashboard',
        loadChildren: () => import('./main-panel/main-panel.module').then(m => m.MainPanelModule)
    },
];
