

import 'dart:convert';
import 'dart:developer';

class GetPickupModel{
GetPickupheader? pickupheaderheader;
String? message;
  int? stcode;
  String? exception;
  GetPickupModel({
    required this.pickupheaderheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory GetPickupModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return GetPickupModel(
  pickupheaderheader: GetPickupheader.fromJson(json), 
  stcode: stcode, 
  message: json["respCode"], 
  exception: null
  );
   }else{
   return GetPickupModel(
  pickupheaderheader: null, 
  stcode: stcode, 
  message: json["respCode"], 
  exception: null
  );
   }
   
  }

  factory GetPickupModel.issues(Map<String,dynamic> jsons, int stcode){
 return GetPickupModel(
  pickupheaderheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory GetPickupModel.error(String? exception,int stcode){
   return GetPickupModel(
  pickupheaderheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class GetPickupheader{
List<PickupDetailList>? itemlist;
GetPickupheader({
required this.itemlist
});
factory GetPickupheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<PickupDetailList> datalist=list.map((data)=>PickupDetailList.fromJson(data)).toList();
    return GetPickupheader(
      itemlist: datalist
      );
  }else{
     return GetPickupheader(
      itemlist: null
      );
  }

}
}
class PickupDetailList{
 int? DocEntry;
 int? DocNumber;
 String? OrderNum;
 String? DocDate;
 String? DeliveryDueDate;
 String? CustomerCode;
 String? CustomerName;
 String? CustomerMobile;
 String? Delivery_To;
 String? Del_Address1;
 String? Del_Address2;
 String? Del_Address3;
 String? Del_Area;
 String? Del_City;
 String? Del_District;
 String? Del_State;
 String? Del_Country;
 String? StoreCode;
 String? WhsCode;
 String? OrderStatus;
 String? ItemCode;
 String? ItemName;
 String? Brand;
 String? Category;
 String? SubCategory;
 double? Total_Line_Order_Qty;
 String? QRCode;
 String? Pref_BatchSerial;
 String? IsReserved;
 String? IsPickSlipGenerated;
 String? IsAllocated;
 String? Allocated_TimeStamp;
 String? SerialBatch;
 String? BinCode;
 int? isInvoiced;
 String? InvoiceDate;
 String? InvoiceNo;
 double? InvoiceTotal;
 String? InvoiceURL1;
 int? isDispatched;
 String? DispatchedDateTime;
 String? DispatchNo;
 String? VehicleNo;
 String? DriverName;
 int? isDelivered;
 String? DeliveryNo;
 String? DeliveryDate;
 String? DeliveryURL1;
 String? Delivery_Pic1;
 String? IsDeliveryReturned;
 String? DeliveryReturnedDateTime;
 String? DeliveryReturnReason;



 PickupDetailList({
  required this.Allocated_TimeStamp,
  required this.BinCode,
  required this.Brand,
  required this.Category,
  required this.CustomerCode,
  required this.CustomerMobile,
  required this.CustomerName,
  required this.Del_Address1,
  required this.Del_Address2,
  required this.Del_Address3,
  required this.Del_Area,
  required this.Del_City,
  required this.Del_Country,
  required this.Del_District,
  required this.Del_State,
  required this.DeliveryDate,
  required this.DeliveryDueDate,
  required this.DeliveryNo,
  required this.DeliveryReturnReason,
  required this.DeliveryReturnedDateTime,
  required this.DeliveryURL1,
  required this.Delivery_Pic1,
  required this.Delivery_To,
  required this.DispatchNo,
  required this.DispatchedDateTime,
  required this.DocDate,
  required this.DocEntry,
  required this.DocNumber,
  required this.DriverName,
  required this.InvoiceDate,
  required this.InvoiceNo,
  required this.InvoiceTotal,
  required this.InvoiceURL1,
  required this.IsAllocated,
  required this.IsDeliveryReturned,
  required this.IsPickSlipGenerated,
  required this.IsReserved,
  required this.ItemCode,
  required this.ItemName,
  required this.OrderNum,
  required this.OrderStatus,
  required this.Pref_BatchSerial,
  required this.QRCode,
  required this.SerialBatch,
  required this.StoreCode,
  required this.SubCategory,
  required this.Total_Line_Order_Qty,
  required this.VehicleNo,
  required this.WhsCode,
  required this.isDelivered,
  required this.isDispatched,
  required this.isInvoiced

 });
 factory PickupDetailList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return PickupDetailList(
  Allocated_TimeStamp: json['Allocated_TimeStamp']??'', 
  BinCode: json['BinCode']??'', 
  Brand: json['Brand']??'', 
  Category: json['Category']??'', 
  CustomerCode: json['CustomerCode']??'', 
  CustomerMobile: json['CustomerMobile']??'', 
  CustomerName: json['CustomerName']??'', 
  Del_Address1: json['Del_Address1']??'', 
  Del_Address2: json['Del_Address2']??'', 
  Del_Address3: json['Del_Address3']??"", 
  Del_Area: json['Del_Area']??'', 
  Del_City: json['Del_City']??'', 
  Del_Country: json['Del_Country']??'', 
  Del_District: json['Del_District']??"", 
  Del_State: json['Del_State']??"", 
  DeliveryDate: json['DeliveryDate']??"", 
  DeliveryDueDate: json['DeliveryDueDate']??"", 
  DeliveryNo: json['DeliveryNo']??"", 
  DeliveryReturnReason: json['DeliveryReturnReason']??"", 
  DeliveryReturnedDateTime: json['DeliveryReturnedDateTime']??'', 
  DeliveryURL1: json['DeliveryURL1']??"", 
  Delivery_Pic1: json['Delivery_Pic1']??'', 
  Delivery_To: json['Delivery_To']??"", 
  DispatchNo: json['DispatchNo']??"", 
  DispatchedDateTime: json['DispatchedDateTime']??'', 
  DocDate: json['DocDate']??"", 
  DocEntry: json['DocEntry']??0, 
  DocNumber: json['DocNumber']??0, 
  DriverName: json['DriverName']??'', 
  InvoiceDate: json['InvoiceDate']??'', 
  InvoiceNo: json['InvoiceNo']??'', 
  InvoiceTotal: json['InvoiceTotal']??0.0, 
  InvoiceURL1: json['InvoiceURL1']??'', 
  IsAllocated: json['IsAllocated']??'', 
  IsDeliveryReturned: json['IsDeliveryReturned']??'', 
  IsPickSlipGenerated: json['IsPickSlipGenerated']??'', 
  IsReserved: json['IsReserved']??'', 
  ItemCode: json['ItemCode']??'', 
  ItemName: json['ItemName']??'', 
  OrderNum: json['OrderNum']??"", 
  OrderStatus: json['OrderStatus']??'', 
  Pref_BatchSerial: json['Pref_BatchSerial']??"", 
  QRCode: json['QRCode']??'', 
  SerialBatch: json['SerialBatch']??"", 
  StoreCode: json['StoreCode']??"", 
  SubCategory: json['SubCategory']??'', 
  Total_Line_Order_Qty: json['Total_Line_Order_Qty']??0.0, 
  VehicleNo: json['VehicleNo']??'', 
  WhsCode: json['WhsCode']??'', 
  isDelivered: json['isDelivered']??0, 
  isDispatched: json['isDispatched']??0, 
  isInvoiced: json['isInvoiced']??0
  );
 }
 
}