// ignore_for_file: file_names
import 'dart:developer';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/rng.dart';
import 'package:WareSmart/DBModel/inwardbackupDBModel.dart';
import 'package:WareSmart/constant/config.dart';

const String tablename = "wmsinward";

class Columns {
  static const String docEntry = "DocEntry";
  static const String numAtCard = "NumAtCard";
  static const String lineNum = "LineNum";
  static const String itemCode = "ItemCode";
  static const String binCode = "BinCode";
  static const String serialNum = "SerialNum";
  static const String expirydate = "Expirydate";
  static const String quantity = "Quantity";
  static const String manageBy = "ManageBy";
  static const String whsCode = "WhsCode";
  static const String itemName = "ItemName";
  static const String unit_Quantity = "Unit_Quantity";
  static const String pack_Quantity = "Pack_Quantity";
  static const String tagText = "TagText";
  static const String mfgDate = "MfgDate";

//  static final String alterphone = "alterphone";
}

class Documents {
  final int docEntry;
  final String numAtCard;
  final int lineNum;
  final String itemCode;
  final String itemname;
  final String binCode;
  final String serialNum;
  final String expirydate;
  double quantity;
  final String ManageBy;
  final String WhsCode;
  final double Unit_Quantity;
  final double Pack_Quantity;
  final String TagText;
  final String MfgDate;
  List<binlines>? binlinelist = [];
//final int alterphone ;

  Documents(
      {this.binlinelist,
      required this.itemname,
      required this.binCode,
      required this.docEntry,
      required this.itemCode,
      required this.lineNum,
      required this.numAtCard,
      required this.serialNum,
      required this.quantity,
      required this.expirydate,
      required this.ManageBy,
      required this.MfgDate,
      required this.Pack_Quantity,
      required this.TagText,
      required this.Unit_Quantity,
      required this.WhsCode});

  Map<String, Object?> toMap() => {
        Columns.docEntry: docEntry,
        Columns.numAtCard: numAtCard,
        Columns.lineNum: lineNum,
        Columns.itemCode: itemCode,
        Columns.binCode: binCode,
        Columns.serialNum: serialNum,
        Columns.expirydate: expirydate,
        Columns.quantity: quantity,
        Columns.manageBy: ManageBy,
        Columns.mfgDate: MfgDate,
        Columns.pack_Quantity: Pack_Quantity,
        Columns.tagText: TagText,
        Columns.unit_Quantity: Unit_Quantity,
        Columns.whsCode: WhsCode,
      };

  Map<String, dynamic> tojson() {
    List<Documentsbackup> finalbackup = [];
    // log("jjjj::"+d)
    log("binlinelist::" + binlinelist!.length.toString());
    Map<String, dynamic> map = {
      "traceid":Uuid().v4(),
      "docentry": docEntry,
      "linenum": lineNum,
      "serialbatch_linenum": null,
      "manageBy": ManageBy,
      "whscode": WhsCode,
      "itemcode": itemCode,
      "itemname": itemname,
      "unit_quantity": Unit_Quantity,
      "pack_quantity": Pack_Quantity,
      "serialbatchcode": serialNum,
      "serialbatchqty": quantity,
      "tagtext": TagText,
      "mfgdate": MfgDate,
      "expirydate": expirydate == '' ? null : Config.alignexpiry(expirydate),
      "binlines": binlinelist!.map((e) => e.tojson2()).toList()
    };

    return map;
  }
  //  List<Documents> groupAndTransform(List<Documents> items) {
  //     Map<String, Documents> groupedItems = {};

  //     for (var item in items) {
  //       String key =
  //           '${item.docEntry}_${item.lineNum}_${item.serialNum}_${item.ManageBy}_${item.WhsCode}_${item.itemCode}_${item.itemname}_${item.Unit_Quantity}_${item.Pack_Quantity}_${item.serialNum}_${item.TagText}_${item.MfgDate}_${item.expirydate}';

  //       if (!groupedItems.containsKey(key)) {
  //         groupedItems[key] = Documents(
  //           expirydate: expirydate,
  //           ManageBy: ManageBy,
  //           MfgDate: MfgDate,
  //           TagText: TagText,
  //           numAtCard: '',
  //           docEntry: item.docEntry,
  //           lineNum: item.lineNum,
  //           serialNum: item.serialNum,
  //           WhsCode: item.WhsCode,
  //           itemCode: item.itemCode,
  //           itemname: item.itemname,
  //           Unit_Quantity: item.Unit_Quantity,
  //           Pack_Quantity: item.Pack_Quantity,
  //           binCode: binCode,
  //           quantity: quantity,
  //           binlinelist: [],
  //         );
  //       }

  //       Documents groupedItem = groupedItems[key]!;

  //       // Sum the binqty to serialbatchqty
  //       groupedItem.quantity += item.quantity;

  //       // Update binlines
  //       for (var binline in item.binlinelist!) {
  //         binlines? existingBinline = groupedItem.binlinelist!.firstWhere(
  //             (bl) => bl.bincode == binline.bincode,
  //             orElse: () => binlines(bincode: binline.bincode, binqty: 0));
  //         if (groupedItem.binlinelist!.contains(existingBinline)) {
  //           existingBinline.binqty = existingBinline.binqty! + binline.binqty!;
  //         } else {
  //           groupedItem.binlinelist!.add(
  //               binlines(bincode: binline.bincode, binqty: binline.binqty));
  //         }
  //       }
  //     }

  //     return groupedItems.values.toList();
  //   }
}

class binlines {
  String? bincode;
  int? binqty;
  binlines({
    required this.bincode,
    required this.binqty,
  });
  Map<String, dynamic> tojson2() {
    Map<String, dynamic> map = {
      "bincode": bincode == '' || bincode == null ? null : bincode,
      "binqty": bincode == '' || bincode == null ? 0 : binqty,
    };
    return map;
  }
}
