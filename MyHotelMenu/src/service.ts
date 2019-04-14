import { Injectable } from '@angular/core';
import { LoadingController, AlertController, ToastController, NavController } from 'ionic-angular';
import { Http, Headers, RequestOptions } from '@angular/http';
import { Observable } from 'rxjs/Observable'
import { BaseUrl } from '../src/global'
import { ItemInterface, UserDetails } from '../src/interface'

@Injectable()
export class ShareService {
  
  BadgeCount: number = 0;
  public APIAuthentication: boolean = false;
  private arrCartItems: ItemInterface[] = [];
  private userDetails: UserDetails;  
  // To persist Items on page change
  private MasterItems: ItemInterface[] = [];

  CartFinalAmount: any = 0.00;
  CartFinalItemsCount: any = 0;

  // Loader object for this class
  loaderObject: any;
  
  // Inject all required modules in constructor
  constructor(private http: Http,
    private alertCtrl: AlertController,
    private loadingCtrl: LoadingController,    
    private toastCtrl: ToastController) {    
    
  }  

  // this method will return an object of Custome loader.
  // can be called from any page. No need to write same code on each and every page
  GetCustomLoader(): any {
    return this.loadingCtrl.create({
      content: "Please wait...",
      dismissOnPageChange: true
      //duration: 3000
    });
  }

  // this method will return an object of Alert.
  // can be called from any page. No need to write same code on each and every page
  ShowAlert(_message: string) {
    this.alertCtrl.create({      
      subTitle: _message,
      buttons: ['Ok']
    }).present();    
  }
  
  // this method will be used to get post data from server. Generice method  
  // method will return promise, need to handle with then and catch in each page
  getPostData(_url: string, _params: any, _callback: any){
    var headers = new Headers();    
    headers.append('content-type', 'application/json');
    var options = new RequestOptions({ headers: headers });

    return this.http.post(_url, _params, options).toPromise();      
  }

  // Method will be used to check license when loading home page.
  // this is handled in such a way, that it will check license first time only
  CheckAPILicense(): Promise<any> {
    // If license is already checked, Then dont check again.It is slowing down while navigating to home page
    if (!this.APIAuthentication) {
      return new Promise((resolve, reject) => {

        this.getPostData(BaseUrl.LICENSE_CHECK_REQUEST, {
          "AppName": BaseUrl.APP_NAME,
          "AppToken": BaseUrl.APP_TOKEN
        }, null)
          .then((data: any) => {
            let res = JSON.parse(data._body);
            if (res.status == 'success') {
              this.APIAuthentication = true;
              resolve(true);
            }
            else if (res.status == 'fail') {
              this.APIAuthentication = false;
              this.ShowAlert(res.reason);
              resolve(false);
            }
          })
          .catch((err) => {
            //this.ShowAlert();
            resolve(false);
          });
      });      
    }    
  }

  // this method will show Toast message.
  // can be called from any page. No need to write same code on each and every page
  ShowToastMessage(_message: string) {
    const toast = this.toastCtrl.create({
      message: _message,
      duration: 3000
    });
    toast.present();
  }

  // This method will be used to Get All items that are added to cart
  GetCartItems(): Array<ItemInterface> {
    // Splice used, so that not original but copy of array is sent back
    return this.arrCartItems.slice();
  }

  // This method will be use to add an item into cart
  AddToCart(item: ItemInterface) {   
    
    // check whether item present in cart or not
    var position = this.arrCartItems.findIndex((itmEl: ItemInterface) => {
      return itmEl.id == item.id
    });
    // If not found then insert into array
    if (position < 0) {      
      this.arrCartItems.push(item);
    }
    else {
      // position found. Increment Qty count
      this.arrCartItems[position].itemQty = item.itemQty;
    }
  }

  // This method will be used to remove an item from a cart
  RemoveFromCart(item: ItemInterface) {
    // check whether item present in cart or not
    var position = this.arrCartItems.findIndex((itmEl: ItemInterface) => {
      return itmEl.id == item.id;
    });

    // check for qty. if QTY is 0 then remove from array
    if (item.itemQty == 0) {
      this.arrCartItems.splice(position, 1);
    }
  }

  // This method will return Item count which are added into cart
  GetItemCartCount(): number {
    return this.arrCartItems.length;
  }

