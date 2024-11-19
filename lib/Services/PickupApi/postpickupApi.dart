
import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/PickupModel/postpickupModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';
class postpickupApi {
  static Future<PostPickupModel> getData(String whsecode,String qrcode,String seialnum,String devicecode,) async {
    int resCode = 500;
    
    try {
      log("AAAA::"+"${Url.queryApi}WareSmart/v1/PickSlipQRAllocation/$whsecode/$qrcode/$seialnum/$devicecode");
          log("MfgDate::"+ConstantValues.token);
      final response = await http.post(
          Uri.parse('${Url.queryApi}WareSmart/v1/PickSlipQRAllocation/$whsecode/$qrcode/$seialnum/$devicecode'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
           
          },
          );
      
  

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("Post Enq ResponceINWARD::" + response.body.toString());
      // print("Post Enq Stcode::" + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return 
        PostPickupModel.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return 
        PostPickupModel.issues(json.decode(response.body), resCode);
      } else {
        return 
        PostPickupModel.issues(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("Exception3333: " + e.toString());
     
      return 
      PostPickupModel.error(e.toString(), resCode);
    }
  }
}