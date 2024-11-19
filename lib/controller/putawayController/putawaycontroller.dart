import 'dart:developer';

import 'package:WareSmart/DBModel/batchDBmodel.dart';
import 'package:WareSmart/DBModel/putawayDBModel.dart';
import 'package:WareSmart/DBhelper/DBoperation.dart';
import 'package:WareSmart/Model/InwardModel/BinmasterModel.dart';
import 'package:WareSmart/Model/PutAwayModel/putawayModel.dart';
import 'package:WareSmart/Services/InwardApi/BinMasterApi.dart';
import 'package:WareSmart/Services/PutawayApi/getputaway.dart';
import 'package:WareSmart/Services/PutawayApi/putawaysave.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

import '../../DBhelper/DBhelper.dart';

class putawaycontroller extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  init() {
    clearAll();
    Getputaway();
    // GetBinMaster();
  }

  List<BinDetaildetlist> Bincodelist = [];
  GetBinMaster() async {
    Bincodelist.clear();
    notifyListeners();
    // isloading = true;
    // notifyListeners();
    // Future.delayed(const Duration(seconds: 3), () {
    await BinMasterApi.getdata().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.binDetailheader!.itemlist != null &&
            value.binDetailheader!.itemlist!.isNotEmpty) {
          Bincodelist = value.binDetailheader!.itemlist!;

          isloading = false;
          putexception = '';
          log("Bincodelist::" + Bincodelist.length.toString());
          notifyListeners();
        } else if (value.binDetailheader!.itemlist == null ||
            value.binDetailheader!.itemlist!.isEmpty) {
          isloading = false;
          putexception = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        putexception = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading = false;
          putexception =
              "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading = false;
          putexception = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
    // });
  }

  List<putawayDetList> putawaylist = [];
  List<putawayDetList> Allputawaylist = [];
  List<putawayDetList> selectedputawaylist = [];
  List<putawayDetList> filterputawaylist = [];
  bool isloading = false;
  String putexception = '';
  String get getinwexception => putexception;
  Getputaway() async {
    Allputawaylist.clear();
    putawaylist.clear();
    filterputawaylist.clear();
    isloading = true;
    notifyListeners();
    await GetPutawayApi.getdata().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.putawayheader!.putawaylist != null &&
            value.putawayheader!.putawaylist!.isNotEmpty) {
          Allputawaylist = value.putawayheader!.putawaylist!;
          putawaylist = value.putawayheader!.putawaylist!;
          filterputawaylist = putawaylist;
          log("Allputawaylist::" + Allputawaylist.length.toString());
          // checkDB(Allputawaylist);
          checkdb2();
          // filterputawaylist = putawaylist;
          // isloading = false;
          // mapvalues(value.inwardDetailheader!.itemlist!);
          putexception = '';

          log("pendinglist::" + putawaylist.length.toString());
          notifyListeners();
        } else if (value.putawayheader!.putawaylist == null ||
            value.putawayheader!.putawaylist!.isEmpty) {
          isloading = false;
          putexception = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        putexception = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading = false;
          putexception =
              "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading = false;
          putexception = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
  }

  checkdb2() async {
    DBlist.clear();
    batchinsertlist.clear();
    final Database db = (await DBhelper.getinstance())!;
    DBlist = await DBoperation.getAllputaway(db);
    batchinsertlist = await DBoperation.getAllputbatch(db);

    if (DBlist.isNotEmpty) {
      for (int i = 0; i < DBlist.length; i++) {
        if (DBlist[i].ManageBy.toLowerCase() != 's') {
          checkdbexistbatch(DBlist[i]);
        } else {
          checkdbexist(DBlist[i]);
        }
      }
    }
    if (batchinsertlist.isNotEmpty) {
      for (int i = 0; i < DBlist.length; i++) {
        await addbatchlist(DBlist[i]);
      }
    }
    await GetBinMaster();
    await addbatchfinal();
  }

  addbatchfinal() {
    if (batchinsertlist.isNotEmpty) {
      log("batchinsertlist::" + batchinsertlist.length.toString());
      for (int i = 0; i < batchinsertlist.length; i++) {
        Allputawaylist.add(putawayDetList(
            ID: batchinsertlist[i].ID,
            BinCode: batchinsertlist[i].BinCode,
            BinQty: batchinsertlist[i].BinQty,
            TagText: batchinsertlist[i].TagText,
            Pref_Bin: batchinsertlist[i].Pref_Bin,
            DocDate: batchinsertlist[i].DocDate,
            Item_LineNum: batchinsertlist[i].Item_LineNum,
            SerialBatch_LineNum: batchinsertlist[i].SerialBatch_LineNum,
            isselected: batchinsertlist[i].isselected,
            isdone: batchinsertlist[i].isdone,
            AutoID: batchinsertlist[i].AutoID,
            DocEntry: batchinsertlist[i].DocEntry,
            DocNum: batchinsertlist[i].DocNum,
            InwardType: batchinsertlist[i].InwardType,
            ItemCode: batchinsertlist[i].ItemCode,
            ItemName: batchinsertlist[i].ItemName,
            ManageBy: batchinsertlist[i].ManageBy,
            Open_Putaway: batchinsertlist[i].Open_Putaway,
            Putaway_Qty: batchinsertlist[i].Putaway_Qty,
            SerialBatchCode: batchinsertlist[i].SerialBatchCode,
            SerialBatchQty: batchinsertlist[i].SerialBatchQty,
            SupplierCode: batchinsertlist[i].SupplierCode,
            SupplierName: batchinsertlist[i].SupplierName,
            Unit_Quantity: batchinsertlist[i].Unit_Quantity,
            WhsCode: batchinsertlist[i].WhsCode,
            localbincode: batchinsertlist[i].localbincode));
      }
    }
  }

  showdialogsave(
      BuildContext context, String? image, String title, String body) {
    showDialog(
        context: context,
        builder: (_) {
          final theme = Theme.of(context);
          return StatefulBuilder(builder: (context, setst) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: Screens.padingHeight(context) * 0.13,
                      width: Screens.width(context),
                      decoration: BoxDecoration(
                          // color:Colors.green,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Center(
                        child: Container(
                          child: Image.asset(
                            "$image", //Asset/check.png
                            height: Screens.padingHeight(context) * 0.1,
                            width: Screens.width(context) * 0.2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: Screens.padingHeight(context)*0.2,
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.01,
                          vertical: Screens.padingHeight(context) * 0.005),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "$title",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          Container(
                            child: Text(
                              "$body",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setst(() {
                                  if (title.contains("Success")) {
                                    Get.offAllNamed(ConstantRoutes.dashboard);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              child: Text("ok"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  deleteall() async {
    final Database db = (await DBhelper.getinstance())!;
    await DBoperation.putawaydeleteAll(db);
    await DBoperation.putbatchdeleteAll(db);
    notifyListeners();
  }

  bool finallodaing = false;
  savefinal(BuildContext context) async {
    final Database db = (await DBhelper.getinstance())!;
    finallodaing = true;
    notifyListeners();
    await DBoperation.getAllputaway(db).then((value) async {
      log("value" + value.toString());
      if (value.isEmpty) {
        finallodaing = false;
        notifyListeners();
        final audio = AudioPlayer();
        await audio.setAsset("Asset/scan_serial_wrong.mp3");
        audio.play();
        showdialogtoast(context, "There is no scan details..!!");
        notifyListeners();
      } else {
        await PutawaysaveApi.getData(value).then((value) async {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            finallodaing = false;
            notifyListeners();
            final audio = AudioPlayer();

            audio.setAsset("Asset/next_click.mp3");
            audio.play();
            //  savelistinwardState().  playsound("next_click");
            showdialogsave(context, "Asset/check.png", "Success",
                value.exception.toString());
            await DBoperation.putawaydeleteAll(db);
            notifyListeners();
          } else if (value.stcode! >= 400 && value.stcode! <= 410) {
            finallodaing = false;
            notifyListeners();
            final audio = AudioPlayer();
            audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
            //  savelistinwardState().    playsound("Invalid_bin");
            showdialogsave(context, "Asset/cancel.png", "Failed",
                "${value.message}..${value.exception.toString()}");
            notifyListeners();
          } else {
            if (value.exception!.contains("Network is unreachable")) {
              finallodaing = false;
              final audio = AudioPlayer();
              audio.setAsset("Asset/Invalid_bin.mp3");
              audio.play();
              // savelistinwardState(). playsound("Invalid_bin");
              showdialogsave(context, "Asset/cancel.png", "Failed",
                  "Network Issue..Try again Later..!!");
              // inwexception2 =
              //     "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
              notifyListeners();
            } else {
              finallodaing = false;
              final audio = AudioPlayer();
              audio.setAsset("Asset/Invalid_bin.mp3");
              audio.play();
              // savelistinwardState().  playsound("Invalid_bin");
              showdialogsave(context, "Asset/cancel.png", "Failed",
                  "${value.stcode}..${value.exception}..!!");

              // inwexception2 = "${value.stcode}..${value.exception}..!!";
              notifyListeners();
            }
          }
        });
      }
    });
    //  await DBoperation.putawaydeleteAll( db);
    notifyListeners();
  }

  addbatchlist(Documentsputaway DBlist) {
    log("DBlist::" + DBlist.serialNum.toString());
    log("DBlist::" + DBlist.SerialBatchQty.toString());
    if (batchinsertlist.isNotEmpty) {
      log("batchinsertlist::" + batchinsertlist.length.toString());
      for (int i = 0; i < batchinsertlist.length; i++) {
        log("batchinsertlist[i].BinCode::" +
            batchinsertlist[i].BinCode.toString());
        if (batchinsertlist[i].DocNum == DBlist.DocNum &&
            batchinsertlist[i].SerialBatchCode == DBlist.serialNum &&
            batchinsertlist[i].SerialBatchQty == DBlist.quantity ) {
          batchinsertlist[i].isdone = true;
          batchinsertlist[i].localbincode = DBlist.binCode;
        } else if (batchinsertlist[i].DocNum == DBlist.DocNum &&
            batchinsertlist[i].SerialBatchCode == DBlist.serialNum &&
            batchinsertlist[i].SerialBatchQty! > DBlist.quantity  ) {
//  batchinsertlist[i].isdone =true;
          // batchinsertlist[i].localbincode=DBlist.binCode;
          //  batchinsertlist[i].SerialBatchQty =DBlist.quantity;
        }
      }
    }
  }

  checkdbexistbatch(Documentsputaway DBlist) async {
    final Database db = (await DBhelper.getinstance())!;
    for (int i = 0; i < filterputawaylist.length; i++) {
      if (filterputawaylist[i].DocNum == DBlist.DocNum &&
          filterputawaylist[i].SerialBatchCode == DBlist.serialNum &&
          filterputawaylist[i].SerialBatchQty == DBlist.quantity && ( filterputawaylist[i].localbincode==null|| filterputawaylist[i].localbincode!.isEmpty)) {
        filterputawaylist[i].isdone = true;
        filterputawaylist[i].localbincode = DBlist.binCode;
      } else if (filterputawaylist[i].DocNum == DBlist.DocNum &&
          filterputawaylist[i].SerialBatchCode == DBlist.serialNum &&
          filterputawaylist[i].SerialBatchQty! > DBlist.quantity&& ( filterputawaylist[i].localbincode==null|| filterputawaylist[i].localbincode!.isEmpty)) {
        filterputawaylist[i].isdone = true;
        filterputawaylist[i].localbincode = DBlist.binCode;
        filterputawaylist[i].SerialBatchQty = DBlist.quantity;
      
      }
     
    }

    notifyListeners();
  }

  checkdbexist(Documentsputaway DBlist) {
    for (int i = 0; i < Allputawaylist.length; i++) {
      if (Allputawaylist[i].DocNum == DBlist.DocNum &&
          Allputawaylist[i].SerialBatchCode == DBlist.serialNum) {
        Allputawaylist[i].isdone = true;
        Allputawaylist[i].localbincode = DBlist.binCode;
      }
    }
    notifyListeners();
  }

  List<Documentsputaway> DBlist = [];
//   checkDB(List<putawayDetList> Allputawaylist) async {
//     isloading = true;
//     notifyListeners();
//     final Database db = (await DBhelper.getinstance())!;
//     // DBlist =await DBoperation.getAllputaway(db);
//     // if(DBlist.isNotEmpty){
//     for (int i = 0; i < Allputawaylist.length; i++) {
//      await  DBoperation.putawayExists(
//               Allputawaylist[i].DocNum!, Allputawaylist[i].SerialBatchCode!, db)
//           .then((value) {
//             isloading = true;
//     notifyListeners();
//         if (value == null) {
//           putawaylist.add(putawayDetList(
//               isselected: Allputawaylist[i].isselected,
//               isdone: Allputawaylist[i].isdone,
//               AutoID: Allputawaylist[i].AutoID,
//               DocEntry: Allputawaylist[i].DocEntry,
//               DocNum: Allputawaylist[i].DocNum,
//               InwardType: Allputawaylist[i].InwardType,
//               ItemCode: Allputawaylist[i].ItemCode,
//               ItemName: Allputawaylist[i].ItemName,
//               ManageBy: Allputawaylist[i].ManageBy,
//               Open_Putaway: Allputawaylist[i].Open_Putaway,
//               Putaway_Qty: Allputawaylist[i].Putaway_Qty,
//               SerialBatchCode: Allputawaylist[i].SerialBatchCode,
//               SerialBatchQty: Allputawaylist[i].SerialBatchQty,
//               SupplierCode: Allputawaylist[i].SupplierCode,
//               SupplierName: Allputawaylist[i].SupplierName,
//               Unit_Quantity: Allputawaylist[i].Unit_Quantity,
//               WhsCode: Allputawaylist[i].WhsCode));
//         } else {
//           putawaylist.add(putawayDetList(
//               isselected: Allputawaylist[i].isselected,
//               isdone: true,
//               AutoID: Allputawaylist[i].AutoID,
//               DocEntry: Allputawaylist[i].DocEntry,
//               DocNum: Allputawaylist[i].DocNum,
//               InwardType: Allputawaylist[i].InwardType,
//               ItemCode: Allputawaylist[i].ItemCode,
//               ItemName: Allputawaylist[i].ItemName,
//               ManageBy: Allputawaylist[i].ManageBy,
//               Open_Putaway: Allputawaylist[i].Open_Putaway,
//               Putaway_Qty: Allputawaylist[i].Putaway_Qty,
//               SerialBatchCode: Allputawaylist[i].SerialBatchCode,
//               SerialBatchQty: Allputawaylist[i].SerialBatchQty,
//               SupplierCode: Allputawaylist[i].SupplierCode,
//               SupplierName: Allputawaylist[i].SupplierName,
//               Unit_Quantity: Allputawaylist[i].Unit_Quantity,
//               WhsCode: Allputawaylist[i].WhsCode));
//         }
//       });
//       filterputawaylist = putawaylist;

// // log("filterputawaylist::"+filterputawaylist.length.toString());
//       notifyListeners();
//     }

//   }

  afterBinScanned(String code, BuildContext context) async {
    bool isbintrue = false;
    mycontroller[1].text = code;
    if (mycontroller[1].text.isEmpty) {
      final audio = AudioPlayer();
      await audio.setAsset("Asset/scan_serial_wrong.mp3");
      audio.play();
      showdialogtoast(context, "Enter Bincode..!!");
      mycontroller[1].clear();
    } else if (int.parse(mycontroller[2].text) > oringalqty!.toInt()) {
      final audio = AudioPlayer();
      await audio.setAsset("Asset/scan_serial_wrong.mp3");
      audio.play();
      showdialogtoast(context, "Greater then Quantity..!!");
      // mycontroller[2].clear();
    } else {
      if (Bincodelist.isNotEmpty) {
        for (int i = 0; i < Bincodelist.length; i++) {
          if (Bincodelist[i].BinCode!.toLowerCase() == code.toLowerCase()) {
            isbintrue = true;

            notifyListeners();
            break;
          }
        }
        if (isbintrue == true) {
          mycontroller[1].text = code;
          // final audio = AudioPlayer();
          // await audio.setAsset("Asset/bin_selection.mp3");
          // audio.play();
          inserttodb();
          FocusScope.of(context).unfocus();
          notifyListeners();
        } else {
          final audio = AudioPlayer();
          await audio.setAsset("Asset/scan_serial_wrong.mp3");
          audio.play();
          showdialogtoast(context, "Entered Bincode is not in Bin Master..!!");
          mycontroller[1].clear();
          notifyListeners();
        }
      } else {
        final audio = AudioPlayer();
        await audio.setAsset("Asset/scan_serial_wrong.mp3");
        audio.play();
        showdialogtoast(context, "Bin Master is Empty..!!");
        mycontroller[0].clear();
        notifyListeners();
      }
    }

    //  savelistinwardState(). playsound("bin_selection");
    notifyListeners();
  }

  List<BatchDBlist> batchinsertlist = [];
  inserttodb() async {
    final Database db = (await DBhelper.getinstance())!;
    var values;
    var value2;
    // batchinsert.clear();

    for (int i = 0; i < selectedputawaylist.length; i++) {
      if (selectedputawaylist[i].ManageBy!.toLowerCase() == 's') {
        var val = Documentsputaway(
            itemname: selectedputawaylist[i].ItemName!,
            tagText: selectedputawaylist[i].TagText!,
            linenum: selectedputawaylist[i].Item_LineNum!,
            seriallinenum: selectedputawaylist[i].SerialBatch_LineNum!,
            packquantity: selectedputawaylist[i].Putaway_Qty!,
            binCode: mycontroller[1].text,
            docEntry: selectedputawaylist[i].DocEntry!,
            itemCode: selectedputawaylist[i].ItemCode.toString(),
            DocNum: selectedputawaylist[i].DocNum!,
            serialNum: selectedputawaylist[i].SerialBatchCode.toString(),
            quantity: mycontroller[2].text.isEmpty
                ? 1
                : double.parse(mycontroller[2].text),
            ManageBy: selectedputawaylist[i].ManageBy.toString(),
            SerialBatchQty: selectedputawaylist[i].SerialBatchQty!,
            Unit_Quantity: selectedputawaylist[i].Unit_Quantity!,
            WhsCode: selectedputawaylist[i].WhsCode.toString());
        values = val;
        await DBoperation.putawayinsert(values, db).then((value) async {
          final audio = AudioPlayer();
          await audio.stop();

          await audio.setAsset("Asset/scan_serial_correct.mp3");
          audio.play();
          init();
          notifyListeners();
        });
      } else {
        await DBoperation.putBatchExists(selectedputawaylist[i].DocNum!,
                selectedputawaylist[i].SerialBatchCode!, db)
            .then((value) async {
          log("value::" + value.toString());
          if (value != null) {
            await DBoperation.getAllputbatch(db).then((valuess) async {
              log("hiii"+selectedputawaylist[i].SerialBatchCode.toString());
              for (int ik = 0; ik < valuess.length; ik++) {
                if (valuess[ik].SerialBatchCode ==
                        selectedputawaylist[i].SerialBatchCode &&
                    valuess[ik].SerialBatchQty! ==
                        double.parse(mycontroller[2].text) &&(valuess[ik].localbincode==null||valuess[ik].localbincode!.isEmpty)) {
                  var val = Documentsputaway(
                      itemname: valuess[ik].ItemName!,
                      tagText: valuess[ik].TagText!,
                      linenum: valuess[ik].Item_LineNum!,
                      seriallinenum: valuess[ik].SerialBatch_LineNum!,
                      packquantity: valuess[ik].Putaway_Qty!,
                      binCode: mycontroller[1].text,
                      docEntry: valuess[ik].DocEntry!,
                      itemCode: valuess[ik].ItemCode.toString(),
                      DocNum: valuess[ik].DocNum!,
                      serialNum: valuess[ik].SerialBatchCode.toString(),
                      quantity: mycontroller[2].text.isEmpty
                          ? 1
                          : double.parse(mycontroller[2].text),
                      ManageBy: valuess[ik].ManageBy.toString(),
                      SerialBatchQty: valuess[ik].SerialBatchQty!,
                      Unit_Quantity: valuess[ik].Unit_Quantity!,
                      WhsCode: valuess[ik].WhsCode.toString());
                  values = val;
                  await DBoperation.updateBatch(
                    int.parse(mycontroller[2].text),
                    true,
                    selectedputawaylist[i].SerialBatchCode!,
                    mycontroller[1].text,
                    valuess[ik].ID.toString(),
                    db,
                  );
                  await DBoperation.putawayinsert(values, db)
                      .then((value) async {
                    final audio = AudioPlayer();
                    await audio.stop();

                    await audio.setAsset("Asset/scan_serial_correct.mp3");
                    audio.play();
                    init();
                    notifyListeners();
                  });
                } else if (valuess[ik].SerialBatchCode ==
                        selectedputawaylist[i].SerialBatchCode &&
                    valuess[ik].SerialBatchQty! >
                        double.parse(mycontroller[2].text)&&(valuess[ik].localbincode==null||valuess[ik].localbincode!.isEmpty)) {
                  double? pendingcount = valuess[ik].SerialBatchQty! -
                      double.parse(mycontroller[2].text);
                  log("pendingcount::" + pendingcount.toString());
                  await DBoperation.updateBatch(
                      int.parse(mycontroller[2].text),
                      true,
                      selectedputawaylist[i].SerialBatchCode!,
                      mycontroller[1].text,
                      valuess[ik].ID.toString(),
                      db);
                  var val2 = BatchDBlist(
                      
                      BinCode: valuess[ik].BinCode,
                      BinQty: valuess[ik].BinQty,
                      TagText: valuess[ik].TagText,
                      Pref_Bin: valuess[ik].Pref_Bin,
                      DocDate: valuess[ik].DocDate,
                      Item_LineNum: valuess[ik].Item_LineNum,
                      SerialBatch_LineNum: valuess[ik].SerialBatch_LineNum,
                      isselected: valuess[ik].isselected,
                      isdone: false,
                      AutoID: valuess[ik].AutoID,
                      DocEntry: valuess[ik].DocEntry,
                      DocNum: valuess[ik].DocNum,
                      InwardType: valuess[ik].InwardType,
                      ItemCode: valuess[ik].ItemCode,
                      ItemName: valuess[ik].ItemName,
                      ManageBy: valuess[ik].ManageBy,
                      Open_Putaway: valuess[ik].Open_Putaway,
                      Putaway_Qty: valuess[ik].Putaway_Qty,
                      SerialBatchCode: valuess[ik].SerialBatchCode,
                      SerialBatchQty: pendingcount,
                      SupplierCode: valuess[ik].SupplierCode,
                      SupplierName: valuess[ik].SupplierName,
                      Unit_Quantity: valuess[ik].Unit_Quantity,
                      WhsCode: valuess[ik].WhsCode,
                      localbincode: valuess[ik].localbincode);
                  //  values2=val2;
                  var val = Documentsputaway(
                      itemname: selectedputawaylist[i].ItemName!,
                      tagText: selectedputawaylist[i].TagText!,
                      linenum: selectedputawaylist[i].Item_LineNum!,
                      seriallinenum:
                          selectedputawaylist[i].SerialBatch_LineNum!,
                      packquantity: selectedputawaylist[i].Putaway_Qty!,
                      binCode: mycontroller[1].text,
                      docEntry: selectedputawaylist[i].DocEntry!,
                      itemCode: selectedputawaylist[i].ItemCode.toString(),
                      DocNum: selectedputawaylist[i].DocNum!,
                      serialNum:
                          selectedputawaylist[i].SerialBatchCode.toString(),
                      quantity: mycontroller[2].text.isEmpty
                          ? 1.0
                          : double.parse(mycontroller[2].text),
                      ManageBy: selectedputawaylist[i].ManageBy.toString(),
                      SerialBatchQty: selectedputawaylist[i].SerialBatchQty!,
                      Unit_Quantity: selectedputawaylist[i].Unit_Quantity!,
                      WhsCode: selectedputawaylist[i].WhsCode.toString());
                  values = val;

                  await DBoperation.putbatchinsert(val2, db);
                  await DBoperation.putawayinsert(values, db)
                      .then((value) async {
                    final audio = AudioPlayer();
                    await audio.stop();

                    await audio.setAsset("Asset/scan_serial_correct.mp3");
                    audio.play();
                    init();
                    notifyListeners();
                  });
                }
              }
            });
          } else {
            if (selectedputawaylist[i].ManageBy!.toLowerCase() != 's' &&
                selectedputawaylist[i].SerialBatchQty! ==
                    double.parse(mycontroller[2].text)) {
              var val = Documentsputaway(
                  itemname: selectedputawaylist[i].ItemName!,
                  tagText: selectedputawaylist[i].TagText!,
                  linenum: selectedputawaylist[i].Item_LineNum!,
                  seriallinenum: selectedputawaylist[i].SerialBatch_LineNum!,
                  packquantity: selectedputawaylist[i].Putaway_Qty!,
                  binCode: mycontroller[1].text,
                  docEntry: selectedputawaylist[i].DocEntry!,
                  itemCode: selectedputawaylist[i].ItemCode.toString(),
                  DocNum: selectedputawaylist[i].DocNum!,
                  serialNum: selectedputawaylist[i].SerialBatchCode.toString(),
                  quantity: mycontroller[2].text.isEmpty
                      ? 1
                      : double.parse(mycontroller[2].text),
                  ManageBy: selectedputawaylist[i].ManageBy.toString(),
                  SerialBatchQty: selectedputawaylist[i].SerialBatchQty!,
                  Unit_Quantity: selectedputawaylist[i].Unit_Quantity!,
                  WhsCode: selectedputawaylist[i].WhsCode.toString());
              values = val;

              await DBoperation.putawayinsert(values, db).then((value) async {
                final audio = AudioPlayer();
                await audio.stop();

                await audio.setAsset("Asset/scan_serial_correct.mp3");
                audio.play();
                init();
                notifyListeners();
              });
            } else if (selectedputawaylist[i].ManageBy!.toLowerCase() != 's' &&
                selectedputawaylist[i].SerialBatchQty! >
                    double.parse(mycontroller[2].text)) {
              double? pendingcount = selectedputawaylist[i].SerialBatchQty! -
                  double.parse(mycontroller[2].text);
              log("pendingcount::" + pendingcount.toString());
              var val2 = BatchDBlist(
                
                  BinCode: selectedputawaylist[i].BinCode,
                  BinQty: selectedputawaylist[i].BinQty,
                  TagText: selectedputawaylist[i].TagText,
                  Pref_Bin: selectedputawaylist[i].Pref_Bin,
                  DocDate: selectedputawaylist[i].DocDate,
                  Item_LineNum: selectedputawaylist[i].Item_LineNum,
                  SerialBatch_LineNum:
                      selectedputawaylist[i].SerialBatch_LineNum,
                  isselected: selectedputawaylist[i].isselected,
                  isdone: selectedputawaylist[i].isdone,
                  AutoID: selectedputawaylist[i].AutoID,
                  DocEntry: selectedputawaylist[i].DocEntry,
                  DocNum: selectedputawaylist[i].DocNum,
                  InwardType: selectedputawaylist[i].InwardType,
                  ItemCode: selectedputawaylist[i].ItemCode,
                  ItemName: selectedputawaylist[i].ItemName,
                  ManageBy: selectedputawaylist[i].ManageBy,
                  Open_Putaway: selectedputawaylist[i].Open_Putaway,
                  Putaway_Qty: selectedputawaylist[i].Putaway_Qty,
                  SerialBatchCode: selectedputawaylist[i].SerialBatchCode,
                  SerialBatchQty: pendingcount,
                  SupplierCode: selectedputawaylist[i].SupplierCode,
                  SupplierName: selectedputawaylist[i].SupplierName,
                  Unit_Quantity: selectedputawaylist[i].Unit_Quantity,
                  WhsCode: selectedputawaylist[i].WhsCode,
                  localbincode: selectedputawaylist[i].localbincode);
              //  values2=val2;
              var val = Documentsputaway(
                  itemname: selectedputawaylist[i].ItemName!,
                  tagText: selectedputawaylist[i].TagText!,
                  linenum: selectedputawaylist[i].Item_LineNum!,
                  seriallinenum: selectedputawaylist[i].SerialBatch_LineNum!,
                  packquantity: selectedputawaylist[i].Putaway_Qty!,
                  binCode: mycontroller[1].text,
                  docEntry: selectedputawaylist[i].DocEntry!,
                  itemCode: selectedputawaylist[i].ItemCode.toString(),
                  DocNum: selectedputawaylist[i].DocNum!,
                  serialNum: selectedputawaylist[i].SerialBatchCode.toString(),
                  quantity: mycontroller[2].text.isEmpty
                      ? 1.0
                      : double.parse(mycontroller[2].text),
                  ManageBy: selectedputawaylist[i].ManageBy.toString(),
                  SerialBatchQty: selectedputawaylist[i].SerialBatchQty!,
                  Unit_Quantity: selectedputawaylist[i].Unit_Quantity!,
                  WhsCode: selectedputawaylist[i].WhsCode.toString());
              values = val;
              await DBoperation.putbatchinsert(val2, db);
              await DBoperation.putawayinsert(values, db).then((value) async {
                final audio = AudioPlayer();
                await audio.stop();

                await audio.setAsset("Asset/scan_serial_correct.mp3");
                audio.play();
                init();
                notifyListeners();
              });
            }
          }
        });
      }
     
    }
  }

  showdialogtoast(BuildContext context, String? message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final theme = Theme.of(context);
          return StatefulBuilder(builder: (context, setst) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            )),
                        width: Screens.width(context),
                        height: Screens.padingHeight(context) * 0.05,
                        alignment: Alignment.center,
                        child: Text(
                          "Alert",
                          style: theme.textTheme.bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child: Text(
                              "$message",
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     ElevatedButton(
                            //         onPressed: () {
                            //           setst(() {
                            //             Navigator.pop(context);
                            //             pageController.animateToPage(
                            //                 --pageChanged,
                            //                 duration: Duration(milliseconds: 250),
                            //                 curve: Curves.bounceIn);
                            //           });
                            //         },
                            //         child: Text("Yes")),
                            //     SizedBox(
                            //       width: Screens.width(context) * 0.02,
                            //     ),
                            ElevatedButton(
                                onPressed: () {
                                  setst(() {
                                    // isfinalloop = false;

                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("ok"))
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  String putawayserialscan = '';
  String putawaybinscan = '';
  int? indexscanning;
  bool itemAlreadyscanned = false;
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  double? checkquantity;
  scanneddataget(BuildContext context) async {
    log('putawayserialscan::'+putawayserialscan.toString());
    final Database db = (await DBhelper.getinstance())!;
    itemAlreadyscanned = false;
    indexscanning = null;
    notifyListeners();
    int? itemsearch;
    itemsearch = 0;
    if (checkquantity == null) {
      for (int ij = 0; ij < filterputawaylist.length; ij++) {
        if (filterputawaylist[ij].SerialBatchCode!.toLowerCase() ==
                putawayserialscan!.toLowerCase() &&
            filterputawaylist[ij].ManageBy!.toLowerCase() == 's') {
          checkquantity = filterputawaylist[ij].SerialBatchQty;
        } else if (filterputawaylist[ij].SerialBatchCode!.toLowerCase() ==
            putawayserialscan!.toLowerCase() &&filterputawaylist[ij].ManageBy!.toLowerCase() != 's' && (filterputawaylist[ij].localbincode==null ||filterputawaylist[ij].localbincode!.isEmpty)) {
          itemsearch = itemsearch! + 1;
          checkquantity = filterputawaylist[ij].SerialBatchQty;
          log("itemsearch::" + itemsearch.toString());
        }
      }
    }

    log("putawayserialscan" + putawayserialscan.toString());
    for (int ij = 0; ij < filterputawaylist.length; ij++) {
      if (filterputawaylist[ij].SerialBatchCode!.toLowerCase() ==
              putawayserialscan!.toLowerCase() &&
          (filterputawaylist[ij].SerialBatchQty == checkquantity)) {
        itemAlreadyscanned = true;
        indexscanning = ij;

        log("indexscanningindexscanning::" + indexscanning.toString());
        notifyListeners();
        break;
      }
    }
    if (itemAlreadyscanned == true) {
      log("indexscanning::" + indexscanning.toString());

      await DBoperation.putawayExists(
              filterputawaylist[indexscanning!].DocNum!,
              filterputawaylist[indexscanning!].SerialBatchCode!,
              filterputawaylist[indexscanning!].SerialBatchQty!.toInt(),
              db)
          .then((value) {
        if (value != null) {
          showdialogserial(context, db);
        } else {
          addselectedlist(filterputawaylist[indexscanning!]);
        }
      });

      // secondpage(filterpendinglist[indexscanning!]);
      notifyListeners();
    } else {
      showtoastforscanning();
      mycontroller[0].clear();
      resetfirst();
      notifyListeners();
    }

//  checkscannedcode(code);
    notifyListeners();
  }

  showdialogserial(BuildContext context, Database db) async {
    notifyListeners();
    final audio = AudioPlayer();
    await audio.stop();

    await audio.setAsset("Asset/scan_serial_wrong.mp3");
    audio.play();
    showDialog(
        context: context,
        builder: (_) {
          final theme = Theme.of(context);
          return StatefulBuilder(builder: (context, setst) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            )),
                        width: Screens.width(context),
                        height: Screens.padingHeight(context) * 0.05,
                        alignment: Alignment.center,
                        child: Text(
                          "Alert",
                          style: theme.textTheme.bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child: Text(
                              "Bin has been allocated for this serial number..",
                              //Bin has been allocated for this serial number..do you wish to reallocate the bin??
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.02,
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    setst(() {
                                      // clearselectedlist();
                                      // resetfirst();
                                      // notifyListeners();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text("ok")),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     ElevatedButton(
                            //         onPressed: () {
                            //           setst(() {
                            //             DBoperation.putawaydelete(
                            //                     filterputawaylist[
                            //                             indexscanning!]
                            //                         .DocNum!,
                            //                     filterputawaylist[
                            //                             indexscanning!]
                            //                         .SerialBatchCode!,
                            //                         filterputawaylist[
                            //                             indexscanning!]
                            //                         .SerialBatchQty!.toInt(),
                            //                     db)
                            //                 .then((val)async {
                            //                 await DBoperation.  updateBatchexist(filterputawaylist[
                            //                             indexscanning!]
                            //                         .ID!,filterputawaylist[
                            //                             indexscanning!]
                            //                         .SerialBatchQty!.toInt(),filterputawaylist[
                            //                             indexscanning!]
                            //                         .SerialBatchCode!,'',db);
                            //               addselectedlist(filterputawaylist[
                            //                   indexscanning!]);
                            //             });

                            //             notifyListeners();
                            //             Navigator.pop(context);
                            //           });
                            //         },
                            //         child: Text("Yes")),
                            //     SizedBox(
                            //       width: Screens.width(context) * 0.02,
                            //     ),
                            //     ElevatedButton(
                            //         onPressed: () {
                            //           setst(() {
                            //             clearselectedlist();
                            //             resetfirst();
                            //             notifyListeners();
                            //             Navigator.pop(context);
                            //           });
                            //         },
                            //         child: Text("No"))
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  clearselectedlist() {
    selectedputawaylist.clear();
    mycontroller[0].clear();
    notifyListeners();
  }

  double? oringalqty;
  addselectedlist(putawayDetList filterputawaylist) async {
    log("filterputawaylist::" + filterputawaylist.SerialBatchCode.toString());
    mycontroller[0].text = filterputawaylist.SerialBatchCode.toString();
    mycontroller[2].clear();
    oringalqty = null;
    selectedputawaylist.clear();
    final audio = AudioPlayer();
    await audio.stop();

    await audio.setAsset("Asset/scan_serial_correct.mp3");
    audio.play();
    notifyListeners();
    selectedputawaylist.add(putawayDetList(
        ID: filterputawaylist.ID,
        BinCode: filterputawaylist.BinCode,
        BinQty: filterputawaylist.BinQty,
        Pref_Bin: filterputawaylist.Pref_Bin,
        TagText: filterputawaylist.TagText,
        SerialBatch_LineNum: filterputawaylist.SerialBatch_LineNum,
        Item_LineNum: filterputawaylist.Item_LineNum,
        DocDate: filterputawaylist.DocDate,
        localbincode: '',
        isselected: true,
        isdone: filterputawaylist.isdone,
        AutoID: filterputawaylist.AutoID,
        DocEntry: filterputawaylist.DocEntry,
        DocNum: filterputawaylist.DocNum,
        InwardType: filterputawaylist.InwardType,
        ItemCode: filterputawaylist.ItemCode,
        ItemName: filterputawaylist.ItemName,
        ManageBy: filterputawaylist.ManageBy,
        Open_Putaway: filterputawaylist.Open_Putaway,
        Putaway_Qty: filterputawaylist.Putaway_Qty,
        SerialBatchCode: filterputawaylist.SerialBatchCode,
        SerialBatchQty: filterputawaylist.SerialBatchQty,
        SupplierCode: filterputawaylist.SupplierCode,
        SupplierName: filterputawaylist.SupplierName,
        Unit_Quantity: filterputawaylist.Unit_Quantity,
        WhsCode: filterputawaylist.WhsCode));
    log("selectedputawaylist::" + selectedputawaylist.length.toString());
    log("selectedputawaylist::" +
        selectedputawaylist[0].SerialBatchCode.toString());
    mycontroller[2].text = selectedputawaylist[0].ManageBy!.toLowerCase() != 's'
        ? selectedputawaylist[0].SerialBatchQty!.toStringAsFixed(0)
        : '1';
    oringalqty = selectedputawaylist[0].SerialBatchQty;
    log("oringalqty::" + oringalqty.toString());
    notifyListeners();
    focus1.unfocus();
    focus2.requestFocus();
    notifyListeners();
  }

  resetfirst() {
    filterputawaylist = putawaylist;
    notifyListeners();
  }

  mangedbyBatch(String code) {
    mycontroller[1].text = code;
    focus2.unfocus();
    notifyListeners();
  }

  void showtoastforscanning() {
    Fluttertoast.showToast(
        msg: "No Data Found..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  bool iscamera = false;
  bool iscamera2 = false;
  SearchFilterPending(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterputawaylist = putawaylist
          .where((e) =>
              (e).SerialBatchCode!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterputawaylist = putawaylist;
      notifyListeners();
    }
  }

  clearAll() {
    checkquantity = null;
    finallodaing = false;
    iscamera = false;
    iscamera2 = false;
    putawaylist.clear();
    batchinsertlist.clear();
    filterputawaylist.clear();
    selectedputawaylist.clear();
    Bincodelist.clear();
    mycontroller[0].clear();
    mycontroller[1].clear();
    isloading = false;
    putexception = '';
    notifyListeners();
  }
}
