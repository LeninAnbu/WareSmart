

import 'dart:convert';
import 'dart:developer';

class GetPutawayModel{
Putawayheader? putawayheader;
String? message;
  int? stcode;
  String? exception;
  GetPutawayModel({
    required this.putawayheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory GetPutawayModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return GetPutawayModel(
  putawayheader: Putawayheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return GetPutawayModel(
  putawayheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory GetPutawayModel.issues(Map<String,dynamic> jsons, int stcode){
 return GetPutawayModel(
  putawayheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory GetPutawayModel.error(String? exception,int stcode){
   return GetPutawayModel(
  putawayheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class Putawayheader{
List<putawayDetList>? putawaylist;
Putawayheader({
required this.putawaylist
});
factory Putawayheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<putawayDetList> datalist=list.map((data)=>putawayDetList.fromJson(data)).toList();
    return Putawayheader(
      putawaylist: datalist
      );
  }else{
     return Putawayheader(
      putawaylist: null
      );
  }

}
}
class putawayDetList{
  int? ID;
 int? DocEntry;
 int? DocNum;
 int? Item_LineNum;
 int? SerialBatch_LineNum;
 int? AutoID;
 String? InwardType;
 String? SupplierCode;
 String? SupplierName;
 String? WhsCode;
 String? ItemCode;
 String? ItemName;
 double? Unit_Quantity;
 String? SerialBatchCode;
double? SerialBatchQty;
double? Putaway_Qty;
double? Open_Putaway;
String? ManageBy;
bool? isselected;
bool? isdone;
String? localbincode;
String? DocDate;
String? Pref_Bin;
String? BinCode;
double? BinQty;
String? TagText;
 putawayDetList({
  required this.ID,
  required this.BinCode,
  required this.BinQty,
  required this.TagText,
  required this.Pref_Bin,
  required this.DocDate,
  required this.Item_LineNum,
  required this.SerialBatch_LineNum,
  required this.isselected,
  required this.isdone,
  required this.AutoID,
  required this.DocEntry,
  required this.DocNum,
  required this.InwardType,
  required this.ItemCode,
  required this.ItemName,
  required this.ManageBy,
  required this.Open_Putaway,
  required this.Putaway_Qty,
  required this.SerialBatchCode,
  required this.SerialBatchQty,
  required this.SupplierCode,
  required this.SupplierName,
  required this.Unit_Quantity,
  required this.WhsCode,
  required this.localbincode
 

 });
 factory putawayDetList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return putawayDetList(
  ID: null,
  TagText: json['TagText']??"",
  BinQty: json['BinQty']??0.0,
  BinCode:json['BinCode']??"",
  Pref_Bin:json['Pref_Bin']??"",
  SerialBatch_LineNum: json['SerialBatch_LineNum']??0,
  Item_LineNum:json['Item_LineNum']??0 ,
  DocDate: json['DocDate']??'',
  localbincode:'',
  AutoID: json['AutoID']??0, 
  DocEntry: json['DocEntry']??0, 
  DocNum: json['DocNum']??0, 
  InwardType: json['Trans_Type']??'', 
  ItemCode: json['ItemCode']??'', 
  ItemName: json['ItemName']??'', 
  ManageBy: json['ManageBy']??'', 
  Open_Putaway: json['Open_Putaway']??0.0, 
  Putaway_Qty: json['Putaway_Qty']??0.0, 
  SerialBatchCode: json['SerialBatchCode']??'', 
  SerialBatchQty: json['SerialBatchQty']??0.0, 
  SupplierCode: json['SupplierCode']??'', 
  SupplierName: json['SupplierName']??'', 
  Unit_Quantity: json['Unit_Quantity']??0.0, 
  WhsCode: json['WhsCode']??"",
  isselected:false,
  isdone:false
  );
 }
 
}