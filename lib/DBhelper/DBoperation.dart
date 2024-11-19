import 'dart:developer';

import 'package:WareSmart/DBModel/batchDBmodel.dart';
import 'package:WareSmart/DBModel/inwardbackupDBModel.dart';
import 'package:WareSmart/DBModel/putawayDBModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:WareSmart/DBModel/inwardDBmodel.dart';

class DBoperation {
  static Future insert(Documents values, Database db) async {
    // final Database db = await createDB();
    final id = await db.insert(tablename, values.toMap());
     print("result: $id");
  }
  static Future insertbackup(Documentsbackup values, Database db) async {
    // final Database db = await createDB();
    final id = await db.insert(tablenamebackup, values.toMap());
     print("result: $id");
  }

  static Future<int?> serialExists(
      String docEntry, String serial, Database db) async {
    //  final Database db = await createDB();
    var result = await db.rawQuery(
      "SELECT count(*) cnt FROM wmsinward WHERE DocEntry = '$docEntry' AND SerialNum ='$serial'",
    );
    print("alredy serial: $result");
    int? exists = Sqflite.firstIntValue(result);
    print("alredy serial present: $exists");
    return exists; //its retur 1 if its present
  }

  static Future<void> delete(
      int docEntry, String itemCode, String lineNO, Database db) async {
    // final Database db = await createDB();
    var id = await db.rawQuery(
      "DELETE FROM wmsinward WHERE DocEntry='$docEntry' AND ItemCode ='$itemCode' AND LineNum = '$lineNO'",
    );
    // print("delete id: "+id.toString());
  }

  static Future<void> deletedocentry(
      int docEntry, Database db) async {
    // final Database db = await createDB();
    var id = await db.rawQuery(
      "DELETE FROM wmsinward WHERE DocEntry='$docEntry'",
    );
    // print("delete id: "+id.toString());
  }
  // static Future<void> deletedocentrybackup(
  //     int docEntry, Database db) async {
  //   // final Database db = await createDB();
  //   var id = await db.rawQuery(
  //     "DELETE FROM wmsinwardbackup WHERE DocEntry='$docEntry'",
  //   );
  //   // print("delete id: "+id.toString());
  // }

  static Future<List<Documents>> getBinAndSerailNo(
      String docEntry, String itemCode,int? linenum, Database db) async {
    //  final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
      "SELECT * FROM wmsinward WHERE DocEntry = '$docEntry' AND ItemCode ='$itemCode' AND LineNum ='$linenum'",
    );
    print("result: $result");
    // print("result length : present ${result.length}");

    return List.generate(result.length, (i) {
      return Documents(
        itemname:  result[i]['ItemName'].toString(),
        ManageBy: result[i]['ManageBy'].toString(),
        MfgDate: result[i]['MfgDate'].toString(),
        Pack_Quantity: double.parse(result[i]['Pack_Quantity'].toString()),
        Unit_Quantity: double.parse(result[i]['Unit_Quantity'].toString()),
        TagText: result[i]['TagText'].toString(),
        WhsCode: result[i]['WhsCode'].toString(),
        binCode: result[i]['BinCode'].toString(),
        docEntry: int.parse(result[i]['DocEntry'].toString()),
        itemCode: result[i]['ItemCode'].toString(),
        lineNum: int.parse(result[i]['LineNum'].toString()),
        numAtCard: result[i]['NumAtCard'].toString(),
        serialNum: result[i]['SerialNum'].toString(),
        quantity: double.parse(result[i]['Quantity'].toString()),
        expirydate: result[i]['Expirydate'].toString(),
      );
    });
  }

  static Future<int> getoverallcount(
      Database db, String? docentry, String? itemcode,int? linenum) async {
    log("docentry::" + docentry.toString());
    var result = await db.rawQuery(
        "select SUM(Quantity) AS TotalQuantity from wmsinward where DocEntry='$docentry' AND ItemCode='$itemcode' AND LineNum='$linenum' group by Docentry,ItemCode");
    log("result::" + result.toString());
    if (result.isNotEmpty) {
      return result.first['TotalQuantity'] as int? ?? 0;
    } else {
      return 0;
    }
  }

  static Future<int?> uidExists(
      String docEntry, String itemCode, String lineNO, Database db) async {
    //  final Database db = await createDB();
    var result = await db.rawQuery(
      "SELECT * FROM wmsinward WHERE DocEntry = '$docEntry' AND ItemCode ='$itemCode' AND LineNum = '$lineNO'",
    );
    print("result123123: present $result");
    int? exists = Sqflite.firstIntValue(result);
    //    print("data: present $exists");
    return exists; //its retur 1 if its present
  }
