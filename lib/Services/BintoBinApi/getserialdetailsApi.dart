

import 'dart:convert';
import 'dart:developer';

import 'package:WareSmart/Model/BintoBinModel/getserialModel.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:http/http.dart' as http;
import 'package:WareSmart/constant/constantvalues.dart';

class GetBinSerialApi{
  static Future<GetbinserialModel> getdata(String serialnum,String whsecode)async{
    int resCode=500;
    try{
      log("ConstantValues.token::WareSmart/v1/GetSerialNumberStock/All/$whsecode/$serialnum"+ConstantValues.token.toString());
      log("urll::https://localhost:7269/api/WareSmart/v1/GetSerialNumberStock?ItemCode=JMS-JWC-K-SQR-01%20MAHAGONY%206%201%2F2X5&WhsCode=W001&SerialBatch=all"+"${Url.queryApi}WareSmart/v1/GetSerialNumberStock/All/$whsecode/$serialnum");
      final response=await http.get(Uri.parse("${Url.queryApi}WareSmart/v1/GetSerialNumberStock?ItemCode=All&WhsCode=$whsecode&SerialBatch=$serialnum"),
      headers: {
         "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
      }
      );
      resCode =response.statusCode;
      log("rescode::"+response.statusCode.toString());
      log("Binserial::"+response.body.toString());

      if(response.statusCode ==200 ){
        return 
        GetbinserialModel.fromJson(json.decode(response.body), response.statusCode);
      }else{
         return 
         GetbinserialModel.issues(json.decode(response.body), response.statusCode);
      }

    }catch(e){
      log("INWres::"+e.toString());
 return 
 GetbinserialModel.error(e.toString(), resCode);
    }

  }
}