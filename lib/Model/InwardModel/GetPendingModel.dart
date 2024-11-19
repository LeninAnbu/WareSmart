

import 'dart:convert';
import 'dart:developer';

class InwPendingModel{
InwardDetailheader? inwardDetailheader;
String? message;
  int? stcode;
  String? exception;
  InwPendingModel({
    required this.inwardDetailheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory InwPendingModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return InwPendingModel(
  inwardDetailheader: InwardDetailheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return InwPendingModel(
  inwardDetailheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory InwPendingModel.issues(Map<String,dynamic> jsons, int stcode){
 return InwPendingModel(
  inwardDetailheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory InwPendingModel.error(String? exception,int stcode){
   return InwPendingModel(
  inwardDetailheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class InwardDetailheader{
List<InwPendingDetailList>? itemlist;
InwardDetailheader({
required this.itemlist
});
factory InwardDetailheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<InwPendingDetailList> datalist=list.map((data)=>InwPendingDetailList.fromJson(data)).toList();
    return InwardDetailheader(
      itemlist: datalist
      );
  }else{
     return InwardDetailheader(
      itemlist: null
      );
  }

}
}
class InwPendingDetailList{
 int? DocEntry;
 int? DocNum;
 String? InwardType;
 String? PORef;
 String? DocDate;
 String? SupplierCode;
 String? SupplierName;
 String? SupplierMobile;
 String? AlternateMobileNo;
 String? ContactName;
 String? SupplierEmail;
 String? CompanyName;
 String? GSTNo;
 String? TransRef;
 String? InwardDocDate;
 String? Bil_Address1;
 String? Bil_Address2;
 String? Bil_Address3;
 String? Bil_Area;
 String? Bil_City;
 String? Bil_District;
 String? Bil_State;
 String? Bil_Country;
 String? Bil_Pincode;
 String? Del_Address1;
 String? Del_Address2;
 String? Del_Address3;
 String? Del_Area;
 String? Del_City;
 String? Del_District;
 String? Del_State;
 String? Del_Country;
 String? Del_Pincode;
 String? WhsCode;
 String? OrderStatus;
 double? GrossTotal;
 double? Discount;
 double? SubTotal;
 double? TaxAmount;
 double? RoundOff;
 double? DocTotal;
 String? AttachURL1;
 String? AttachURL2;
 String? AttachURL3;
 String? AttachURL4;
 String? AttachURL5;
 String? OrderNote;
 int? isCancelled;
 String? CancelledDate;
 String? CancelledReason;
 String? CancelledRemarks;
 String? BaseDocId;
 String? BaseDocRef;
 String? BaseDocDate;
 int? CreatedBy;
 String? CreatedDatetime;
 int? UpdatedBy;
 String? UpdatedDatetime;
 String? traceid;
 String? WhsName;
 InwPendingDetailList({
  required this.AlternateMobileNo,
  required this.AttachURL1,
  required this.AttachURL2,
  required this.AttachURL3,
  required this.AttachURL4,
  required this.AttachURL5,
  required this.BaseDocDate,
  required this.BaseDocId,
  required this.BaseDocRef,
  required this.Bil_Address1,
  required this.Bil_Address2,
  required this.Bil_Address3,
  required this.Bil_Area,
  required this.Bil_City,
  required this.Bil_Country,
  required this.Bil_District,
  required this.Bil_Pincode,
  required this.Bil_State,
  required this.CancelledDate,
  required this.CancelledReason,
  required this.CancelledRemarks,
  required this.CompanyName,
  required this.ContactName,
  required this.CreatedBy,
  required this.CreatedDatetime,
  required this.Del_Address1,
  required this.Del_Address2,
  required this.Del_Address3,
  required this.Del_Area,
  required this.Del_City,
  required this.Del_Country,
  required this.Del_District,
  required this.Del_Pincode,
  required this.Del_State,
  required this.Discount,
  required this.DocDate,
  required this.DocEntry,
  required this.DocNum,
  required this.DocTotal,
  required this.GSTNo,
  required this.GrossTotal,
  required this.InwardDocDate,
  required this.InwardType,
  required this.OrderNote,
  required this.OrderStatus,
  required this.PORef,
  required this.RoundOff,
  required this.SubTotal,
  required this.SupplierCode,
  required this.SupplierEmail,
  required this.SupplierMobile,
  required this.SupplierName,
  required this.TaxAmount,
  required this.TransRef,
  required this.UpdatedBy,
  required this.UpdatedDatetime,
  required this.WhsCode,
  required this.WhsName,
  required this.isCancelled,
  required this.traceid

 });
 factory InwPendingDetailList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return InwPendingDetailList(
  AlternateMobileNo: json['AlternateMobileNo']??'', 
  AttachURL1: json['AttachURL1']??'', 
  AttachURL2: json['AttachURL2']??'', 
  AttachURL3: json['AttachURL3']??'', 
  AttachURL4: json['AttachURL4']??'', 
  AttachURL5: json['AttachURL5']??'', 
  BaseDocDate: json['BaseDocDate']??'', 
  BaseDocId: json['BaseDocId']??'', 
  BaseDocRef: json['BaseDocRef']??'', 
  Bil_Address1: json['Bil_Address1']??'', 
  Bil_Address2: json['Bil_Address2']??'', 
  Bil_Address3: json['Bil_Address3']??'', 
  Bil_Area: json['Bil_Area']??'', 
  Bil_City: json['Bil_City']??'', 
  Bil_Country: json['Bil_Country']??'', 
  Bil_District: json['Bil_District']??'', 
  Bil_Pincode: json['Bil_Pincode']??'', 
  Bil_State: json['Bil_State']??'', 
  CancelledDate: json['CancelledDate']??'', 
  CancelledReason: json['CancelledReason']??'', 
  CancelledRemarks: json['CancelledRemarks']??'', 
  CompanyName: json['CompanyName']??'', 
  ContactName: json['ContactName']??'', 
  CreatedBy: json['CreatedBy']??0, 
  CreatedDatetime: json['CreatedDatetime']??'', 
  Del_Address1: json['Del_Address1']??'', 
  Del_Address2: json['Del_Address2']??'', 
  Del_Address3: json['Del_Address3']??'', 
  Del_Area: json['Del_Area']??'', 
  Del_City: json['Del_City']??'', 
  Del_Country: json['Del_Country']??'', 
  Del_District: json['Del_District']??'', 
  Del_Pincode: json['Del_Pincode']??'', 
  Del_State: json['Del_State']??'', 
  Discount: json['Discount']??0.0, 
  DocDate: json['DocDate']??'', 
  DocEntry: json['DocEntry']??0, 
  DocNum: json['DocNum']??0, 
  DocTotal: json['DocTotal']??0.0, 
  GSTNo: json['GSTNo']??'', 
  GrossTotal: json['GrossTotal']??0.0, 
  InwardDocDate: json['InwardDocDate']??'', 
  InwardType: json['InwardType']??'', 
  OrderNote: json['OrderNote']??'', 
  OrderStatus: json['OrderStatus']??'', 
  PORef: json['PORef']??'', 
  RoundOff: json['RoundOff']??0.0, 
  SubTotal: json['SubTotal']??0.0, 
  SupplierCode: json['SupplierCode']??'', 
  SupplierEmail: json['SupplierEmail']??'', 
  SupplierMobile: json['SupplierMobile']??'', 
  SupplierName: json['SupplierName']??'', 
  TaxAmount: json['TaxAmount']??0.0, 
  TransRef: json['TransRef']??'', 
  UpdatedBy: json['UpdatedBy']??0, 
  UpdatedDatetime: json['UpdatedDatetime']??'', 
  WhsCode: json['WhsCode']??'', 
  WhsName: json['WhsName']??'', 
  isCancelled: json['isCancelled']??0, 
  traceid: json['traceid']??''
  );
 }
 
}