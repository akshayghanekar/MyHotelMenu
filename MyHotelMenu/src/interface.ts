export interface ItemInterface {
  id: number;
  itemName: string;
  itemDescription: string;
  itemType: string;
  itemQty: number;
  itemPrice: any;
}

export interface UserDetails {
  Id: string;
  Name: string;
  Gender: string;
  Mobile: string;
  Email: string;
  Address: Address;
  Password: string;
  isVerified: string;
}

export interface Address{
  flatNo: string;
  buildName: string;
  s1Address: string;
  s2Address: string;
  zipCode: string;
}
