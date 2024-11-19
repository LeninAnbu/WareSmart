




import 'dart:convert';
import 'dart:developer';

class BincontentModel{
BincontentModelheader? bincontentheader;
String? message;
  int? stcode;
  String? exception;
  BincontentModel({
    required this.bincontentheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory BincontentModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return BincontentModel(
  bincontentheader: BincontentModelheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return BincontentModel(
  bincontentheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory BincontentModel.issues(Map<String,dynamic> jsons, int stcode){
 return BincontentModel(
  bincontentheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory BincontentModel.error(String? exception,int stcode){
   return BincontentModel(
  bincontentheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class BincontentModelheader{
List<BincontentList>? itemlist;
BincontentModelheader({
required this.itemlist
});
factory BincontentModelheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<BincontentList> datalist=list.map((data)=>BincontentList.fromJson(data)).toList();
    return BincontentModelheader(
      itemlist: datalist
      );
  }else{
     return BincontentModelheader(
      itemlist: null
      );
  }

}
}
class BincontentList{
  String? ItemCode;
  String? ItemName;
  String? Brand;
  String? Category;
  String? SubCategory;
  String? ManageBy;
  String? Status;
  String? WhsCode;
  String? SerialBatchCode;
  String? BinCode;
  double? BinQty;
  String? InDate;
 

 BincontentList({
  required this.BinCode,
  required this.BinQty,
  required this.Brand,
  required this.Category,
  required this.InDate,
  required this.ItemCode,
  required this.ItemName,
  required this.ManageBy,
  required this.SerialBatchCode,
  required this.Status,
  required this.SubCategory,
  required this.WhsCode

 });
 factory BincontentList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return BincontentList(
  BinCode: json['BinCode']??'', 
  BinQty: json['BinQty']??0.0, 
  Brand: json['Brand']??"", 
  Category: json['Category']??"", 
  InDate: json['InDate']??'', 
  ItemCode: json['ItemCode']??"", 
  ItemName: json['ItemName']??'', 
  ManageBy: json['ManageBy']??'', 
  SerialBatchCode: json['SerialBatchCode']??"", 
  Status: json['Status']??"", 
  SubCategory: json['SubCategory']??"", 
  WhsCode: json['WhsCode']??''
  );
 }
 
}