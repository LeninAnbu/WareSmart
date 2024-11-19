



import 'dart:convert';
import 'dart:developer';

class GetbinserialModel{
Binserialheader? inwardDetailheader;
String? message;
  int? stcode;
  String? exception;
  GetbinserialModel({
    required this.inwardDetailheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory GetbinserialModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return GetbinserialModel(
  inwardDetailheader: Binserialheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return GetbinserialModel(
  inwardDetailheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory GetbinserialModel.issues(Map<String,dynamic> jsons, int stcode){
 return GetbinserialModel(
  inwardDetailheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory GetbinserialModel.error(String? exception,int stcode){
   return GetbinserialModel(
  inwardDetailheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class Binserialheader{
List<BinserialList>? itemlist;
Binserialheader({
required this.itemlist
});
factory Binserialheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<BinserialList> datalist=list.map((data)=>BinserialList.fromJson(data)).toList();
    return Binserialheader(
      itemlist: datalist
      );
  }else{
     return Binserialheader(
      itemlist: null
      );
  }

}
}
class BinserialList{
 String? ItemCode;
 String? ItemName;
 String? Brand;
 String? Category;
 String? SubCategory;
 String? ManageBy;
 String? Status;
 String? WhsCode;
 String? SerialBatchCode;
 double? SerialBatchQty;
 String? InDate;





 BinserialList({
  required this.Brand,
  required this.Category,
  required this.InDate,
  required this.ItemCode,
  required this.ItemName,
  required this.ManageBy,
  required this.SerialBatchCode,
  required this.SerialBatchQty,
  required this.Status,
  required this.SubCategory,
  required this.WhsCode


 });
 factory BinserialList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return BinserialList(
  Brand: json['Brand']??"", 
  Category: json['Category']??'', 
  InDate: json['InDate']??'', 
  ItemCode: json['ItemCode']??"", 
  ItemName: json['ItemName']??'', 
  ManageBy: json['ManageBy']??'', 
  SerialBatchCode: json['SerialBatchCode']??'', 
  SerialBatchQty: json['SerialBatchQty']??0.0, 
  Status: json['Status']??'', 
  SubCategory: json['SubCategory']??'', 
  WhsCode: json['WhsCode']??''
  );
 }
 
}