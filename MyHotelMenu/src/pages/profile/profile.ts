import { Component, OnInit } from '@angular/core';
import { NgSwitch, NgSwitchCase, NgSwitchDefault } from '@angular/common'
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { ShareService } from '../../service'
import { AlertController } from "ionic-angular";
import { LoginPage } from '../login/login';
import { UserDetails, Address } from '../../interface';
import { BaseUrl } from '../../global';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'page-profile',
  templateUrl: 'profile.html',
})
export class ProfilePage implements OnInit  {

  userObject: UserDetails;
  Profile: string = "password";
  userAddress: Address = <Address>{};
  loaderObject: any;
  userPassword: any = {
    pwd: '',
    cPwd : ''
  };
  disablePwd: boolean = false;

  ngOnInit(): void {
    // get user object
    let storageObject = this.shareService.GetUserDetailsJSON();

    if (storageObject != undefined) {
      this.userObject = storageObject;
      this.userAddress.buildName = this.userObject.Address.buildName;
      this.userAddress.flatNo = this.userObject.Address.flatNo;
      this.userAddress.s1Address = this.userObject.Address.s1Address;
      this.userAddress.s2Address = this.userObject.Address.s2Address;
      this.userAddress.zipCode = this.userObject.Address.zipCode;
    }

    // Profile can be access from cart page as well. So in that case password should be disabled
    let isPwdTabHide = this.navParams.get("pwdHide");

    if (isPwdTabHide != undefined && isPwdTabHide) {
      this.Profile = "address";
      this.disablePwd = true;
    }
    else {
      this.Profile = "password";
      this.disablePwd = false;
    }
  }

  constructor(public navCtrl: NavController,
    public navParams: NavParams,
    private shareService: ShareService) {
  }

  ionViewDidLoad() {
    //console.log('ionViewDidLoad ProfilePage');
  }

  updateAddress(form: NgForm) {
    // make a request to server to update address.
    let _data = {
      clientId: this.userObject.Id,
      address: this.userAddress,
      updateId : 'address'
    }

    this.loaderObject = this.shareService.GetCustomLoader();
    this.loaderObject.present();

    // send data to server
    this.shareService.getPostData(BaseUrl.UPDATE_USER_DETAILS, _data, null)
      .then(data => {
        this.processUpdatedAddress(data);
        this.loaderObject.dismiss();
      })
      .catch(err => {
        this.loaderObject.dismiss();
      });
  }

  processUpdatedAddress(data) {
    let dResp = JSON.parse(data._body);

    if (dResp.status == 'success') {
      // now, Server will send new details. Remove cached object and save new object
      this.shareService.RemoveLocalStorage(BaseUrl.TAG_STORAGE_USER);
      // Store new details
      this.shareService.SetLocalStorage(BaseUrl.TAG_STORAGE_USER, JSON.stringify(dResp.userObj));
      this.shareService.ShowAlert(dResp.reason);
    }
  }

  updatePassword() {
    if (this.userPassword.pwd != undefined && this.userPassword.pwd.length > 0) {
      // make a request to server to update address.
      let _data = {
        clientId: this.userObject.Id,
        pwd: this.userPassword.pwd,
        updateId: 'password'
      }

      this.loaderObject = this.shareService.GetCustomLoader();
      this.loaderObject.present();

      // send data to server
      this.shareService.getPostData(BaseUrl.UPDATE_USER_DETAILS, _data, null)
        .then(data => {
          this.processUpdatedPassword(data);
          this.loaderObject.dismiss();
        })
        .catch(err => {
          this.loaderObject.dismiss();
        });
    }
    else
      this.shareService.ShowAlert("Please Enter Password");
  }

  processUpdatedPassword(data) {
    let dResp = JSON.parse(data._body);

    if (dResp.status == 'success') {
      // show alert
      this.shareService.ShowAlert(dResp.reason);
      // Clear Password text
      this.userPassword.pwd = "";
      this.userPassword.cPwd = "";
    }
    else
      this.shareService.ShowAlert(dResp.reason);
  }

}
