import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { NgForm } from '@angular/forms';
import { UserDetails } from '../../interface';
import { ShareService } from '../../service';
import { BaseUrl } from '../../global';
import { HomePage } from '../home/home';

@Component({
  selector: 'page-login',
  templateUrl: 'login.html',
})
export class LoginPage {

  loginForm: UserDetails = <UserDetails>{};
  loaderObject: any;

  constructor(private navCtrl: NavController,
    private navParams: NavParams,
    private shareService: ShareService) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad LoginPage');
  }

  doLogin(login: NgForm) {
    try {
      this.loginForm.Mobile = login.value.Mobile;
      this.loginForm.Gender = login.value.Gender;
      this.loginForm.Password = login.value.Password;

      // mobile validation
      let regExp = /^[0-9]{10,12}$/;

      if (!regExp.test(this.loginForm.Mobile)) {
        this.shareService.ShowAlert("Please Enter Valid Mobile Number");
        return;
      }

      // loader
      this.loaderObject = this.shareService.GetCustomLoader();
      this.loaderObject.present();

      // Send data to server for validation. validation will be based on Email and mobile
      this.shareService.getPostData(BaseUrl.LOGIN, this.loginForm, null)
        .then(data => {
          this.ProcessLoginResponse(data);
          this.loaderObject.dismiss();
        })
        .catch(err => {
          this.loaderObject.dismiss();
        });
    }
    catch (err) {
      this.loaderObject.dismiss();
    }
  }

  ProcessLoginResponse(data) {
    try {
      let dResp = JSON.parse(data._body);      

      if (dResp.status == 'success') {
        // store local storage object
        this.shareService.SetLocalStorage(BaseUrl.TAG_STORAGE_USER, JSON.stringify(dResp.userObj));
        this.shareService.ShowToastMessage(dResp.reason);

        if (this.shareService.CheckIfUserIsLoggedInOrNot()) {
          // if user is logged in, then redirect to home page.
          this.navCtrl.setRoot(HomePage);
        }
      }
      else // thro error
        this.shareService.ShowToastMessage(dResp.reason);
    }
    catch (ex) {
      //alert(ex.message);
    }
  }

}
