


import 'dart:convert';
import 'dart:developer';

class DesoopenModel{
Desopenheader? desopenheader;
String? message;
  int? stcode;
  String? exception;
  DesoopenModel({
    required this.desopenheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory DesoopenModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return DesoopenModel(
  desopenheader: Desopenheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return DesoopenModel(
  desopenheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory DesoopenModel.issues(Map<String,dynamic> jsons, int stcode){
 return DesoopenModel(
  desopenheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory DesoopenModel.error(String? exception,int stcode){
   return DesoopenModel(
  desopenheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class Desopenheader{
List<DesOPENList>? itemlist;
Desopenheader({
required this.itemlist
});
factory Desopenheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<DesOPENList> datalist=list.map((data)=>DesOPENList.fromJson(data)).toList();
    return Desopenheader(
      itemlist: datalist
      );
  }else{
     return Desopenheader(
      itemlist: null
      );
  }

}
}
class DesOPENList{
 int? DocEntry;
 int? DocNumber;
 String? DocDate;
 String? RouteCode;
 String? DriverName;
 String? DriverContact;
 String? Vehno;
 int? Total_Items;



 DesOPENList({
  required this.DocDate,
  required this.DocEntry,
  required this.DocNumber,
  required this.DriverContact,
  required this.DriverName,
  required this.RouteCode,
  required this.Total_Items,
  required this.Vehno

 });
 factory DesOPENList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return DesOPENList(
  DocDate: json['DocDate']??'', 
  DocEntry: json['DocEntry']??0, 
  DocNumber: json['DocNum']??0, 
  DriverContact: json['DriverContact']??'', 
  DriverName: json['DriverName']??'', 
  RouteCode: json['RouteCode']??'', 
  Total_Items: json['Total_Items']??0, 
  Vehno: json['Vehno']??''
  );
 }
 
}