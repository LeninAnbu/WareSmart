
// ignore_for_file: prefer_conditional_assignment

import 'dart:developer';

import 'package:WareSmart/DBModel/batchDBmodel.dart';
import 'package:WareSmart/DBModel/inwardbackupDBModel.dart';
import 'package:WareSmart/DBModel/putawayDBModel.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:WareSmart/DBModel/inwardDBmodel.dart';

class DBhelper{
  static Database? _db;
  DBhelper._(){}
  static Future<Database?> getinstance()async{
    String path =await getDatabasesPath();
    log("path::"+path.toString());
    if(_db ==null){
      _db =await openDatabase(join(path,'waresmart.db'),
      version: 1,onCreate: createTable
      );
    }
    return _db;

  }
  static void createTable (Database database,int version)async{
     await database.execute('''
           create table $tablename(
             Id integer primary key autoincrement,
             ${Columns.docEntry} integer,
             ${Columns.numAtCard} varchar,
             ${Columns.lineNum} integer,
             ${Columns.itemCode} varchar,
             ${Columns.binCode} varchar,
             ${Columns.serialNum} varchar,
             ${Columns.quantity} decimal,
             ${Columns.expirydate} varchar,
             ${Columns.manageBy} varchar,
             ${Columns.whsCode} varchar,
             ${Columns.unit_Quantity} decimal,
             ${Columns.pack_Quantity} decimal,
             ${Columns.tagText} varchar,
             ${Columns.mfgDate} varchar,
             ${Columns.itemName} varchar
             )
        ''' );
        await database.execute('''
           create table $tablenamebackup(
             Id integer primary key autoincrement,
             ${Columnsbackup.docEntry} integer,
             ${Columnsbackup.numAtCard} varchar,
             ${Columnsbackup.lineNum} integer,
             ${Columnsbackup.itemCode} varchar,
             ${Columnsbackup.binCode} varchar,
             ${Columnsbackup.serialNum} varchar,
             ${Columnsbackup.quantity} decimal,
             ${Columnsbackup.expirydate} varchar,
             ${Columnsbackup.manageBy} varchar,
             ${Columnsbackup.whsCode} varchar,
             ${Columnsbackup.unit_Quantity} decimal,
             ${Columnsbackup.pack_Quantity} decimal,
             ${Columnsbackup.tagText} varchar,
             ${Columnsbackup.mfgDate} varchar,
             ${Columnsbackup.itemName} varchar
             )
        ''' );
        await database.execute('''
           create table $tableputaway(
             Id integer primary key autoincrement,
             ${Columnsputaway.docEntry} integer,
             ${Columnsputaway.DocNum} integer,
             ${Columnsputaway.itemCode} varchar,
             ${Columnsputaway.itemname} varchar,
             ${Columnsputaway.binCode} varchar,
             ${Columnsputaway.serialNum} varchar,
             ${Columnsputaway.quantity} decimal,
             ${Columnsputaway.manageBy} varchar,
             ${Columnsputaway.whsCode} varchar,
             ${Columnsputaway.unit_Quantity} decimal,
             ${Columnsputaway.SerialBatchQty} decimal,
             ${Columnsputaway.linenum} integer,
             ${Columnsputaway.packquantity} decimal,
             ${Columnsputaway.seriallinenum} integer,
             ${Columnsputaway.tagText} varchar
             )
        ''' );
        await database.execute('''
           create table $tablebatch(
             Id integer primary key autoincrement,
             ${Columnsbatch.docEntry} integer,
             ${Columnsbatch.docNum} integer,
             ${Columnsbatch.item_LineNum} integer,
             ${Columnsbatch.serialBatch_LineNum} integer,
             ${Columnsbatch.autoID} integer,
             ${Columnsbatch.inwardType} varchar,
             ${Columnsbatch.supplierCode} varchar,
             ${Columnsbatch.supplierName} varchar,
             ${Columnsbatch.whsCode} varchar,
             ${Columnsbatch.itemCode} varchar,
             ${Columnsbatch.itemName} varchar,
             ${Columnsbatch.unit_Quantity} decimal,
             ${Columnsbatch.serialBatchCode} varchar,
             ${Columnsbatch.serialBatchQty} decimal,
             ${Columnsbatch.putaway_Qty} decimal,
             ${Columnsbatch.open_Putaway} decimal,
             ${Columnsbatch.manageBy} varchar,
             ${Columnsbatch.isselected} varchar,
             ${Columnsbatch.isdone} varchar,
             ${Columnsbatch.localbincode} varchar,
             ${Columnsbatch.docDate} varchar,
             ${Columnsbatch.pref_Bin} varchar,
             ${Columnsbatch.binCode} varchar,
             ${Columnsbatch.binQty} decimal,
             ${Columnsbatch.tagText} varchar
             )
        ''' );
  }


}