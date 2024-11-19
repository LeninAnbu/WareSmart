
class BintoBinPostModel{
Inwardsaveheader? inwardsaveheader;
String? message;
  int? stcode;
  String? exception;
  BintoBinPostModel({
    required this.inwardsaveheader,
    required this.stcode,
    required this.message,
    required this.exception

  });

  factory BintoBinPostModel.fromJson(Map<String,dynamic>json,int stcode){
   
   if(json !=null){
    return BintoBinPostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: json["respCode"], 
  exception: json["respDesc"]
  );
   }else{
   return BintoBinPostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: "fail", 
  exception: null
  );
   }
   
  }

  factory BintoBinPostModel.issues(Map<String,dynamic> jsons, int stcode){
 return BintoBinPostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: jsons["respCode"], 
  exception: jsons["respDesc"]
  );
  }
  factory BintoBinPostModel.error(String? exception,int stcode){
   return BintoBinPostModel(
  inwardsaveheader: null, 
  stcode: stcode, 
  message: "", 
  exception: exception
  ); 
  }
}
class Inwardsaveheader{

}