static   Future<List<Documents>>  saveAllData(String docEntry,Database db) async {
        //  final Database db = await createDB();
          final List<Map<String, Object?>> result = await db.rawQuery(
            'SELECT * FROM wmsinward WHERE DocEntry = "$docEntry"',
          );
           print("result: $result");
          //  print("result length : present ${result.length}");

         return List.generate(result.length, (i) {
      return Documents(
         itemname:  result[i]['ItemName'].toString(),
         ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()
        );});
}
static   Future<List<Documentsbackup>>  saveAllDatafinal2222(String docEntry,String itemCode, String lineNO,Database db) async {
        //  final Database db = await createDB();
          final List<Map<String, Object?>> result = await db.rawQuery(
            'SELECT * FROM wmsinwardbackup WHERE DocEntry = "$docEntry" AND ItemCode ="$itemCode" AND LineNum = "$lineNO" ',
          );
           print("resultfinal: $result");
          //  print("result length : present ${result.length}");

         return List.generate(result.length, (i) {
      return Documentsbackup(
         itemname:  result[i]['ItemName'].toString(),
         ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()
        );});
}
static   Future<List<Documents>>  saveAllDatafinal(String docEntry,String itemCode, String lineNO,Database db) async {
        //  final Database db = await createDB();
          final List<Map<String, Object?>> result = await db.rawQuery(
            'SELECT * FROM wmsinward WHERE DocEntry = "$docEntry" AND ItemCode ="$itemCode" AND LineNum = "$lineNO" ',
          );
           print("resultfinal: $result");
          //  print("result length : present ${result.length}");

         return List.generate(result.length, (i) {
      return Documents(
         itemname:  result[i]['ItemName'].toString(),
         ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()
        );});
}

static   Future<List<Documents>>  saveAllDataBin(String docEntry,Database db) async {
        //  final Database db = await createDB();
          final List<Map<String, Object?>> result = await db.rawQuery(
            'SELECT * FROM wmsinward WHERE DocEntry = "$docEntry" AND BinCode IS NOT NULL AND BinCode <> '' ',
          );
           print("resultbinnn: $result");
          //  print("result length : present ${result.length}");

         return List.generate(result.length, (i) {
      return Documents(
         itemname:  result[i]['ItemName'].toString(),
         ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()
        );});
}

static Future<List<Documents>> getProductsbatch(
      Database db, String? docentry,String? itemcode,String? bincode,String? serialnum) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From wmsinward where DocEntry='$docentry' AND ItemCode='$itemcode' AND BinCode='$bincode' AND SerialNum='$serialnum'
""");
    log("lllll::" + result.toString());
    return List.generate(
        result.length,
        (i) => Documents(
           itemname:  result[i]['ItemName'].toString(),
            ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity:result[i]['Pack_Quantity'] ==null?0.0: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity:result[i]['Unit_Quantity'] ==null?0.0: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()));
  }



  static Future<List<Documents>> getAllProducts(
      Database db, String? docentry,) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From wmsinward where DocEntry='$docentry'
""");
    log("lllll::" + result.toString());
    return List.generate(
        result.length,
        (i) => Documents(
           itemname:  result[i]['ItemName'].toString(),
            ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity:result[i]['Pack_Quantity'] ==null?0.0: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity:result[i]['Unit_Quantity'] ==null?0.0: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()));
  }
 static Future<List<Documents>> getAllProductsdash(
      Database db,) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From wmsinward
