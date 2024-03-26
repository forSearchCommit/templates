import { Location } from '@angular/common';

location: Location;
export const environment = {
  production: true,
  firebase: {
    apiKey: "Your Api Key",
    authDomain: "Your Auth Domain",
    databaseURL: "Your Database Url",
    projectId: "Your Project Id",
    storageBucket: "Your StorageBucket url",
    messagingSenderId: "Your Sender Id",
  },
  apiUrl: location.protocol + "//camp.n8api01.org/api"
};