



import 'dart:convert';
import 'dart:developer';

class DispModel{
Dispheader? dispheader;
String? message;
  int? stcode;
  String? exception;
  DispModel({
    required this.dispheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory DispModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return DispModel(
  dispheader: Dispheader.fromJson(json), 
  stcode: stcode, 
  message: "success", 
  exception: null
  );
   }else{
   return DispModel(
  dispheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory DispModel.issues(Map<String,dynamic> jsons, int stcode){
 return DispModel(
  dispheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory DispModel.error(String? exception,int stcode){
   return DispModel(
  dispheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class Dispheader{
List<DispList>? itemlist;
Dispheader({
required this.itemlist
});
factory Dispheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['data'] !=null){
    var list=json.decode(jsons['data']) as List;
    List<DispList> datalist=list.map((data)=>DispList.fromJson(data)).toList();
    return Dispheader(
      itemlist: datalist
      );
  }else{
     return Dispheader(
      itemlist: null
      );
  }

}
}
class DispList{
 int? DispID;
 String? DispListVal;
 



 DispList({
  required this.DispID,
  required this.DispListVal,
  

 });
 factory DispList.fromJson(Map<String,dynamic> json){
  // log("hgg::"+json["DocEntry"].toString());
return DispList(
  DispID: json['DispID']??0, 
  DispListVal: json['DispListVal']??'', 
  
  );
 }
 
}