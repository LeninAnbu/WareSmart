// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, unnecessary_string_interpolations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/Model/loginModel/loginmodel.dart';
import 'package:WareSmart/constant/Encrypted.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/helperfunc.dart';
// import 'package:sellerkit/Constant/Encripted.dart';


class LoginAPi {
  static Future<LoginModel> getData(PostLoginData postLoginData) async {
    int resCode = 500;

    try {
    //  log("aaa::"+"${Url.queryApi}PortalAuthenticate/MOBILELOGIN");
     log("ConstantValues.token:::"+ConstantValues.token.toString());
      final response = await http.post(
          Uri.parse("${Url.queryApi}WareSmart/v1/MobileLogin"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "tenantId": "${postLoginData.tenentID}",//WareSmart
  "userCode": "${postLoginData.username}",//U001
  "password": "${postLoginData.password}",//SINE90
  "deviceCode": "${postLoginData.deviceCode}",//HGAFSH88798
  "devicename": "${postLoginData.devicename}",//SAMSUNG
  "fcmToken": "${postLoginData.fcmToken}",
  "ip": "",
  "ssid": "",
  "lattitude": 0,
  "longitude": 0
          }));
      print("Login Req Body::" +
          jsonEncode({
           "tenantId": "${postLoginData.tenentID}",//WareSmart
  "userCode": "${postLoginData.username}",//U001
  "password": "${postLoginData.password}",//SINE90
  "deviceCode": "${postLoginData.deviceCode}",//HGAFSH88798
  "devicename": "${postLoginData.devicename}",//SAMSUNG
  "fcmToken": "${postLoginData.fcmToken}",
  "ip": "",
  "ssid": "",
  "lattitude": 0,
  "longitude": 0
          }).toString());
     
      // log("ADADADDAD" + "${response.statusCode.toString()}");
      log("bodylogin::" + "${response.body}");

      resCode = response.statusCode;
      if (response.statusCode == 200) {
        //
        
        Config config = new Config();
         Map<String, dynamic> tokenNew3=json.decode(response.body);
         log("tokenNew3:::" + tokenNew3.toString());
        Map<String, dynamic> jres = config.parseJwt("${tokenNew3['data'].toString()}");
        log("ABCD7333:::" + jres.toString());
        EncryptData Encrupt = new EncryptData();
        String? testData2 = Encrupt.decrypt(jres['encryptedClaims']);

        Map<String, dynamic> jres2 = jsonDecode("${testData2}");
        log("jres2:::"+jres2.toString());
        Map<String, dynamic> tokenNew=json.decode(response.body);
        // Utils.token = tokenNew['token'];
      HelperFunctions.saveTokenSharedPreference(tokenNew['data']);
                log("token::::"+tokenNew['data'].toString());
       ConstantValues.token = tokenNew['data'];
        return LoginModel.fromJson(jres2,json.decode(response.body) ,response.statusCode);
      } else if(response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: error");
        return LoginModel.issue(response.statusCode, json.decode(response.body));
      }else{
        log("APIERRor::"+json.decode(response.body).toString());
        return LoginModel.issue(response.statusCode, json.decode(response.body));
      }
    } catch (e) {
      print("Catch:" + e.toString());
      return LoginModel.error(resCode, "${e}");
    }
  }
}
