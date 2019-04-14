import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { BaseUrl } from '../../global';
import { ShareService } from '../../service';
import { ItemInterface } from '../../interface';

@Component({
  selector: 'page-orders',
  templateUrl: 'orders.html',
})
export class OrdersPage {

  loaderObject: any;
  OrdersInfo: any;

  constructor(public navCtrl: NavController,
    public navParams: NavParams,
    private shareService: ShareService) {
  }

  ionViewDidLoad() {
    //console.log('ionViewDidLoad OrdersPage');
    this.getAllOrders();
  }

  getAllOrders() {
    // get client info first
    let clientObj = this.shareService.GetUserDetailsJSON();

    // create request whih will get data from server.
    let _data = {
      clientId: clientObj.Id
    }

    this.loaderObject = this.shareService.GetCustomLoader();
    this.loaderObject.present();

    // make a server call
    this.shareService.getPostData(BaseUrl.GET_ALLORDERS, _data, null)
      .then(data => {
        this.processAllOrders(data);
        this.loaderObject.dismiss();
      })
      .catch(err => {
        this.loaderObject.dismiss();
      });
  }

  processAllOrders(data) {
    let dResp = JSON.parse(data._body);

    //this.loaderObject = this.shareService.GetCustomLoader();
    //this.loaderObject.present();

    if (dResp.status == 'success') {
      // loop through object and use it in format which we require to display on UI
      this.OrdersInfo = [];

      if (dResp.orders != undefined && dResp.orders.length > 0) {
        for (var i = 0; i < dResp.orders.length; i++) {
          let UiObj = {
            orderDate: dResp.orders[i].date,
            finalAmount: dResp.orders[i].collection.finalAmount,
            itemArray: JSON.parse(dResp.orders[i].collection.Items),
            orderNumber: dResp.orders[i].id
          }
          // Insert object to display on UI
          this.OrdersInfo.push(UiObj);
        }
      }
    }
    else
      this.shareService.ShowAlert(dResp.reason);

    //this.loaderObject.dismiss();
  }

}
