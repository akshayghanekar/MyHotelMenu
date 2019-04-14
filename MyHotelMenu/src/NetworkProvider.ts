import { Injectable } from '@angular/core';
import { AlertController, Events } from 'ionic-angular';
import { Network } from '@ionic-native/network';

export enum ConnectionStatus {
  Online,
  Offline
}
@Injectable()
export class NetworkProvider {
  previousStatus;

  constructor(public alertCtrl: AlertController,
    public network: Network,
    public eventCtrl: Events) {   

    this.previousStatus = ConnectionStatus.Online;
  }

  public InitializeNetworkEvents(): void {
    this.network.onDisconnect().subscribe(() => {
      //if (this.previousStatus === ConnectionStatus.Online) {
        this.eventCtrl.publish("NetworkOffline");
      //}
      this.previousStatus = ConnectionStatus.Offline;
    });

    this.network.onConnect().subscribe(() => {
      //if (this.previousStatus === ConnectionStatus.Offline) {
        this.eventCtrl.publish("NetworkOnline");
      //}
      this.previousStatus = ConnectionStatus.Online;
    });
  }
}
