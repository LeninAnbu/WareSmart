

import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/InwardModel/BinmasterModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/Model/InwardModel/GetPendingModel.dart';
import 'package:WareSmart/constant/constantvalues.dart';

class BinMasterApi{
  static Future<BinMasterModel> getdata()async{
    int resCode=500;
    try{
      log("ConstantValues.token::"+ConstantValues.token.toString());
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetBinMaster?Type=1"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      // log("GetBinMastercode::"+response.statusCode.toString());
      log("GetBinMaster::"+response.body.toString());

      if(response.statusCode ==200 ){
        return BinMasterModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return BinMasterModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("INWres::"+e.toString());
 return BinMasterModel.error(e.toString(), resCode);
    }

  }
}