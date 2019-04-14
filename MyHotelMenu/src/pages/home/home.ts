import { Component, OnInit } from '@angular/core';
import { NavController, NavParams } from 'ionic-angular';
import { BaseUrl } from '../../global';
import { ShareService } from '../../service';
import { ItemInterface } from '../../interface';
import { CartPage } from '../cart/cart';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})

export class HomePage implements OnInit {
  
  // declaring variables which can be used in class
  HomePageTitle: string
  arrMenuList: ItemInterface[];
  arrDisplayMenuList: ItemInterface[];
  loaderObject: any;
  FinalCartCount: number = 0;
  FinalCartPrice: any = 0.00;
  cartPage: any = CartPage;  

  ngOnInit(): void {
    console.log('ng init'); 
  }

  ionViewDidLoad() {
    try {
      console.log('ionViewDidload');      
      this.getMenuItems();
      this.FinalCartCount = this.shareService.GetCartFinalItemsCount();
      this.FinalCartPrice = this.shareService.GetCartFinalAmount();
    }
    catch (ex) {

    }
    finally {
      //this.loaderObject.dismiss();
    }
  }

  ionViewWillEnter() {
    console.log('ionViewWillEnter'); 
  }

  ionViewDidEnter() {
    console.log('ionViewDidEnter'); 
  }

  ionViewWillLeave() {
    console.log('ionViewWillLeave'); 
  }

  ionViewDidLeave() {
    console.log('ionViewDidLeave');
  }

  ionViewWillUnload() {
    console.log('ionViewWillUnload');
  }

  // This is like a page gaurd. It will check, Whether An license is present or not.
  // If not present, then it will not allow app to open this page
  ionViewCanEnter() {
    console.log('ionViewCanEnter');
    //return this.shareService.CheckAPILicense();
  }
  // This is like a page guard. Can check whether user can leave this page or not
  ionViewCanLeave(): Promise<any> {
    console.log('ionViewCanLeave');
    return this.shareService.CheckAPILicense();
  }

  // constructor function
  constructor(private navCtrl: NavController,
    private navParams: NavParams,
    private shareService: ShareService) {
    this.HomePageTitle = "foodApp";
    
    // call item request
    //this.getMenuItems();
    console.log('constructor'); 
  }  

  getMenuItems() {

    this.loaderObject = this.shareService.GetCustomLoader();
    this.loaderObject.present();

    // First chck whether data is avail in cache or not
    this.arrMenuList = this.shareService.GetMasterItems();
    this.arrDisplayMenuList = this.arrMenuList;

    // check whether menus are already loaded or not
    if (!(this.arrDisplayMenuList != undefined && this.arrDisplayMenuList.length > 0)) {
      //this.loaderObject = this.shareService.GetCustomLoader();
      //this.loaderObject.present();

      // generate request    
      let _data = {
        AppKey: BaseUrl.APP_TOKEN
      }

      this.shareService.getPostData(BaseUrl.ALL_REQUEST, _data, null)
        .then(data => {
          this.processMenuItemResponse(data);
          this.loaderObject.dismiss();
          // Check API License
          this.shareService.CheckAPILicense();
        })
        .catch(err => {
          this.loaderObject.dismiss();
          // Check API License
          this.shareService.CheckAPILicense();
        });
    }
    else
      this.loaderObject.dismiss(); // dismiss loader object which was invoked in init
  }

  processMenuItemResponse(data: any) {
    let response = JSON.parse(data._body);

    try {
      if (response.status == 'success') {        
        this.shareService.SetMasterItems(response.data);
        this.arrMenuList = this.shareService.GetMasterItems();
        this.arrDisplayMenuList = this.arrMenuList;
      }
    }
    catch (ex) {
      alert(ex)
    }   
  }

  getItems(search) {
    let searchItem = search.target.value;

    if (searchItem != undefined && searchItem.length > 0) {

      this.arrDisplayMenuList = [];

      if (searchItem && searchItem.trim() != '') {
        this.arrDisplayMenuList = this.arrMenuList.filter((item) => {
          return (item.itemName.toLowerCase().indexOf(searchItem.toLowerCase()) > -1);
        });
      }
    }
    else
      this.arrDisplayMenuList = this.arrMenuList;
  }

  addItemTocart(item: ItemInterface) {
    // increment QTY
    item.itemQty += 1;
    this.FinalCartCount += 1;

    let LocalCartPrice : any = parseFloat(this.FinalCartPrice);
    let LocalItemPrice : any = parseFloat(item.itemPrice);

    this.FinalCartPrice = parseFloat(LocalCartPrice + LocalItemPrice).toFixed(2);
    this.shareService.AddToCart(item);

    // Update in Service as well for caching purpose
    this.shareService.SetCartFinalItemsCount(this.FinalCartCount);
    this.shareService.SetCartFinalAmount(this.FinalCartPrice);
  }

  removeItemFromCart(item: ItemInterface) {
    item.itemQty -= 1;
    this.FinalCartCount -= 1;

    let LocalCartPrice1: any = parseFloat(this.FinalCartPrice);
    let LocalItemPrice1: any = parseFloat(item.itemPrice);

    this.FinalCartPrice = parseFloat(LocalCartPrice1 - LocalItemPrice1).toFixed(2);
    this.shareService.RemoveFromCart(item);

    // Update in Service as well for caching purpose
    this.shareService.SetCartFinalItemsCount(this.FinalCartCount);
    this.shareService.SetCartFinalAmount(this.FinalCartPrice);
  }

  CheckViewCartFooter(): number {
    return this.shareService.GetItemCartCount();
  }

  navigateToCartPage() {
    if (this.shareService.GetItemCartCount() > 0)
      this.navCtrl.push(this.cartPage, { cartPrice: this.FinalCartPrice, callback: this.CallbackOnCartPageClose });
  }

  applyPrecisionToValue(_value: any): any {
    return parseFloat(_value).toFixed(2);
  }

  CallbackOnCartPageClose(res: any) {
    
  }  
}
