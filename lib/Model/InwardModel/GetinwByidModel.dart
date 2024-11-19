import 'dart:convert';

class GetInwByidModel {
  GetInwByidheader? getInwByidheader;
  String? message;
  int? stcode;
  String? exception;
  GetInwByidModel(
      {required this.getInwByidheader,
      required this.stcode,
      required this.message,
      required this.exception});

  factory GetInwByidModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons['data'] != null) {
      var list = json.decode(jsons['data'] as String) as Map<String, dynamic>;
      return GetInwByidModel(
          getInwByidheader: GetInwByidheader.fromJson(list),
          stcode: stcode,
          message: "success",
          exception: null);
    } else {
      return GetInwByidModel(
          getInwByidheader: null,
          stcode: stcode,
          message: "fail",
          exception: null);
    }
  }

  factory GetInwByidModel.issues(Map<String, dynamic> jsons, int stcode) {
    return GetInwByidModel(
        getInwByidheader: null,
        stcode: stcode,
        message: jsons["respCode"],
        exception: jsons["respDesc"]);
  }
  factory GetInwByidModel.error(String? exception, int stcode) {
    return GetInwByidModel(
        getInwByidheader: null,
        stcode: stcode,
        message: "",
        exception: exception);
  }
}

class GetInwByidheader {
  List<InwDetailList>? inwPendingDetail;
  List<InwItemList>? inwItemList;
  List<InwitemBatchlist>? inwitemBatchlist;
  List<Inwputaway>? inwputawaylist;
  GetInwByidheader(
      {required this.inwPendingDetail,
      required this.inwItemList,
      required this.inwitemBatchlist,
      required this.inwputawaylist});
  factory GetInwByidheader.fromJson(Map<String, dynamic> jsons) {
    if (jsons['INWARD'] != null && jsons['INWARD_Items'] != null) {
      var list = jsons['INWARD'] as List;
      var list2 = jsons['INWARD_Items'] as List;
      var list3 = jsons['Inward_Items_Batch'] as List;
      var list4 = jsons['Inward_Items_Putaway'] as List;
      List<InwDetailList> datalist =
          list.map((data) => InwDetailList.fromJson(data)).toList();
      List<InwItemList> datalist2 =
          list2.map((data) => InwItemList.fromJson(data)).toList();
      
      if(list3.isNotEmpty && list4.isNotEmpty){
 List<InwitemBatchlist> datalist3 =
            list3.map((data) => InwitemBatchlist.fromJson(data)).toList();
              List<Inwputaway> datalist4 =
            list4.map((data) => Inwputaway.fromJson(data)).toList();
            return GetInwByidheader(
            inwPendingDetail: datalist,
            inwItemList: datalist2,
            inwitemBatchlist: datalist3,
            inwputawaylist: datalist4);
      }else if(list3.isNotEmpty && list4.isEmpty){
        List<InwitemBatchlist> datalist3 =
            list3.map((data) => InwitemBatchlist.fromJson(data)).toList();
 return GetInwByidheader(
            inwPendingDetail: datalist,
            inwItemList: datalist2,
            inwitemBatchlist: datalist3,
            inwputawaylist: null);
      }else if(list3.isEmpty && list4.isNotEmpty){
         List<Inwputaway> datalist4 =
            list4.map((data) => Inwputaway.fromJson(data)).toList();
return GetInwByidheader(
            inwPendingDetail: datalist,
            inwItemList: datalist2,
            inwitemBatchlist: null,
            inwputawaylist: datalist4);
      }else {
        return GetInwByidheader(
            inwPendingDetail: datalist,
            inwItemList: datalist2,
            inwitemBatchlist: null,
            inwputawaylist: null);
      }
      // if (list3.isNotEmpty) {
      //   List<InwitemBatchlist> datalist3 =
      //       list3.map((data) => InwitemBatchlist.fromJson(data)).toList();

      //   return GetInwByidheader(
      //       inwPendingDetail: datalist,
      //       inwItemList: datalist2,
      //       inwitemBatchlist: null,
      //       inwputawaylist: datalist4);
      // } else {
      //   List<InwDetailList> datalist =
      //       list.map((data) => InwDetailList.fromJson(data)).toList();
      //   List<InwItemList> datalist2 =
      //       list2.map((data) => InwItemList.fromJson(data)).toList();

      //   return GetInwByidheader(
      //       inwPendingDetail: datalist,
      //       inwItemList: datalist2,
      //       inwitemBatchlist: null
      //       );
      // }
    } else {
      return GetInwByidheader(
          inwPendingDetail: null, inwItemList: null, inwitemBatchlist: null,inwputawaylist: null);
    }
  }
}

