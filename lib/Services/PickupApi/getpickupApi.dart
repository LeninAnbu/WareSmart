

import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/PickupModel/GetPickupModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';

class GetPickupApi{
  static Future<GetPickupModel> getdata(String? code)async{
    int resCode=500;
    try{
      log("ConstantValues.token::"+ConstantValues.token.toString());//54-1-10.000000-2
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetPicslipQRDetails/$code"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      log("Pickuprescode::"+response.statusCode.toString());
      log("Pickupres::"+response.body.toString());

      if(response.statusCode ==200 ){
        return 
        GetPickupModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return 
         GetPickupModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("INWres::"+e.toString());
 return 
 GetPickupModel.error(e.toString(), resCode);
    }

  }
}