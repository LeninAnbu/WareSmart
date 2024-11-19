


import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/DelReturnMOdel/GetDispModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';

class GetDispApi{
  static Future<DispModel> getdata()async{
    int resCode=500;
    try{
      log("ConstantValues.token::"+ConstantValues.token.toString());
      log("urll::"+"${Url.queryApi}WareSmart/v1/GetDispositionList");
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetDispositionList"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      log("rescode::"+response.statusCode.toString());
      log("GetAllOpenDespatch::"+response.body.toString());

      if(response.statusCode ==200 ){
        return 
        DispModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return 
DispModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("INWres::"+e.toString());
 return 
 DispModel.error(e.toString(), resCode);
    }

  }
}