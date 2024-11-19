import 'dart:convert';

class PostDessaveModel {
  PostPickupheader? postpickupheader;
  String? message;
  int? stcode;
  String? exception;
  PostDessaveModel(
      {required this.postpickupheader,
      required this.stcode,
      required this.message,
      required this.exception});

  factory PostDessaveModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null) {
      //  var list = json.decode(jsons['data']) as List;
      return PostDessaveModel(
        
          postpickupheader: null,
          stcode: stcode,
          message: jsons["respCode"],
          exception: jsons["respDesc"]);
    } else {
      return PostDessaveModel(
          postpickupheader: null,
          stcode: stcode,
          message: "fail",
          exception: null);
    }
  }

  factory PostDessaveModel.issues(Map<String, dynamic> jsons, int stcode) {
    return PostDessaveModel(
        postpickupheader: null,
        stcode: stcode,
        message: jsons["respCode"],
        exception: jsons["respDesc"]);
  }
  factory PostDessaveModel.error(String? exception, int stcode) {
    return PostDessaveModel(
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