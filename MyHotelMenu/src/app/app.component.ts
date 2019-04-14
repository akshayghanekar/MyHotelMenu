import { Component, ViewChild } from '@angular/core';
import { Nav, Platform, AlertController, Events } from 'ionic-angular';
import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';

import { HomePage } from '../pages/home/home';
import { ListPage } from '../pages/list/list';
import { BaseUrl } from '../global';
import { ShareService } from '../service';
import { Network } from '@ionic-native/network'
import { NetworkProvider } from '../NetworkProvider'
import { RegisterPage } from '../pages/register/register';
import { LoginPage } from '../pages/login/login';
import { UserDetails } from '../interface';
import { OrdersPage } from '../pages/orders/orders';
import { ProfilePage } from '../pages/profile/profile';


@Component({
  templateUrl: 'app.html'
})
export class MyApp {
  @ViewChild(Nav) nav: Nav;

  rootPage: any = HomePage;
  pages: Array<{ title: string, component: any }>;
  AlertObject: any;
  loaderObject: any;
  userObj: UserDetails = <UserDetails>{};
  OTPPopupObject: any;

  MenuTitle: string = "";

  constructor(public platform: Platform, public statusBar: StatusBar, public splashScreen: SplashScreen, public shareService: ShareService, private network: Network, private events: Events, private networkProvider: NetworkProvider) {
    this.initializeApp();
    //this.loaderObject = shareService.GetCustomLoader();
    //this.ChecKUserLoggedIn();
  }

  initializeApp() {
    this.platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      //this.statusBar.styleDefault();
      this.statusBar.backgroundColorByHexString("#CD1E37");

      this.networkProvider.InitializeNetworkEvents();

      // offline Network
      this.events.subscribe('NetworkOffline', () => {
        this.shareService.ShowToastMessage("Please Check Internet Connection");
      });

      // onlne Network
      this.events.subscribe('NetworkOnline', () => {
        this.shareService.ShowToastMessage("App Connected To Internet");
      });

      this.splashScreen.hide();
    });    
  }

  openPage(page) {
    // Reset the content nav to have just this page
    // we wouldn't want the back button to show in this scenario
    this.nav.setRoot(page.component);
  }

  ChecKUserLoggedIn(): boolean {
    let isLoggedIn = this.shareService.CheckIfUserIsLoggedInOrNot();
    
    if (!isLoggedIn) {
      // case for user not logged in
      // used for an example of ngFor and navigation
      this.pages = [
        { title: 'Home', component: HomePage },
        { title: 'Login', component: LoginPage },
        { title: 'Register', component: RegisterPage },
        { title: 'About', component: HomePage }
        //{ title: 'List', component: ListPage }
      ];

      this.MenuTitle = "Guest";
    }
    else {
      // case for user logged in
      this.pages = [
        { title: 'Home', component: HomePage },
        { title: 'My Orders', component: OrdersPage },
        { title: 'My Profile', component: ProfilePage },
        { title: 'About', component: HomePage }
      ];

      // Get User Details, so that it can be filled in menu panel
      if (this.userObj.Name == undefined) {
        let obj = this.shareService.GetLocalStorage(BaseUrl.TAG_STORAGE_USER);
        this.userObj = JSON.parse(obj);
        this.MenuTitle = this.userObj.Name;
      }
      else
        this.MenuTitle = this.userObj.Name;
    }
    return isLoggedIn;
  }

  verifyAccount() {
    try {
      this.loaderObject = this.shareService.GetCustomLoader();
      this.loaderObject.present();

      // Send request for OTP Verification.
      // Generate OTP request first
      let dataObj = {
        Number: this.userObj.Mobile,
        Name: this.userObj.Name
      };
      this.shareService.getPostData(BaseUrl.OTP_GENERATE, dataObj, null)
        .then(data => {
          this.ProcessVerifyAccount(data);
          this.loaderObject.dismiss();
        })
        .catch(err => {
          this.loaderObject.dismiss();
        });
      //this.shareService.ShowOTPWindow()
    }
    catch (ex) {

    }
  }

  ProcessVerifyAccount(data) {
    try {
      let dResp = JSON.parse(data._body);
      let dndResponse = (dResp.apiResponse != undefined) ? JSON.parse(dResp.apiResponse) : "";

      if (dResp.status == 'success') {
        // OTP generated successfully and sent to user. Now Open OTP window
        this.OTPPopupObject = this.shareService.ShowOTPWindow(dResp.OTP, dResp.Mobile, () => { this.CompleteVerificationProcess(); });
        this.OTPPopupObject.present();
      }
      else
        this.shareService.ShowAlert(dResp.reason);
    }
    catch (ex) {
      alert(ex.message);
    }
  }

  CompleteVerificationProcess() {    
    try {
      //Account is verified successfully. Now, Update local storage object status
      let storageObj = this.shareService.GetLocalStorage(BaseUrl.TAG_STORAGE_USER);
      // if object present
      if (storageObj != undefined) {
        let userObj = JSON.parse(storageObj);
        userObj.isVerified = "1"; // update status
        this.shareService.SetLocalStorage(BaseUrl.TAG_STORAGE_USER, JSON.stringify(userObj));
        this.userObj.isVerified = "1"; // assign to scope variable
      }
    }
    catch (ex) {
      //alert(ex.message);
    }
  }

  LogoutAccount() {
    this.loaderObject = this.shareService.GetCustomLoader();
    this.loaderObject.present();

    this.shareService.RemoveLocalStorage(BaseUrl.TAG_STORAGE_USER);
    this.ChecKUserLoggedIn();
    this.shareService.ShowToastMessage("User Logged out successfully");

    this.loaderObject.dismiss();
  }
}
