import 'dart:convert';

class InwsavePostModel {
  postInwByidheader? inwardsaveheader;
  String? message;
  int? stcode;
  String? exception;
  InwsavePostModel(
      {required this.inwardsaveheader,
      required this.stcode,
      required this.message,
      required this.exception});

  factory InwsavePostModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null) {
      //  var list = json.decode(jsons['data']) as List;
      return InwsavePostModel(
        
          inwardsaveheader: null,
          stcode: stcode,
          message: jsons["respCode"],
          exception: jsons["respDesc"]);
    } else {
      return InwsavePostModel(
          inwardsaveheader: null,
          stcode: stcode,
          message: "fail",
          exception: null);
    }
  }

  factory InwsavePostModel.issues(Map<String, dynamic> jsons, int stcode) {
    return InwsavePostModel(
        inwardsaveheader: null,
        stcode: stcode,
        message: jsons["respCode"],
        exception: jsons["respDesc"]);
  }
  factory InwsavePostModel.error(String? exception, int stcode) {
    return InwsavePostModel(
        inwardsaveheader: null,
        stcode: stcode,
        message: "",
        exception: exception);
  }
}

class postInwByidheader {
  postInwByidheader({
    //  required this.respCode,
    required this.datadetail,
    //  required this.respDesc,
    //  required this.respType

    // required this.customertag
  });

  // String? respType;
  //   String? respCode;
  //   String? respDesc;
  List<postInwitemBatchlist>? datadetail;

  factory postInwByidheader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;
    if (list.isEmpty) {
      return postInwByidheader(
        // respCode: jsons['respCode'],
        datadetail: null,
        // respDesc: jsons['respDesc'],
        // respType: jsons['respType']
      );
    } else {
      List<postInwitemBatchlist> dataList =
          list.map((data) => postInwitemBatchlist.fromJson(data)).toList();
      return postInwByidheader(
        // respCode: jsons['respCode'],
        datadetail: dataList,
        // respDesc: jsons['respDesc'],
        // respType: jsons['respType']
      );
    }
  }
}

class postInwitemBatchlist {
  int? AutoID;
  int? DocEntry;
  int? LineNum;
  String? WhsCode;
  String? ItemCode;
  String? ItemName;
  String? ManageBy;
  double? Unit_Quantity;
  double? Pack_Quantity;
  String? SerialBatchCode;
  double? SerialBatchQty;
  String? TagText;
  String? MfgDate;
  String? ExpiryDate;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDateTime;
  String? TraceId;
  postInwitemBatchlist(
      {required this.AutoID,
      required this.CreatedBy,
      required this.CreatedDateTime,
      required this.DocEntry,
      required this.ExpiryDate,
      required this.ItemCode,
      required this.ItemName,
      required this.LineNum,
      required this.ManageBy,
      required this.MfgDate,
      required this.Pack_Quantity,
      required this.SerialBatchCode,
      required this.SerialBatchQty,
      required this.TagText,
      required this.TraceId,
      required this.Unit_Quantity,
      required this.UpdatedBy,
      required this.UpdatedDateTime,
      required this.WhsCode});
  factory postInwitemBatchlist.fromJson(Map<String, dynamic> json) =>
      postInwitemBatchlist(
          AutoID: json['AutoID'] ?? 0,
          CreatedBy: json['CreatedBy'] ?? 0,
          CreatedDateTime: json['CreatedDateTime'] ?? '',
          DocEntry: json['DocEntry'] ?? 0,
          ExpiryDate: json['ExpiryDate'] ?? '',
          ItemCode: json['ItemCode'] ?? '',
          ItemName: json['ItemName'] ?? '',
          LineNum: json['LineNum'] ?? 0,
          ManageBy: json['ManageBy'] ?? '',
          MfgDate: json['MfgDate'] ?? '',
          Pack_Quantity: json['Pack_Quantity'] ?? 0.0,
          SerialBatchCode: json['SerialBatchCode'] ?? '',
          SerialBatchQty: json['SerialBatchQty'] ?? 0.0,
          TagText: json['TagText'] ?? '',
          TraceId: json['TraceId'] ?? '',
          Unit_Quantity: json['Unit_Quantity'] ?? 0.0,
          UpdatedBy: json['UpdatedBy'] ?? 0,
          UpdatedDateTime: json['UpdatedDateTime'] ?? '',
          WhsCode: json['WhsCode'] ?? '');
}
