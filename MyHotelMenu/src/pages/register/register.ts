import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, AlertController } from 'ionic-angular';
import { NgForm } from '@angular/forms';
import { UserDetails } from '../../interface';
import { ShareService } from '../../service';
import { BaseUrl } from '../../global';
import { LoginPage } from '../login/login';

@Component({
  selector: 'page-register',
  templateUrl: 'register.html',
})
export class RegisterPage {

  formValues: UserDetails = <UserDetails>{};
  loaderObject: any;
  serverOTP: string = "";
  serverOTPNumber: string = "";
  OTPPopupObject: any;

  constructor(private navCtrl: NavController,
    private navParams: NavParams,
    private shareService: ShareService,
    private alertCtrl: AlertController) {    
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad RegisterPage');
  }

  doSignup(form: NgForm) {
    try {
      this.formValues.Name = form.value.name;
      this.formValues.Gender = form.value.gender;
      this.formValues.Email = form.value.email;
      this.formValues.Mobile = form.value.mobile;
      this.formValues.Password = form.value.password;      
      this.formValues.Address = {
        flatNo: form.value.flatNo,
        buildName: form.value.buildName,
        s1Address: form.value.streetAddress1,
        s2Address: form.value.streetAddress2,
        zipCode: form.value.zipCode
      };
      // mobile validation
      let regExp = /^[0-9]{10,12}$/;

      if (!regExp.test(this.formValues.Mobile)) {
        this.shareService.ShowAlert("Please Enter Valid Mobile Number");
        return;
      }

      // loader
      this.loaderObject = this.shareService.GetCustomLoader();
      this.loaderObject.present();

      // Send data to server for validation. validation will be based on Email and mobile
      this.shareService.getPostData(BaseUrl.REGISTERURL, this.formValues, null)
        .then(data => {
          this.ProcessSignupResponse(data);
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

  ProcessSignupResponse(data) {
    let dResp = JSON.parse(data._body);
    let dndResponse = (dResp.apiResponse != undefined)? JSON.parse(dResp.apiResponse) : "";
    
    if (dResp.status == 'success') {
      // if reason is OTPWINDOW then show OTP window
      if (dResp.reason == BaseUrl.OTPTEXT) {
        this.serverOTP = dResp.OTP;
        this.serverOTPNumber = dResp.OTPNumber;

        if (dndResponse.warnings != undefined && dndResponse.warnings.length > 0) {
          // DND warning or any other.
          this.shareService.ShowAlert(dndResponse.warnings[0].message + ", But Your account is created");
        }
        else {
          // if success then page will be redirected to login page
          this.OTPPopupObject = this.shareService.ShowOTPWindow(this.serverOTP, this.serverOTPNumber, () => { this.navigateToLoginPage(); });
          this.OTPPopupObject.present(); 
        }             
      }
      else
        this.shareService.ShowAlert(dResp.reason);
    }      
    else
      this.shareService.ShowAlert(dResp.reason);
  }

  navigateToLoginPage() {
    try {
      // navigate to Login page
      this.navCtrl.setRoot(LoginPage);
    }
    catch (ex) {
      //alert(ex.message);
    }    
  }
}
