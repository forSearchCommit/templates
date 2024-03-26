// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.
import { Location } from '@angular/common';

location: Location;
export const environment = {
  production: false,
  firebase: {
    apiKey: "Your Api Key",
    authDomain: "Your Auth Domain",
    databaseURL: "Your Database Url",
    projectId: "Your Project Id",
    storageBucket: "Your StorageBucket url",
    messagingSenderId: "Your Sender Id"
  },
  // apiUrl: "https://camp-api.n8stg.com/api",
  // apiUrl: location.protocol + "//v9b-camp.v9vnb.org/api"
  apiUrl: "https://localhost:44398/API",
  //Remember change !!!
  cdnUrl: "https://n8doca01.n8stg.com/CDN/Campaign",
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
