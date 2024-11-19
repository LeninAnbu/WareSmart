

import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/Model/InwardModel/GetPendingModel.dart';
import 'package:WareSmart/constant/constantvalues.dart';

class PendingInwardApi{
  static Future<InwPendingModel> getdata()async{
    int resCode=500;
    try{
      log("ConstantValues.token::"+"${Url.queryApi}"+ConstantValues.token.toString());
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetInward/P?Status=OPEN"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      // log("rescode::"+response.statusCode.toString());
      // log("INWres::"+response.body.toString());

      if(response.statusCode ==200 ){
        return InwPendingModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return InwPendingModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("INWres::"+e.toString());
 return InwPendingModel.error(e.toString(), resCode);
    }

  }
}