
import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/DBModel/inwardbackupDBModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/DBModel/inwardDBmodel.dart';
import 'package:WareSmart/Model/InwardModel/savepostModel.dart';
import 'package:WareSmart/constant/constantvalues.dart';
class InwSaveApi {
  static Future<InwsavePostModel> getData(
    List<Documents> doclines ,) async {
    int resCode = 500;
    // log("finalbackup::"+finalbackup.length.toString());
List<binlines> binlinelist=[];
    try {
//       for(int i=0;i< finalbackup.length;i++){
// binlinelist.add(
//   binlines(
//     bincode: doclines[i].binCode, 
//     binqty: doclines[i].quantity.toInt()
//     )
// );

//     }
   if (doclines.isNotEmpty && doclines[0].binlinelist != null && doclines[0].binlinelist!.isNotEmpty) {
  log("aaa::" + doclines[0].binlinelist![0].binqty.toString());
} else {
  log("binlinelist is null or empty");
}
    log("messageinward::"+jsonEncode(
           doclines.map((e) => e.tojson()).toList()
          ));
          log("MfgDate::"+ConstantValues.token);
      final response = await http.post(
          Uri.parse('${Url.queryApi}WareSmart/v1/UpdateInwardSerialBatch'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
           
          },
          body: jsonEncode(
           doclines.map((e) => e.tojson()).toList()
          ));
      
  

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("Post Enq ResponceINWARD::" + response.body.toString());
      // print("Post Enq Stcode::" + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return 
        InwsavePostModel.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return
        InwsavePostModel.issues(json.decode(response.body), resCode);
      } else {
        return
        InwsavePostModel.issues(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("Exception3333: " + e.toString());
     
      return 
      InwsavePostModel.error(e.toString(), resCode);
    }
  }
}