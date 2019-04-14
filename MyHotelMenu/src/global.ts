import { Component } from '@angular/core';

export class BaseUrl{
  static BASE_API_URL: string = 'https://akshayghanekar.in/WebApi/myhotel/slimAPI/public/api/';
  //static BASE_API_URL: string = 'http://localhost/MyWebApi/public/api/';
  static ALL_REQUEST: string = BaseUrl.BASE_API_URL + 'GetAllItems';
  static LICENSE_CHECK_REQUEST: string = BaseUrl.BASE_API_URL + 'GetLicense';
  static REGISTERURL: string = BaseUrl.BASE_API_URL + 'Register';
  static LOGIN: string = BaseUrl.BASE_API_URL + 'Login';
  static OTP_VALIDATE = BaseUrl.BASE_API_URL + 'ValidateOTP';
  static OTP_GENERATE = BaseUrl.BASE_API_URL + 'GenerateOTP';
  static PLACE_ORDER = BaseUrl.BASE_API_URL + 'PlaceOrder';
  static GET_ALLORDERS = BaseUrl.BASE_API_URL + 'GetOrders';
  static UPDATE_USER_DETAILS = BaseUrl.BASE_API_URL + 'UpdateDetails';

  static APP_NAME: string = 'MyHotel';
  static APP_TOKEN: string = '9738bbd44fc469aa3f61922a5576c31e'
  static TAG_LICENSE: string = 'LICENSE_VERIFY';
  static OTPTEXT: string = "OTPWINDOW";

  static TAG_STORAGE_USER: string = 'USER';
}

