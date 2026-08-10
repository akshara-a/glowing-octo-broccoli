import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./demo-component/demo-component').then(
        (component) => component.DemoComponent
      ),
    pathMatch: 'full',
  },
  {
    path: 'weather',
    loadComponent: () =>
      import('./open-meteo-weather/open-meteo-weather').then(
        (component) => component.OpenMeteoWeather
      ),
  },
  {
    path: '**',
    redirectTo: '',
  },
];
