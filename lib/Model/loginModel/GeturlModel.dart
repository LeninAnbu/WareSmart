// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'dart:convert';

class GetUrlModel {
  String? url1;
  String? url2;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetUrlModel(
      {required this.url1,
      required this.url2,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetUrlModel.fromJson(Map<String,dynamic> jsons, int stcode) {
      print("URL JSON Before Api::" + jsons.toString());
    if (jsons != null && jsons.isNotEmpty) {
      print("URL JSON After Api::" + jsons.toString());
      // String data = jsonDecode(jsons).toString();
      // List<GetUrlModelData> dataList =
      //     list.map((data) => GetUrlModelData.fromJson(data)).toList();
      return GetUrlModel(
          url1: jsons['customerUrl']??'',
          url2: jsons['snapStockSyncUrl']??'',
          message: "sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetUrlModel(
          url1: null,
          url2: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory GetUrlModel.issue(int rescode,String exp) {
    return GetUrlModel(
      url1: null,
          url2: null,
        message: 'Exception',
        status: null,
        stcode: rescode,
        exception:exp,
    );
  }
  // factory GetUrlModel.error(String jsons, int stcode) {
  //   return GetUrlModel(
  //       url: null,
  //       message: 'Exception',
  //       status: null,
  //       stcode: stcode,
  //       exception: jsons);
  // }
  factory GetUrlModel.error(String jsons, int stcode) {
    return GetUrlModel(
        url1: null,
          url2: null,
        message: 'Catch',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}
