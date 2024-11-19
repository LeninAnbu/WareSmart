import 'dart:convert';
import 'dart:developer';
import 'package:WareSmart/Model/DespatchModel/getQRModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';

class GetDespatchQRApi {
  static Future<DesQRModel> getdata(String? code) async {
    int resCode = 500;
    try {
      log("ConstantValues.token::"+"${Url.queryApi}WareSmart/v1/GetPicslipQRDetails/$code" +
          ConstantValues.token.toString()); //54-1-10.000000-2
      final response = await http.get(
          Uri.parse("${Url.queryApi}WareSmart/v1/GetPicslipQRDetails/$code"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
          });
      resCode = response.statusCode;
      log("Pickuprescode::" + response.statusCode.toString());
      log("Pickupres::" + response.body.toString());

      if (response.statusCode == 200) {
        return 
        DesQRModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        return 
         DesQRModel.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("INWres::" + e.toString());
      return 
 DesQRModel.error(e.toString(), resCode);
    }
  }
}
