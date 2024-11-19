// ignore_for_file: file_names
import 'package:WareSmart/constant/config.dart';
import 'package:uuid/uuid.dart';

const String tableputaway = "wmsputaway";

class Columnsputaway {
  static const String docEntry = "DocEntry";
  static const String DocNum = "DocNum";
  static const String itemCode = "ItemCode";
  static const String binCode = "BinCode";
  static const String serialNum = "SerialNum";
  static const String quantity = "Quantity";
  static const String manageBy = "ManageBy";
  static const String whsCode = "WhsCode";
  static const String unit_Quantity = "Unit_Quantity";
  static const String SerialBatchQty = "SerialBatchQty";
  static const String linenum = "Linenum";
  static const String packquantity = "Packquantity";
  static const String seriallinenum = "Seriallinenum";
  static const String tagText = "TagText";
  static const String itemname = "ItemName";
  

//  static final String alterphone = "alterphone";
}

class Documentsputaway {
  final int docEntry;
  final int DocNum;
  final int linenum;
  final double packquantity;
final int seriallinenum;
final String tagText;
  final String itemCode;
  final String binCode;
  final String serialNum;
final String itemname;
  final double quantity;
  final String ManageBy;
  final String WhsCode;
  final double Unit_Quantity;
  final double SerialBatchQty;

//final int alterphone ;

  Documentsputaway(
      {
        required this.itemname,
        required this.tagText,
        required this.packquantity,
        required this.linenum,
        required this.seriallinenum,
        required this.binCode,
      required this.docEntry,
      required this.itemCode,
      required this.DocNum,
      required this.serialNum,
      required this.quantity,
      required this.ManageBy,
      required this.SerialBatchQty,
      required this.Unit_Quantity,
      required this.WhsCode});

  Map<String, Object?> toMap() => {
    Columnsputaway.itemname: itemname,
        Columnsputaway.docEntry: docEntry,
        Columnsputaway.DocNum: DocNum,
        Columnsputaway.itemCode: itemCode,
        Columnsputaway.binCode: binCode,
        Columnsputaway.serialNum: serialNum,
        Columnsputaway.quantity: quantity,
        Columnsputaway.manageBy: ManageBy,
        Columnsputaway.SerialBatchQty: SerialBatchQty,
        Columnsputaway.unit_Quantity: Unit_Quantity,
        Columnsputaway.whsCode: WhsCode,
         Columnsputaway.linenum: linenum,
          Columnsputaway.packquantity: packquantity,
           Columnsputaway.seriallinenum: seriallinenum,
            Columnsputaway.tagText: tagText,
      };

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      // "traceid":Uuid().v4(),
      "docentry": docEntry,
      "linenum": linenum,
    "serialbatch_linenum": seriallinenum,
     "pack_quantity":0.0,
      "itemcode": itemCode,
       "itemname":itemname,
      "bincode": binCode,
      "serialbatchcode": serialNum,
      "serialbatchqty": SerialBatchQty,
      "manageby": ManageBy,
      "whscode": WhsCode,
      "unit_quantity": 0.0,
      "tagtext": tagText,
      "binqty": quantity
       
    
   
   
    
   
    
    };
    return map;
  }
}