class InwitemBatchlist {
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
  InwitemBatchlist(
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
  factory InwitemBatchlist.fromJson(Map<String, dynamic> json) =>
      InwitemBatchlist(
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

class InwItemList {
  int? DocEntry;
  int? LineNum;
  String? ItemCode;
  String? ItemName;
  double? Unit_Quantity;
  double? Pack_Quantity;
  double? Price;
  double? BasePrice;
  double? TaxRate;
  double? GrossLineTotal;
  double? LineVat;
  double? NetLineTotal;
  int? BaseEntry;
  int? BaseLine;
  String? BaseDocId;
  int? BaseDocLine;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDateTime;
  String? TraceId;
  String? ManageBy;
  bool? hasExpiryDate;
  InwItemList(
      {required this.hasExpiryDate,
      required this.ManageBy,
      required this.BaseDocId,
      required this.BaseDocLine,
      required this.BaseEntry,
      required this.BaseLine,
      required this.BasePrice,
      required this.CreatedBy,
      required this.CreatedDateTime,
      required this.DocEntry,
      required this.GrossLineTotal,
      required this.ItemCode,
      required this.ItemName,
      required this.LineNum,
      required this.LineVat,
      required this.NetLineTotal,
      required this.Pack_Quantity,
      required this.Price,
      required this.TaxRate,
      required this.TraceId,
      required this.Unit_Quantity,
      required this.UpdatedBy,
      required this.UpdatedDateTime});
  factory InwItemList.fromJson(Map<String, dynamic> json) => InwItemList(
      hasExpiryDate: json['hasExpiryDate'] ?? false,
      ManageBy: json['ManageBy'] ?? '',
      BaseDocId: json['BaseDocId'] ?? '',
      BaseDocLine: json['BaseDocLine'] ?? 0,
      BaseEntry: json['BaseEntry'] ?? 0,
      BaseLine: json['BaseLine'] ?? 0,
      BasePrice: json['BasePrice'] ?? 0.0,
      CreatedBy: json['CreatedBy'] ?? 0,
      CreatedDateTime: json['CreatedDateTime'] ?? '',
      DocEntry: json['DocEntry'] ?? 0,
      GrossLineTotal: json['GrossLineTotal'] ?? 0.0,
      ItemCode: json['ItemCode'] ?? '',
      ItemName: json['ItemName'] ?? '',
      LineNum: json['LineNum'] ?? 0,
      LineVat: json['LineVat'] ?? 0.0,
      NetLineTotal: json['NetLineTotal'] ?? 0.0,
      Pack_Quantity: json['Pack_Quantity'] ?? 0.0,
      Price: json['Price'] ?? 0.0,
      TaxRate: json['TaxRate'] ?? 0.0,
      TraceId: json['TraceId'] ?? '',
      Unit_Quantity: json['Unit_Quantity'] ?? 0.0,
      UpdatedBy: json['UpdatedBy'] ?? 0,
      UpdatedDateTime: json['UpdatedDateTime'] ?? '');
}

class InwDetailList {
  int? DocEntry;
  int? DocNum;
  String? InwardType;
  String? PORef;
  String? DocDate;
  String? SupplierCode;
  String? SupplierName;
  String? SupplierMobile;
  String? AlternateMobileNo;
  String? ContactName;
  String? SupplierEmail;
  String? CompanyName;
  String? GSTNo;
  String? TransRef;
  String? InwardDocDate;
  String? Bil_Address1;
  String? Bil_Address2;
  String? Bil_Address3;
  String? Bil_Area;
  String? Bil_City;
  String? Bil_District;
  String? Bil_State;
  String? Bil_Country;
  String? Bil_Pincode;
  String? Del_Address1;
  String? Del_Address2;
  String? Del_Address3;
  String? Del_Area;
  String? Del_City;
  String? Del_District;
  String? Del_State;
  String? Del_Country;
  String? Del_Pincode;
  String? WhsCode;
  String? OrderStatus;
  double? GrossTotal;
  double? Discount;
  double? SubTotal;
  double? TaxAmount;
  double? RoundOff;
  double? DocTotal;
  String? AttachURL1;
  String? AttachURL2;
  String? AttachURL3;
  String? AttachURL4;
  String? AttachURL5;
  String? OrderNote;
  int? isCancelled;
  String? CancelledDate;
  String? CancelledReason;
  String? CancelledRemarks;
  String? BaseDocId;
  String? BaseDocRef;
  String? BaseDocDate;
  int? CreatedBy;
  String? CreatedDatetime;
  int? UpdatedBy;
  String? UpdatedDatetime;
  String? traceid;
  String? WhsName;
  InwDetailList(
      {required this.AlternateMobileNo,
      required this.AttachURL1,
      required this.AttachURL2,
      required this.AttachURL3,
      required this.AttachURL4,
      required this.AttachURL5,
      required this.BaseDocDate,
      required this.BaseDocId,
      required this.BaseDocRef,
      required this.Bil_Address1,
      required this.Bil_Address2,
      required this.Bil_Address3,
      required this.Bil_Area,
      required this.Bil_City,
      required this.Bil_Country,
      required this.Bil_District,
      required this.Bil_Pincode,
      required this.Bil_State,
      required this.CancelledDate,
      required this.CancelledReason,
      required this.CancelledRemarks,
      required this.CompanyName,
      required this.ContactName,
      required this.CreatedBy,
      required this.CreatedDatetime,
      required this.Del_Address1,
      required this.Del_Address2,
      required this.Del_Address3,
      required this.Del_Area,
      required this.Del_City,
      required this.Del_Country,
      required this.Del_District,
      required this.Del_Pincode,
      required this.Del_State,
      required this.Discount,
      required this.DocDate,
      required this.DocEntry,
      required this.DocNum,
      required this.DocTotal,
      required this.GSTNo,
      required this.GrossTotal,
      required this.InwardDocDate,
      required this.InwardType,
      required this.OrderNote,
      required this.OrderStatus,
      required this.PORef,
      required this.RoundOff,
      required this.SubTotal,
      required this.SupplierCode,
      required this.SupplierEmail,
      required this.SupplierMobile,
      required this.SupplierName,
      required this.TaxAmount,
      required this.TransRef,
      required this.UpdatedBy,
      required this.UpdatedDatetime,
      required this.WhsCode,
      required this.WhsName,
      required this.isCancelled,
      required this.traceid});
  factory InwDetailList.fromJson(Map<String, dynamic> json) => InwDetailList(
      AlternateMobileNo: json['AlternateMobileNo'] ?? '',
      AttachURL1: json['AttachURL1'] ?? '',
      AttachURL2: json['AttachURL2'] ?? '',
      AttachURL3: json['AttachURL3'] ?? '',
      AttachURL4: json['AttachURL4'] ?? '',
      AttachURL5: json['AttachURL5'] ?? '',
      BaseDocDate: json['BaseDocDate'] ?? '',
      BaseDocId: json['BaseDocId'] ?? '',
      BaseDocRef: json['BaseDocRef'] ?? '',
      Bil_Address1: json['Bil_Address1'] ?? '',
      Bil_Address2: json['Bil_Address2'] ?? '',
      Bil_Address3: json['Bil_Address3'] ?? '',
      Bil_Area: json['Bil_Area'] ?? '',
      Bil_City: json['Bil_City'] ?? '',
      Bil_Country: json['Bil_Country'] ?? '',
      Bil_District: json['Bil_District'] ?? '',
      Bil_Pincode: json['Bil_Pincode'] ?? '',
      Bil_State: json['Bil_State'] ?? '',
      CancelledDate: json['CancelledDate'] ?? '',
      CancelledReason: json['CancelledReason'] ?? '',
      CancelledRemarks: json['CancelledRemarks'] ?? '',
      CompanyName: json['CompanyName'] ?? '',
      ContactName: json['ContactName'] ?? '',
      CreatedBy: json['CreatedBy'] ?? 0,
      CreatedDatetime: json['CreatedDatetime'] ?? '',
      Del_Address1: json['Del_Address1'] ?? '',
      Del_Address2: json['Del_Address2'] ?? '',
      Del_Address3: json['Del_Address3'] ?? '',
      Del_Area: json['Del_Area'] ?? '',
      Del_City: json['Del_City'] ?? '',
      Del_Country: json['Del_Country'] ?? '',
      Del_District: json['Del_District'] ?? '',
      Del_Pincode: json['Del_Pincode'] ?? '',
      Del_State: json['Del_State'] ?? '',
      Discount: json['Discount'] ?? 0.0,
      DocDate: json['DocDate'] ?? '',
      DocEntry: json['DocEntry'] ?? 0,
      DocNum: json['DocNum'] ?? 0,
      DocTotal: json['DocTotal'] ?? 0.0,
      GSTNo: json['GSTNo'] ?? '',
      GrossTotal: json['GrossTotal'] ?? 0.0,
      InwardDocDate: json['InwardDocDate'] ?? '',
      InwardType: json['InwardType'] ?? '',
      OrderNote: json['OrderNote'] ?? '',
      OrderStatus: json['OrderStatus'] ?? '',
      PORef: json['PORef'] ?? '',
      RoundOff: json['RoundOff'] ?? 0.0,
      SubTotal: json['SubTotal'] ?? 0.0,
      SupplierCode: json['SupplierCode'] ?? '',
      SupplierEmail: json['SupplierEmail'] ?? '',
      SupplierMobile: json['SupplierMobile'] ?? '',
      SupplierName: json['SupplierName'] ?? '',
      TaxAmount: json['TaxAmount'] ?? 0.0,
      TransRef: json['TransRef'] ?? '',
      UpdatedBy: json['UpdatedBy'] ?? 0,
      UpdatedDatetime: json['UpdatedDatetime'] ?? '',
      WhsCode: json['WhsCode'] ?? '',
      WhsName: json['WhsName'] ?? '',
      isCancelled: json['isCancelled'] ?? 0,
      traceid: json['traceid'] ?? '');
}

class Inwputaway {
  int? AutoID;
  int? DocEntry;
  int? LineNum;
  int? SerialBatch_LineNum;
  String? WhsCode;
  String? ItemCode;
  String? ItemName;
  String? ManageBy;
  double? Unit_Quantity;
  double? Pack_Quantity;
  String? SerialBatchCode;
  double? SerialBatchQty;
  String? TagText;
  String? BinCode;
  double? BinQty;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDateTime;
  String? TraceId;
  Inwputaway(
      {required this.AutoID,
      required this.BinCode,
      required this.BinQty,
      required this.CreatedBy,
      required this.CreatedDateTime,
      required this.DocEntry,
      required this.ItemCode,
      required this.ItemName,
      required this.LineNum,
      required this.ManageBy,
      required this.Pack_Quantity,
      required this.SerialBatchCode,
      required this.SerialBatchQty,
      required this.SerialBatch_LineNum,
      required this.TagText,
      required this.TraceId,
      required this.Unit_Quantity,
      required this.UpdatedBy,
      required this.UpdatedDateTime,
      required this.WhsCode});
  factory Inwputaway.fromJson(Map<String, dynamic> json) => Inwputaway(
      AutoID: json['AutoID'] ?? 0,
      BinCode: json['BinCode'] ?? '',
      BinQty: json['BinQty'] ?? 0.0,
      CreatedBy: json['CreatedBy'] ?? 0,
      CreatedDateTime: json['CreatedDateTime'] ?? '',
      DocEntry: json['DocEntry'] ?? 0,
      ItemCode: json['ItemCode'] ?? "",
      ItemName: json['ItemName'] ?? '',
      LineNum: json['LineNum'] ?? 0,
      ManageBy: json['ManageBy'] ?? '',
      Pack_Quantity: json['Pack_Quantity'] ?? 0.0,
      SerialBatchCode: json['SerialBatchCode'] ?? '',
      SerialBatchQty: json['SerialBatchQty'] ?? 0.0,
      SerialBatch_LineNum: json['SerialBatch_LineNum'] ?? 0,
      TagText: json['TagText'] ?? '',
      TraceId: json['TraceId'] ?? '',
      Unit_Quantity: json['Unit_Quantity'] ?? 0.0,
      UpdatedBy: json['UpdatedBy'] ?? 0,
      UpdatedDateTime: json['UpdatedDateTime'] ?? "",
      WhsCode: json['WhsCode'] ?? '');
}
