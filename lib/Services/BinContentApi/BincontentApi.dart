

import 'dart:convert';
import 'dart:developer';
import 'package:WareSmart/Model/BincontentModel/BincontentModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';

class BincontentApi {
  static Future<BincontentModel> getdata(String? itemcode,String? serialnum,String? bincode,String? whsecode,) async {
    int resCode = 500;
    try {
      log("ConstantValues.token::" +
         "${Url.queryApi}WareSmart/v1/GetSerialNumberBinStock/$itemcode/$serialnum/$bincode/$whsecode"); //54-1-10.000000-2
      final response = await http.get(
          Uri.parse("${Url.queryApi}WareSmart/v1/GetSerialNumberBinStock/$itemcode/$serialnum/$bincode/$whsecode"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
          });
      resCode = response.statusCode;
      log("Pickuprescode::" + response.statusCode.toString());
      log("Pickupres::" + response.body.toString());

      if (response.statusCode == 200) {
        return 
        BincontentModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        return 
         BincontentModel.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("INWres::" + e.toString());
      return 
 BincontentModel.error(e.toString(), resCode);
    }
  }
}
