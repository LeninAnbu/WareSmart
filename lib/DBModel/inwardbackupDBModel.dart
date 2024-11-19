

// ignore_for_file: file_names
import 'package:WareSmart/constant/config.dart';

const String tablenamebackup = "wmsinwardbackup";
class Columnsbackup{
 static const String docEntry = "DocEntry";
 static const String numAtCard = "NumAtCard";
 static const String lineNum = "LineNum";
 static const String itemCode = "ItemCode";
 static const String binCode = "BinCode";
 static const String serialNum = "SerialNum";
 
  static const String itemName = "ItemName";
 static const String expirydate = "Expirydate";
 static const String quantity = "Quantity";
 static const String manageBy = "ManageBy";
 static const String whsCode = "WhsCode";
 static const String unit_Quantity = "Unit_Quantity";
 static const String pack_Quantity = "Pack_Quantity";
 static const String tagText = "TagText";
 static const String mfgDate = "MfgDate";


//  static final String alterphone = "alterphone";
}
class Documentsbackup{
final int docEntry;
final String numAtCard ;
final int lineNum ;
final String itemCode;

final String itemname;
final String binCode ;
final String serialNum ;
final String expirydate;
 double quantity;
final String ManageBy;
final String WhsCode;
final double Unit_Quantity;
final double Pack_Quantity;
final String TagText;
final String MfgDate;
//final int alterphone ;

Documentsbackup({
  required this.binCode, 
  required this.docEntry,
  required this.itemCode,
   required this.itemname,
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
  required this.WhsCode
});

Map<String , Object?> toMap()=>{
  Columnsbackup.docEntry:docEntry,
  Columnsbackup.numAtCard:numAtCard,
  Columnsbackup.lineNum:lineNum,
  Columnsbackup.itemCode:itemCode,
  Columnsbackup.binCode:binCode,
  Columnsbackup.serialNum:serialNum,
  Columnsbackup.expirydate:expirydate,
  Columnsbackup.quantity:quantity,
  Columnsbackup.manageBy:ManageBy,
  Columnsbackup.mfgDate:MfgDate,
  Columnsbackup.pack_Quantity:Pack_Quantity,
  Columnsbackup.tagText:TagText,
  Columnsbackup.unit_Quantity:Unit_Quantity,
  Columnsbackup.whsCode:WhsCode,
};

 Map<String, dynamic> tojson() {
  Map<String, dynamic> map = {
        "DocEntry": docEntry,
        "ItemCode": itemCode,
        "BinLocation": binCode,
        "SerialBatchCode": serialNum,
        "LineNum": lineNum.toString(),
         "SerialBatchQty": quantity,
         "ExpiryDate": expirydate==''?null:Config.alignexpiry(expirydate) ,
          "ManageBy": ManageBy,
        "WhsCode": WhsCode,
        "Unit_Quantity": Unit_Quantity,
        "Pack_Quantity": Pack_Quantity,
        "TagText":TagText,
        "MfgDate": MfgDate,
        
         
       
       
        
      };
     return map;
  }
}