  // This method will return true or false whether user is logged in or not
  CheckIfUserIsLoggedInOrNot(): boolean {
    let user = this.GetLocalStorage(BaseUrl.TAG_STORAGE_USER);
    let bLoggedIn = false;

    if (user == undefined)
      bLoggedIn = false;
    else
      bLoggedIn = true;

    return bLoggedIn;
  }

  // this method will be used to store in local storage
  // key and value will be passed. If json object, then it should be in string format
  SetLocalStorage(key: string, value: any) {
    localStorage.setItem(key, value);
  }

  // Will be used to get from Loca Storage.
  // Key will be passed
  GetLocalStorage(key: string): any {
    return localStorage.getItem(key);
  }

  // Will be used to remove from Loca Storage.
  // Key will be passed
  RemoveLocalStorage(key: string): any {
    return localStorage.removeItem(key);
  }

  GetUserDetailsJSON(): UserDetails {
    let userObject: UserDetails = <UserDetails>{};
    let storageObject = localStorage.getItem(BaseUrl.TAG_STORAGE_USER);

    if (storageObject != undefined)
      userObject = JSON.parse(storageObject);

    return userObject;
  }
  // In order to achieve caching, Items will be stored here. So no need to get a server call on 2nd visit of home page
  // this will not be applicable once app is closed
  GetMasterItems(): ItemInterface[] {
    return this.MasterItems;
  }

  // To store 1st time loaded Menu Items in cache
  SetMasterItems(items: ItemInterface[]) {
    this.MasterItems = items;
  }

  // to get Final amount of items which are added into cart
  GetCartFinalAmount(): any {
    return this.CartFinalAmount;
  }
  // Set Final Amount of items
  SetCartFinalAmount(value) {
    this.CartFinalAmount = value;
  }
  // Get Final count of total items which are present in cart (Including quanity)
  GetCartFinalItemsCount(): number {
    return this.CartFinalItemsCount;
  }
  // Set Final Count of an items which are present in cart.(including quantity)
  SetCartFinalItemsCount(value) {
    this.CartFinalItemsCount = value;
  }

  // Order is placed. After that this method will be called.
  // This method will clear all service level order variables.
  ClearOrderDetails() {
    this.arrCartItems = [];
    this.MasterItems = [];
    this.CartFinalAmount = 0.00;
    this.CartFinalItemsCount = 0;
  }
  // This method will create a complete address from JSON object to string
  GetCompleteAddressfromJSONObject(_obj: UserDetails): string {
    let addrs = _obj.Address.flatNo + " " + _obj.Address.buildName + " " + _obj.Address.s1Address + " " + _obj.Address.s2Address + " " + _obj.Address.zipCode;
    return addrs;
  }

  // This function will show, OTP window. Which can be used from Register/Login page
  ShowOTPWindow(_serverOTP, _serverMobile, _callbackMethod): any {
    let alert = this.alertCtrl.create({
      title: 'OTP',
      message: 'Please enter OTP which was sent to your mobile number.',
      enableBackdropDismiss: false,
      inputs: [
        {
          name: 'userOTP',
          placeholder: 'OTP'
        }
      ],
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Submit',
          handler: data => {
            if (this.checkOTPValidation(data.userOTP, _serverOTP, _serverMobile, _callbackMethod)) {
              return true;
            } else {
              // invalid login
              return false;
            }
          }
        }
      ]
    });
    
    return alert;
  }
  // call back for OTP
  checkOTPValidation(_userOTP, _serverOTP, _serverMobile, _callbackMethod): boolean {
    var resp = false;

    if (_serverOTP == _userOTP) {
      resp = true;
      this.loaderObject = this.GetCustomLoader();
      this.loaderObject.present();
      // Send request to update on server, that this mobile number is validated
      // generate request    
      let _data = {
        number: _serverMobile,
        status: 1
      }
      this.getPostData(BaseUrl.OTP_VALIDATE, _data, _callbackMethod)
        .then((data: any) => {
          let resOTP = JSON.parse(data._body);
          this.loaderObject.dismiss();
          this.ShowToastMessage(resOTP.reason);
          _callbackMethod();
        })
        .catch(err => {
          this.loaderObject.dismiss();
        });
    }
    else {
      this.ShowToastMessage("Please Enter Valid OTP");
      resp = false;
    }
    return resp;
  }  
}
