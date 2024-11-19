
import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/DespatchModel/postreqModel.dart';
import 'package:WareSmart/Model/DespatchModel/postsaveApiModel.dart';
import 'package:WareSmart/Model/PickupModel/postpickupModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';
class postDesSaveApi {
  static Future<PostDessaveModel> getData(List<postdesptachreq> postdesline) async {
    int resCode = 500;
    
    try {
      log("AAAA::"+"${postdesline.map((e) => e.tojson()).toList()}");
          log("MfgDate::"+ConstantValues.token);
      final response = await http.post(
          Uri.parse('${Url.queryApi}WareSmart/v1/PostDespatch'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
           
          },
          body:jsonEncode(postdesline.map((e) => e.tojson()).toList()) 
          );
      
  

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("Post Enq ResponceINWARD::" + response.body.toString());
      // print("Post Enq Stcode::" + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return 
        PostDessaveModel.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return 
        PostDessaveModel.issues(json.decode(response.body), resCode);
      } else {
        return 
        PostDessaveModel.issues(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("Exception3333: " + e.toString());
     
      return 
      PostDessaveModel.error(e.toString(), resCode);
    }
  }
}