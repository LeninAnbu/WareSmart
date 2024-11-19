

import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/Model/InwardModel/GetPendingModel.dart';
import 'package:WareSmart/Model/InwardModel/GetinwByidModel.dart';
import 'package:WareSmart/constant/constantvalues.dart';

class GetInwardByidApi{
  static Future<GetInwByidModel> getdata(int docentry)async{
    int resCode=500;
    try{
      log("ConstantValues.token::"+ConstantValues.token.toString());
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetInwardById?DocEntry=$docentry"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      log("rescode::"+response.statusCode.toString());
      log("INWresbyid::"+response.body.toString());

      if(response.statusCode ==200 ){
        return GetInwByidModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return GetInwByidModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("exception::"+e.toString());
 return GetInwByidModel.error(e.toString(), resCode);
    }

  }
}