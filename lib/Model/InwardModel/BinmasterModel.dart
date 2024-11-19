

import 'dart:convert';
import 'dart:developer';

class BinMasterModel{
BinDetailheader? binDetailheader;
String? message;
  int? stcode;
  String? exception;
  BinMasterModel({
    required this.binDetailheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory BinMasterModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return BinMasterModel(
  binDetailheader: BinDetailheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return BinMasterModel(
  binDetailheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory BinMasterModel.issues(Map<String,dynamic> jsons, int stcode){
 return BinMasterModel(
  binDetailheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory BinMasterModel.error(String? exception,int stcode){
   return BinMasterModel(
  binDetailheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class BinDetailheader{
List<BinDetaildetlist>? itemlist;
BinDetailheader({
required this.itemlist
});
factory BinDetailheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<BinDetaildetlist> datalist=list.map((data)=>BinDetaildetlist.fromJson(data)).toList();
    return BinDetailheader(
      itemlist: datalist
      );
  }else{
     return BinDetailheader(
      itemlist: null
      );
  }

}
}
class BinDetaildetlist{
 int? DocEntry;
 String? BinCode;
 String? BarCode;
 String? WhsCode;
 String? AreaCode;
 String? ZoneCode;
 String? RackCode;
 double? Volume;
 double? Capacity;
 String? CapacityUoM;
 double? Length;
 double? Width;
 double? Height;
 int? CreatedBy;
 String? CreatedOn;
 int? UpdatedBy;
 String? UpdatedOn;
 int? Status;
 String? WhsName;
 String? traceid;



 
 BinDetaildetlist({
  required this.WhsName,
  required this.Status,
  required this.AreaCode,
  required this.BarCode,
  required this.BinCode,
  required this.Capacity,
  required this.CapacityUoM,
  required this.CreatedBy,
  required this.CreatedOn,
  required this.DocEntry,
  required this.Height,
  required this.Length,
  required this.RackCode,
  required this.UpdatedBy,
  required this.UpdatedOn,
  required this.Volume,
  required this.WhsCode,
  required this.Width,
  required this.ZoneCode,
  required this.traceid

 });
 factory BinDetaildetlist.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return BinDetaildetlist(
  WhsName:json['WhsName']??'',
  Status: json['Status']??0,
  AreaCode: json['AreaCode']??'', 
  BarCode: json['BarCode']??'', 
  BinCode: json['BinCode']??'', 
  Capacity: json['Capacity']??0.0, 
  CapacityUoM: json['CapacityUoM']??'', 
  CreatedBy: json['CreatedBy']??0, 
  CreatedOn: json['CreatedOn']??'', 
  DocEntry: json['DocEntry']??0, 
  Height: json['Height']??0.0, 
  Length: json['Length']??0.0, 
  RackCode: json['RackCode']??'', 
  UpdatedBy: json['UpdatedBy']??0, 
  UpdatedOn: json['UpdatedOn']??'', 
  Volume: json['Volume']??0.0, 
  WhsCode: json['WhsCode']??'', 
  Width: json['Width']??0.0, 
  ZoneCode: json['ZoneCode']??'', 
  traceid: json['traceid']??''
  );
 }
 
}