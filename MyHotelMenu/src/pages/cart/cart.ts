import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams, Navbar, ViewController } from 'ionic-angular';
import { ShareService } from '../../service'
import { ItemInterface } from '../../interface'
import { AlertController } from "ionic-angular";
import { RegisterPage } from '../register/register';
import { LoginPage } from '../login/login';
import { UserDetails } from '../../interface';
import { BaseUrl } from '../../global';
import { ConfirmOrderPage } from '../confirm-order/confirm-order';
import { ProfilePage } from '../profile/profile';

@IonicPage()
@Component({
  selector: 'page-cart',
  templateUrl: 'cart.html',
})
export class CartPage implements OnInit {

  FinalCartItems: ItemInterface[] = [];
  FinalCartPrice: any = 0;
  userObj: UserDetails = <UserDetails>{};
  loaderObject: any;
  profilePage: any = ProfilePage;

  constructor(private navParams: NavParams,
    private shareService: ShareService,
    private alertCtrl: AlertController,
    private navCtrl: NavController,
    public viewCtrl: ViewController) {
    console.log('constructor');        
  }

  ngOnInit() {    
    console.log('Init');
    //this.viewCtrl.showBackButton(false);
    this.FinalCartItems = this.shareService.GetCartItems();
    this.FinalCartPrice = this.navParams.get('cartPrice');    
  }

  ionViewWillEnter() {
    //console.log('ionViewWillEnter');
    let storageObj = this.shareService.GetLocalStorage(BaseUrl.TAG_STORAGE_USER);
    if (storageObj != undefined)
      this.userObj = JSON.parse(storageObj);
  }

  ionViewDidLoad() {
    //console.log('view load');    
  }

  PlaceAnOrder() {
    if (!this.shareService.CheckIfUserIsLoggedInOrNot()) {
      // Alert for login and register
      const alert = this.alertCtrl.create({
        title: 'Login Required',        
        message: 'In order to place an order, You need to login/register first',
        buttons: [
          {
            text: 'Login',
            handler: () => {
              //this.quotesService.addQuoteToFavorites(selectedQuote);
              this.navCtrl.setRoot(LoginPage);
            }
          },
          {
            text: 'Register',            
            handler: () => {
              //console.log('Cancelled!');
              this.navCtrl.setRoot(RegisterPage);
            }
          }          
        ]
      });

      alert.present();
    }
    else {

      this.loaderObject = this.shareService.GetCustomLoader();
      this.loaderObject.present();

      // send Place order request to restaurant.
      // Add entry in DB as well
      let userObject: UserDetails = this.shareService.GetUserDetailsJSON();
      let _data = {        
        orderDetails: JSON.stringify(this.shareService.GetCartItems()),
        finalAmount: this.shareService.GetCartFinalAmount(),
        clientId: userObject.Id
      }

      // Send data to server
      this.shareService.getPostData(BaseUrl.PLACE_ORDER, _data, null)
        .then(data => {
          this.ProcessPlaceOrderResponse(data);
          this.loaderObject.dismiss();
        })
        .catch(err => {
          this.loaderObject.dismiss();
        });      
    }
  }  

  ProcessPlaceOrderResponse(data) {
    let dResp = JSON.parse(data._body);

    if (dResp.status == 'success') {
      //this.navCtrl.pop();
      this.navCtrl.push(ConfirmOrderPage, dResp);
    }
    else
      this.shareService.ShowAlert(dResp.reason);
  }

  // clear out data
  ionViewWillLeave() {
    //this.CallBack('test');
    //this.FinalCartItems = [];
    //this.FinalCartPrice = 0;
  }

  ionViewDidEnter() {
    //this.navBar.backButtonClick = () => {
    //  this.navCtrl.pop({ animate: false });
    //};
  }
}