""");
    log("lllllbbbb::" + result.toString());
    return List.generate(
        result.length,
        (i) => Documents(
           itemname:  result[i]['ItemName'].toString(),
            ManageBy: result[i]['ManageBy'].toString(),
            MfgDate: result[i]['MfgDate'].toString(),
            Pack_Quantity:result[i]['Pack_Quantity'] ==null?0.0: double.parse(result[i]['Pack_Quantity'].toString()),
            Unit_Quantity:result[i]['Unit_Quantity'] ==null?0.0: double.parse(result[i]['Unit_Quantity'].toString()),
            TagText: result[i]['TagText'].toString(),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            lineNum: int.parse(result[i]['LineNum'].toString()),
            numAtCard: result[i]['NumAtCard'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),
            expirydate: result[i]['Expirydate'].toString()));
  }

 static Future<int?> putawayExists(
      int DocNum, String serialNum,int quantity, Database db) async {
        log("hhs::"+quantity.toString());
    //  final Database db = await createDB();
    var result = await db.rawQuery(
      "SELECT * FROM wmsputaway WHERE DocNum = '$DocNum' AND serialNum ='$serialNum' AND Quantity ='$quantity'",
    );
    print("result123123: present $result");
    int? exists = Sqflite.firstIntValue(result);
    //    print("data: present $exists");
    return exists; //its retur 1 if its present
  }

  static Future<int?> putBatchExists(
      int DocNum, String serialNum, Database db) async {
        // log("hhs::"+quantity.toString());
    //  final Database db = await createDB();
    var result = await db.rawQuery(
      "SELECT * FROM wmsputbatch WHERE DocNum = '$DocNum' AND SerialBatchCode ='$serialNum'",
    );
    print("result123123: present $result");
    int? exists = Sqflite.firstIntValue(result);
    //    print("data: present $exists");
    return exists; //its retur 1 if its present
  }
   static updateBatch(int count, bool isdone,String serialcode,String bincode, String? id,Database db) async {
    log("countcount"+count.toString());
   
    final List<Map<String, Object?>> result = await db.rawQuery('''
      UPDATE $tablebatch
    SET SerialBatchQty = "$count", Isdone = '$isdone', Localbincode='$bincode' WHERE SerialBatchCode='$serialcode' AND ID='$id'
    ''');
    log("result::"+result.toString());
  }
   static updateBatchexist(int id,int count,String serialcode,String bincode, Database db) async {
    log("idididid"+id.toString());
    if(id ==null){
final List<Map<String, Object?>> result3 =await db.rawQuery('''delete from wmsputbatch where SerialBatchCode ='$serialcode' ''');
   log("result2::"+result3.toString());
    }else{
final List<Map<String, Object?>> result3 =await db.rawQuery('''delete from wmsputbatch where Id='$id' ''');
   log("result2::"+result3.toString());
  final List<Map<String, Object?>> result2 =await db.rawQuery('''select sum(SerialBatchQty) As existingcount from wmsputbatch where SerialBatchCode='$serialcode' ''');
   log("result2::"+result2.toString());
   int countexisting =int.parse(result2[0]['existingcount'].toString());
   int finalcount=count+countexisting;
   log("countexisting::"+countexisting.toString());
    final List<Map<String, Object?>> result = await db.rawQuery('''
     
      UPDATE $tablebatch
    SET Localbincode='$bincode' ,SerialBatchQty = '$finalcount' WHERE SerialBatchCode='$serialcode'
    ''');
    log("result::"+result.toString());
    }
     
  }
  static Future<void> putawaydelete(
      int DocNum, String SerialBatchCode, int serialqty,Database db) async {
    // final Database db = await createDB();
    var id = await db.rawQuery(
      "DELETE FROM wmsputaway WHERE DocNum='$DocNum' AND serialNum ='$SerialBatchCode' AND Quantity='$serialqty' ",
    );
    // print("delete id: "+id.toString());
  }
  static Future<void> putawaydeleteAll( Database db) async {
    // final Database db = await createDB();
    var id = await db.rawQuery(
      "DELETE FROM wmsputaway",
    );
    // print("delete id: "+id.toString());
  }
   static Future<void> putbatchdelete(
      int DocNum, String SerialBatchCode, Database db) async {
    // final Database db = await createDB();
    var id = await db.rawQuery(
      "DELETE FROM wmsputbatch WHERE DocNum='$DocNum' AND serialNum ='$SerialBatchCode' ",
    );
    // print("delete id: "+id.toString());
  }
   static Future<void> putbatchdeleteAll( Database db) async {
    // final Database db = await createDB();
    var id = await db.rawQuery(
      "DELETE FROM wmsputbatch",
    );
    // print("delete id: "+id.toString());
  }

   static Future putbatchinsert(BatchDBlist values, Database db) async {
    // final Database db = await createDB();
    final id = await db.insert(tablebatch, values.toMap());
     print("resultbatch: $id");
  }
  static Future<List<BatchDBlist>> getAllputbatch(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From wmsputbatch
""");
    log("lllllbatch::" + result.toString());
    return List.generate(
        result.length,
        (i) => BatchDBlist(
          ID:int.parse(result[i]['Id'].toString()) ,
          BinCode: result[i]['BinCode'].toString(), 
          BinQty:double.parse(result[i]['BinQty'].toString()) , 
          TagText: result[i]['TagText'].toString(), 
          Pref_Bin: result[i]['Pref_Bin'].toString(), 
          DocDate: result[i]['DocDate'].toString(), 
          Item_LineNum:int.parse(result[i]['Item_LineNum'].toString()) , 
          SerialBatch_LineNum:int.parse(result[i]['SerialBatch_LineNum'].toString()) , 
          isselected:result[i]['Isselected'].toString()==1 ?true:false , 
          isdone:result[i]['Isdone'].toString()==1 ?true:false ,  
          AutoID:int.parse(result[i]['AutoID'].toString()) , 
          DocEntry:int.parse(result[i]['DocEntry'].toString()) , 
          DocNum:int.parse(result[i]['DocNum'].toString()) , 
          InwardType: result[i]['InwardType'].toString(), 
          ItemCode: result[i]['ItemCode'].toString(), 
          ItemName: result[i]['ItemName'].toString(), 
          ManageBy: result[i]['ManageBy'].toString(), 
          Open_Putaway:double.parse(result[i]['Open_Putaway'].toString()) , 
          Putaway_Qty:double.parse(result[i]['Putaway_Qty'].toString()) , 
          SerialBatchCode: result[i]['SerialBatchCode'].toString(), 
          SerialBatchQty:double.parse(result[i]['SerialBatchQty'].toString()) , 
          SupplierCode: result[i]['SupplierCode'].toString(), 
          SupplierName: result[i]['SupplierName'].toString(), 
          Unit_Quantity:double.parse(result[i]['Unit_Quantity'].toString()) , 
          WhsCode: result[i]['WhsCode'].toString(), 
          localbincode: result[i]['Localbincode'].toString()
          ));
  }
   static Future putawayinsert(Documentsputaway values, Database db) async {
    // final Database db = await createDB();
    final id = await db.insert(tableputaway, values.toMap());
     print("result: $id");
  }
  static Future<List<Documentsputaway>> getAllputaway(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From wmsputaway
""");
    log("lllllputaway::" + result.toString());
    return List.generate(
        result.length,
        (i) => Documentsputaway(
          itemname:  result[i]['ItemName'].toString(),
          tagText: result[i]['TagText'].toString(),
          linenum: int.parse(result[i]['Linenum'].toString()),
          seriallinenum: int.parse(result[i]['Seriallinenum'].toString()),
          packquantity: double.parse(result[i]['Packquantity'].toString()),
          DocNum: int.parse(result[i]['DocNum'].toString()),
            ManageBy: result[i]['ManageBy'].toString(),
            SerialBatchQty: double.parse(result[i]['SerialBatchQty'].toString()),
            Unit_Quantity: double.parse(result[i]['Unit_Quantity'].toString()),
            WhsCode: result[i]['WhsCode'].toString(),
            binCode: result[i]['BinCode'].toString(),
            docEntry: int.parse(result[i]['DocEntry'].toString()),
            itemCode: result[i]['ItemCode'].toString(),
            serialNum: result[i]['SerialNum'].toString(),
            quantity: double.parse(result[i]['Quantity'].toString()),));
  }
}
