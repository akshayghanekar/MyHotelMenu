import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { HomePage } from '../home/home';
import { ShareService } from '../../service';
import { OrdersPage } from '../orders/orders';

@Component({
  selector: 'page-confirm-order',
  templateUrl: 'confirm-order.html',
})
export class ConfirmOrderPage implements OnInit {

  loaderObject: any;
  orderId: string;
  orderInfo: any;
  navPage: any = HomePage;
  
  ngOnInit() {
    this.orderInfo = this.navParams.data;
    this.orderId = this.orderInfo.id;
    this.shareService.ShowAlert(this.orderInfo.reason);
  }

  constructor(public navCtrl: NavController,
    public navParams: NavParams,
    private shareService: ShareService) {
  }

  ionViewDidLoad() {
    //console.log('ionViewDidLoad ConfirmOrderPage');
  }

  ionViewWillUnload() {
    this.shareService.ClearOrderDetails();
    this.navCtrl.setRoot(this.navPage);
  }

  GotoMyOrders() {    
    this.navPage = OrdersPage;
    this.navCtrl.pop();
  }

  GotoHome() {
    this.navPage = HomePage;
    this.navCtrl.pop();
  }
}
