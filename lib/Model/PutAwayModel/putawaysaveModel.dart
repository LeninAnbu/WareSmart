
class PutawaysavePostModel{
Inwardsaveheader? inwardsaveheader;
String? message;
  int? stcode;
  String? exception;
  PutawaysavePostModel({
    required this.inwardsaveheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory PutawaysavePostModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return PutawaysavePostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: json["respCode"], 
  exception: json["respDesc"]
  );
   }else{
   return PutawaysavePostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory PutawaysavePostModel.issues(Map<String,dynamic> jsons, int stcode){
 return PutawaysavePostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory PutawaysavePostModel.error(String? exception,int stcode){
   return PutawaysavePostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class Inwardsaveheader{

}