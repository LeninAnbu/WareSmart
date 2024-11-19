
import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/BintoBinModel/postmodel.dart';
import 'package:WareSmart/Model/BintoBinModel/requestpostModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';
class BintinSaveApi {
  static Future<BintoBinPostModel> getData(
    List<Binreqpost> doclines  ) async {
    int resCode = 500;
    
    try {
    log("BintinSaveApi::"+jsonEncode(
           doclines.map((e) => e.tojson()).toList()
          ));
          log("MfgDate::"+ConstantValues.token);
      final response = await http.post(
          Uri.parse('${Url.queryApi}WareSmart/v1/AddBinTransfer'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
           
          },
          body: jsonEncode(
           doclines.map((e) => e.tojson()).toList()
          ));
      
  

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("Post Enq Responceputaway::" + response.body.toString());
      // print("Post Enq Stcode::" + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return 
        BintoBinPostModel.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return 
        BintoBinPostModel.issues(json.decode(response.body), resCode);
      } else {
        return 
        BintoBinPostModel.issues(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("Exception3333: " + e.toString());
     
      return 
      BintoBinPostModel.error(e.toString(), resCode);
    }
  }
}