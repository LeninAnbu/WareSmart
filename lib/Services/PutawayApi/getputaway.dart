

import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/PutAwayModel/putawayModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';

class GetPutawayApi{
  static Future<GetPutawayModel> getdata()async{
    int resCode=500;
    try{
      // log("ConstantValues.token::"+ConstantValues.token.toString());
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetPendingPutaway/${ConstantValues.Whsecode}"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      // log("rescode::"+response.statusCode.toString());
      log("INWres::"+response.body.toString());

      if(response.statusCode ==200 ){
        return GetPutawayModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return GetPutawayModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("INWres::"+e.toString());
 return GetPutawayModel.error(e.toString(), resCode);
    }

  }
}