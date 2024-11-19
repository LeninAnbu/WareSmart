// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:WareSmart/Model/loginModel/GeturlModel.dart';
import 'package:http/http.dart' as http;

class GetURLApi {
  static Future<GetUrlModel> getData(
String? CustomerId) async {
// await config.getSetup();
print("Api CustomerId::"+CustomerId.toString());
    int resCode = 500;
    try {
      print('Get Url Api::http://91.203.133.224:92/api/WareSmart/v1/GetCustomerUrl?TenantId=$CustomerId');
    final response = await http.get(Uri.parse('http://91.203.133.224:92/api/WareSmart/v1/GetCustomerUrl?TenantId=$CustomerId'),

        headers: {"Content-Type": "application/json"},

    );
print("get url body::"+response.body.toString());
      print("Status Code::" +response.statusCode.toString());
      resCode = response.statusCode;
      
      if (response.statusCode == 200) {
        // print("Error: ${response.body}");
        return GetUrlModel.fromJson(json.decode(response.body) , response.statusCode);
      } else {
        // print("Error: ${response.body}");
        return GetUrlModel.issue(response.statusCode,response.body );
      }
    } catch (e) {
      log("Exception: " + e.toString());
      return GetUrlModel.error(e.toString(), resCode);
    }
  }
}
