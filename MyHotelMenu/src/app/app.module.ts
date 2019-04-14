import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';

import { MyApp } from './app.component';
import { HomePage } from '../pages/home/home';
import { ListPage } from '../pages/list/list';

import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';
import { ShareService } from '../service';
import { HttpModule } from '@angular/http';
import { Network } from '@ionic-native/network';
import { NetworkProvider } from '../NetworkProvider';
import { CartPage } from '../pages/cart/cart';
import { RegisterPage } from '../pages/register/register';
import { LoginPage } from '../pages/login/login';
import { OrdersPage } from '../pages/orders/orders';
import { ConfirmOrderPage } from '../pages/confirm-order/confirm-order';
import { ProfilePage } from '../pages/profile/profile';
import { NgSwitch, NgSwitchCase, NgSwitchDefault } from '@angular/common'

@NgModule({
  declarations: [
    MyApp,
    HomePage,
    ListPage,
    CartPage,
    RegisterPage,
    LoginPage,
    OrdersPage,
    ConfirmOrderPage,
    ProfilePage
  ],
  imports: [
    BrowserModule,
    HttpModule,    
    IonicModule.forRoot(MyApp),
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage,
    ListPage,
    CartPage,
    RegisterPage,
    LoginPage,
    OrdersPage,
    ConfirmOrderPage,
    ProfilePage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    ShareService,
    Network,
    NetworkProvider,    
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ]
})
export class AppModule {}
