import 'dart:convert';

class PostPickupModel {
  PostPickupheader? postpickupheader;
  String? message;
  int? stcode;
  String? exception;
  PostPickupModel(
      {required this.postpickupheader,
      required this.stcode,
      required this.message,
      required this.exception});

  factory PostPickupModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null) {
      //  var list = json.decode(jsons['data']) as List;
      return PostPickupModel(
        
          postpickupheader: null,
          stcode: stcode,
          message: jsons["respCode"],
          exception: jsons["respDesc"]);
    } else {
      return PostPickupModel(
          postpickupheader: null,
          stcode: stcode,
          message: "fail",
          exception: null);
    }
  }

  factory PostPickupModel.issues(Map<String, dynamic> jsons, int stcode) {
    return PostPickupModel(
        postpickupheader: null,
        stcode: stcode,
        message: jsons["respCode"],
        exception: jsons["respDesc"]);
  }
  factory PostPickupModel.error(String? exception, int stcode) {
    return PostPickupModel(
        postpickupheader: null,
        stcode: stcode,
        message: "",
        exception: exception);
  }
}

class PostPickupheader {
  PostPickupheader({
    //  required this.respCode,
    required this.datadetail,
    //  required this.respDesc,
    //  required this.respType

    // required this.customertag
  });

  // String? respType;
  //   String? respCode;
  //   String? respDesc;
  List<postpickuplist>? datadetail;

  factory PostPickupheader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;
    if (list.isEmpty) {
      return PostPickupheader(
        // respCode: jsons['respCode'],
        datadetail: null,
        // respDesc: jsons['respDesc'],
        // respType: jsons['respType']
      );
    } else {
      // List<postpickuplist> dataList =
      //     list.map((data) => postpickuplist.fromJson(data)).toList();
      return PostPickupheader(
        // respCode: jsons['respCode'],
        datadetail: null,
        // respDesc: jsons['respDesc'],
        // respType: jsons['respType']
      );
    }
  }
}
class postpickuplist{

}