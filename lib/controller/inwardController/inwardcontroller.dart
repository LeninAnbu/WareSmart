import 'dart:developer';
import 'dart:io';

import 'package:WareSmart/DBModel/inwardbackupDBModel.dart';
import 'package:WareSmart/DBModel/putawayDBModel.dart';
import 'package:WareSmart/Model/InwardModel/BinmasterModel.dart';
import 'package:WareSmart/Model/InwardModel/savepostModel.dart';
import 'package:WareSmart/Services/InwardApi/BinMasterApi.dart';
import 'package:WareSmart/Services/PutawayApi/putawaysave.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:WareSmart/DBModel/inwardDBmodel.dart';
import 'package:WareSmart/DBhelper/DBhelper.dart';
import 'package:WareSmart/DBhelper/DBoperation.dart';
import 'package:WareSmart/Model/InwardModel/GetPendingModel.dart';
import 'package:WareSmart/Model/InwardModel/GetinwByidModel.dart';
import 'package:WareSmart/Services/InwardApi/GetInwById.dart';
import 'package:WareSmart/Services/InwardApi/InwardPendingGetApi.dart';
import 'package:WareSmart/Services/InwardApi/savepostApi.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/pages/Inward/inwardsevepage.dart';

class inwardcontroller extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;
  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  List<dummylist> dummyshow = [];
  String scannedData = '';
  String serialscannedData = '';
  String binscannedData = '';
  Config config = Config();
  bool isserialcheck = false;
  bool isputawaycheck = false;
  bool isloading = false;
  bool get getisloading => isloading;
  String inwexception = '';
  String get getinwexception => inwexception;
  onchangeserial() {
    isserialcheck = !isserialcheck;
    notifyListeners();
  }

  int? indexscanning;
  bool itemAlreadyscanned = false;
  scanneddataget(BuildContext context) {
    itemAlreadyscanned = false;
    notifyListeners();
    for (int ij = 0; ij < filterpendinglist.length; ij++) {
      if (filterpendinglist[ij].DocNum.toString() == scannedData) {
        itemAlreadyscanned = true;
        indexscanning = ij;
        notifyListeners();
        break;
      }
    }
    if (itemAlreadyscanned == true) {
      secondpage(filterpendinglist[indexscanning!]);
      notifyListeners();
    } else {
      showtoastforscanning();
      mycontroller[5].clear();
      resetfirst();
      notifyListeners();
    }

//  checkscannedcode(code);
    notifyListeners();
  }

  showtoastInw(String message) {
    Fluttertoast.cancel();

    notifyListeners();

    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 0,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
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

  ontapserial(BuildContext context) {
    log("isputawaycheck::" + isputawaycheck.toString());
    if (isputawaycheck == true && mycontroller[0].text.isEmpty) {
      showtoastInw("Enter Bincode First..!!");
      // FocusScope.of(context).unfocus();
      notifyListeners();
    } else if (isputawaycheck == true && mycontroller[0].text.isNotEmpty) {
      afterBinScanned(mycontroller[0].text, context);
      notifyListeners();
    }
  }

  resetfirst() {
    filterpendinglist = pendinglist;
    notifyListeners();
  }

  SearchFilterPending(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterpendinglist = pendinglist
          .where((e) =>
              (e).SupplierCode!.toLowerCase().contains(v.toLowerCase()) ||
              (e).SupplierName!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .DocNum!
                  .toInt()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterpendinglist = pendinglist;
      notifyListeners();
    }
  }

  SearchFilterInwlist(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      inwItemList = beforeinwItemList
          .where((e) =>
              (e).ItemCode!.toLowerCase().contains(v.toLowerCase()) ||
              (e).ItemName!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      inwItemList = beforeinwItemList;
      notifyListeners();
    }
  }

  bool isonputchange = false;
  onchangeputaway(BuildContext context) async {
    isonputchange = true;
    notifyListeners();
    mycontroller[0].clear();
    if (dbdata.isNotEmpty) {
      showdialogputaway(context);
      isonputchange = false;
      notifyListeners();
    } else {
      isputawaycheck = !isputawaycheck;
      isonputchange = false;
      notifyListeners();
    }
    // if (isputawaycheck == false && mycontroller[1].text.isNotEmpty) {

    //   isonputchange = false;
    //   notifyListeners();
    // }
  }

  bool isloading2 = false;
  bool get getisloading2 => isloading2;
  String inwexception2 = '';
  String get getinwexception2 => inwexception2;
  List<InwDetailList> inwdocDetail = [];
  List<InwDetailList> get getinwdocDetail => inwdocDetail;
  List<InwItemList> inwItemList = [];
  List<InwItemList> beforeinwItemList = [];
  List<InwItemList> get getinwItemList => inwItemList;
  List<InwitemBatchlist> inwitemBatchlist = [];
  List<InwitemBatchlist> inwbatchlistcheck = [];
  List<InwitemBatchlist> get getinwitemBatchlist => inwitemBatchlist;
  InwItemList? inwItemList2;
  int? index;
  List<Documents> dbdata = [];
  List<Documents> dbdatcount = [];
  List<Documents> finaldoc = [];
  List<int> getqty = [];
  dataget(BuildContext context) async {
    dbdata.clear();

    await getDBData(index!);

    // if (inwitemBatchlist.isNotEmpty && dbdata.isNotEmpty) {
    //   await checkdatafrombatch();
    //   await showdialogcheck(context);
    // } else if (inwitemBatchlist.isNotEmpty && dbdata.isEmpty) {
    //   await checkdatafrombatch();
    //   addcheckfrombatch();
    //   // getDBData(index!);
    //   notifyListeners();
    // }
  }

  // addcheckfrombatch() async {
  //   final Database db = (await DBhelper.getinstance())!;
  //   int docEntry = inwItemList[index!].DocEntry!;
  //   await DBoperation.delete(docEntry, inwItemList[index!].ItemCode.toString(),
  //       inwItemList[index!].LineNum.toString(), db);
  //   var values;
  //   for (int i = 0; i < inwbatchlistcheck.length; i++) {
  //     var val = Documents(
  //         binCode: '',
  //         docEntry: inwbatchlistcheck[i].DocEntry!,
  //         itemCode: inwbatchlistcheck[i].ItemCode.toString(),
  //         lineNum: inwbatchlistcheck[i].LineNum!,
  //         numAtCard: '',
  //         serialNum: inwbatchlistcheck[i].SerialBatchCode.toString(),
  //         quantity: inwbatchlistcheck[i].SerialBatchQty!,
  //         expirydate: inwbatchlistcheck[i].ExpiryDate == null ||
  //                 inwbatchlistcheck[i].ExpiryDate!.isEmpty
  //             ? ''
  //             : config.alignDate1(inwbatchlistcheck[i].ExpiryDate.toString()),
  //         ManageBy: inwbatchlistcheck[i].ManageBy.toString(),
  //         MfgDate: inwbatchlistcheck[i].MfgDate!,
  //         Pack_Quantity: inwbatchlistcheck[i].Pack_Quantity!,
  //         TagText: inwbatchlistcheck[i].TagText.toString(),
  //         Unit_Quantity: inwbatchlistcheck[i].Unit_Quantity!,
  //         WhsCode: inwbatchlistcheck[i].WhsCode.toString());
  //     values = val;
  //     await DBoperation.insert(values, db).then((value) async {});
  //   }
  //   dbdata.clear();
  //   await getDBData(index!);

  //   notifyListeners();
  // }

//   checkdatafrombatch() async {
//     inwbatchlistcheck.clear();
//     notifyListeners();
//     for (int i = 0; i < inwitemBatchlist.length; i++) {
//       if (inwitemBatchlist[i].DocEntry == inwItemList[index!].DocEntry &&
//           inwitemBatchlist[i].ItemCode == inwItemList[index!].ItemCode) {
// // showdialogcheck();
// // inwitemBatchcheck=true;

//         inwbatchlistcheck.add(InwitemBatchlist(
//             AutoID: inwitemBatchlist[i].AutoID,
//             CreatedBy: inwitemBatchlist[i].CreatedBy,
//             CreatedDateTime: inwitemBatchlist[i].CreatedDateTime,
//             DocEntry: inwitemBatchlist[i].DocEntry,
//             ExpiryDate: inwitemBatchlist[i].ExpiryDate,
//             ItemCode: inwitemBatchlist[i].ItemCode,
//             ItemName: inwitemBatchlist[i].ItemName,
//             LineNum: inwitemBatchlist[i].LineNum,
//             ManageBy: inwitemBatchlist[i].ManageBy,
//             MfgDate: inwitemBatchlist[i].MfgDate,
//             Pack_Quantity: inwitemBatchlist[i].Pack_Quantity,
//             SerialBatchCode: inwitemBatchlist[i].SerialBatchCode,
//             SerialBatchQty: inwitemBatchlist[i].SerialBatchQty,
//             TagText: inwitemBatchlist[i].TagText,
//             TraceId: inwitemBatchlist[i].TraceId,
//             Unit_Quantity: inwitemBatchlist[i].Unit_Quantity,
//             UpdatedBy: inwitemBatchlist[i].UpdatedBy,
//             UpdatedDateTime: inwitemBatchlist[i].UpdatedDateTime,
//             WhsCode: inwitemBatchlist[i].WhsCode));
//       }
//     }
//     log("inwbatchlistcheck:::" + inwbatchlistcheck.length.toString());
//     notifyListeners();
//   }

  // checkbeforebatch() {
  //   for (int i = 0; i < inwItemList.length; i++) {
  //     checkbatchlist(i);
  //     notifyListeners();
  //   }
  // }
  checkbatchlist2(InwitemBatchlist inwitemBatchlist) async {
    for (int i = 0; i < inwItemList.length; i++) {
      if (inwItemList[i].DocEntry == inwitemBatchlist.DocEntry &&
          inwItemList[i].ItemCode == inwitemBatchlist.ItemCode &&
          inwItemList[i].LineNum == inwitemBatchlist.LineNum) {
        inwItemList.removeAt(i);
        notifyListeners();
      }
    }
  }

  checkbatchlist(int ind) async {
    inwbatchlistcheck.clear();
    notifyListeners();
    for (int i = 0; i < inwitemBatchlist.length; i++) {
      // if (inwitemBatchlist[i].DocEntry == inwItemList[ind].DocEntry &&
      //     inwitemBatchlist[i].ItemCode == inwItemList[ind].ItemCode) {
// showdialogcheck();
// inwitemBatchcheck=true;

      inwbatchlistcheck.add(InwitemBatchlist(
          AutoID: inwitemBatchlist[i].AutoID,
          CreatedBy: inwitemBatchlist[i].CreatedBy,
          CreatedDateTime: inwitemBatchlist[i].CreatedDateTime,
          DocEntry: inwitemBatchlist[i].DocEntry,
          ExpiryDate: inwitemBatchlist[i].ExpiryDate,
          ItemCode: inwitemBatchlist[i].ItemCode,
          ItemName: inwitemBatchlist[i].ItemName,
          LineNum: inwitemBatchlist[i].LineNum,
          ManageBy: inwitemBatchlist[i].ManageBy,
          MfgDate: inwitemBatchlist[i].MfgDate,
          Pack_Quantity: inwitemBatchlist[i].Pack_Quantity,
          SerialBatchCode: inwitemBatchlist[i].SerialBatchCode,
          SerialBatchQty: inwitemBatchlist[i].SerialBatchQty,
          TagText: inwitemBatchlist[i].TagText,
          TraceId: inwitemBatchlist[i].TraceId,
          Unit_Quantity: inwitemBatchlist[i].Unit_Quantity,
          UpdatedBy: inwitemBatchlist[i].UpdatedBy,
          UpdatedDateTime: inwitemBatchlist[i].UpdatedDateTime,
          WhsCode: inwitemBatchlist[i].WhsCode));
      // }
    }
    if (inwbatchlistcheck.isNotEmpty) {
      log("inwbatchlistcheck:::" + inwbatchlistcheck.length.toString());
      final Database db = (await DBhelper.getinstance())!;
      int docEntry = ind;
      // await DBoperation.saveAllData(docEntry.toString(), db)
      //     .then((value) async {
      //   if (value.isNotEmpty) {
      //     for (int i = 0; i < value.length; i++) {
      //       var list = Documentsbackup(
      //           binCode: value[i].binCode,
      //           docEntry: value[i].docEntry,
      //           itemCode: value[i].itemCode,
      //           lineNum: value[i].lineNum,
      //           numAtCard: value[i].numAtCard,
      //           serialNum: value[i].serialNum,
      //           quantity: value[i].quantity,
      //           expirydate: value[i].expirydate,
      //           ManageBy: value[i].ManageBy,
      //           MfgDate: value[i].MfgDate,
      //           Pack_Quantity: value[i].Pack_Quantity,
      //           TagText: value[i].TagText,
      //           Unit_Quantity: value[i].Unit_Quantity,
      //           WhsCode: value[i].WhsCode);
      //       await DBoperation.insertbackup(list, db);
      //     }
      //   }else{
      //    await DBoperation.  deletedocentrybackup(docEntry,db);
      //   }
      // });

      await DBoperation.deletedocentry(docEntry, db);
      var values;
      for (int i = 0; i < inwbatchlistcheck.length; i++) {
        List<binlines> binlinelist = [
          binlines(
              bincode: '', binqty: inwbatchlistcheck[i].SerialBatchQty!.toInt())
        ];
        var val = Documents(
            itemname: inwbatchlistcheck[i].ItemName!,
            binCode: '',
            docEntry: inwbatchlistcheck[i].DocEntry!,
            itemCode: inwbatchlistcheck[i].ItemCode.toString(),
            lineNum: inwbatchlistcheck[i].LineNum!,
            numAtCard: '',
            serialNum: inwbatchlistcheck[i].SerialBatchCode.toString(),
            quantity: inwbatchlistcheck[i].SerialBatchQty!,
            expirydate: inwbatchlistcheck[i].ExpiryDate == null ||
                    inwbatchlistcheck[i].ExpiryDate!.isEmpty
                ? ''
                : config.alignDate1(inwbatchlistcheck[i].ExpiryDate.toString()),
            ManageBy: inwbatchlistcheck[i].ManageBy.toString(),
            MfgDate: inwbatchlistcheck[i].MfgDate!,
            Pack_Quantity: inwbatchlistcheck[i].Pack_Quantity!,
            TagText: inwbatchlistcheck[i].TagText.toString(),
            Unit_Quantity: inwbatchlistcheck[i].Unit_Quantity!,
            WhsCode: inwbatchlistcheck[i].WhsCode.toString(),
            binlinelist: binlinelist);
        values = val;
        await DBoperation.insert(values, db);
        await DBoperation.insert(values, db).then((value) async {
          //  getqty.clear();
          // await gettotal();
          // ScanTotal = 0;
          // finaldoc.clear();
          // GetAllDBqty();
          // notifyListeners();
        });
      }
      notifyListeners();
    }

    notifyListeners();
  }

  ScannedQty() {
    int qty = 0;
    for (int i = 0; i < dbdata.length; i++) {
      // log("dbdata::"+dbdata[i].quantity.toString());
      String? qty2 = dbdata[i].quantity.toStringAsFixed(0);
      qty = qty + int.parse(qty2);
    }
    return qty;
  }

  void showtoastfordate() {
    Fluttertoast.showToast(
        msg: "Select expiry Date..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  getDBData(int i) async {
    final Database db = (await DBhelper.getinstance())!;
    await DBoperation.getBinAndSerailNo("${inwItemList[i].DocEntry}",
            "${inwItemList[i].ItemCode}", inwItemList[i].LineNum, db)
        .then((value) {
      if (value.length > 0) {
        print("length: " + value.length.toString());
        print("docEntry: " + value[0].docEntry.toString());
        print("itemCode: " + value[0].itemCode.toString());
        // setState(() {
        dbdata = value;
        // });
        notifyListeners();
      }
    });
    for (int i = 0; i < dbdata.length; i++) {
      if (dbdata[i].binCode != '') {
        isputawaycheck = true;

        notifyListeners();
        break;
      }
    }
  }

  bool saveenablebutton = false;
  getsaveenable() async {
    await gettotal();
    bool issaveenable = false;
    issaveenable = false;
    if (getqty.isNotEmpty) {
      for (int i = 0; i < inwItemList.length; i++) {
        if (inwItemList[i].Unit_Quantity == getqty[i]) {
          issaveenable = true;
          // notifyListeners();
        }
      }
    }

    if (issaveenable == true) {
      log("saveLLtrure");
      saveenablebutton = true;
    } else {
      saveenablebutton = false;
    }
  }

  gettotal() async {
    getqty.clear();
    notifyListeners();
    log("inwItemList::" + inwItemList.length.toString());
    final Database db = (await DBhelper.getinstance())!;
    for (int i = 0; i < inwItemList.length; i++) {
      await DBoperation.getoverallcount(db, inwItemList[i].DocEntry.toString(),
              inwItemList[i].ItemCode.toString(), inwItemList[i].LineNum)
          .then((value) {
        getqty.add(value);
        notifyListeners();
        log("getqty::" + getqty.length.toString());
        log("getqty[i]::" + getqty[i].toString());
      });
    }
    log("dbdatcount::" + dbdatcount.length.toString());
  }

  deletescandata(int i) async {
    final Database db = (await DBhelper.getinstance())!;
    //  final finaldbdata=dbdata.reversed.toList();
    // final dbdata2=  dbdata.reversed.toList();
    DBoperation.delete(
        inwItemList[index!].DocEntry!,
        inwItemList[index!].ItemCode.toString(),
        inwItemList[index!].LineNum.toString(),
        db);
    dbdata.removeAt(i);
    notifyListeners();
  }

// beforeserial(String code, BuildContext context){
//  mycontroller[1].text = code;
//  if()
// }
  mangedbyBatch(String code) {
    mycontroller[1].text = code;
    notifyListeners();
  }

  bool isfinalloop = false;
  ToastFuture? _currentToast;
  afterSerialScanned(String code, BuildContext context) async {
    int? indexbatch;
    bool? alreadyaded = false;
    final Database db = (await DBhelper.getinstance())!;
    mycontroller[1].text = code;

    int qtys = int.parse(inwItemList[index!].Unit_Quantity!.toStringAsFixed(0));
    log("hii::" + qtys.toString());
    if (mycontroller[1].text.isEmpty) {
      // const snackBar = SnackBar(
      //     duration: Duration(seconds: 4),
      //     backgroundColor: Colors.red,
      //     content: Text(
      //       "Please Give Serial Number..!!",
      //       style: const TextStyle(color: Colors.white),
      //     ));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      final audio = AudioPlayer();
      await audio.setAsset("Asset/scan_serial_wrong.mp3");
      mycontroller[1].clear();
      serialscannedData = '';

      mycontroller[2].clear();
      mycontroller[2].text = '1';
      notifyListeners();

      audio.play();
      FocusScope.of(context).unfocus();
      // showtoastInw("Please Give Serial Number..!!");
      isfinalloop = true;
      notifyListeners();
      showdialogtoast(context, "Please Give Serial Number..!!");

      // await  playsound("scan_serial_wrong");
      notifyListeners();
    } else if (qtys <= ScannedQty() ||
        qtys < ScannedQty() + int.parse(mycontroller[2].text)) {
      // const snackBar = SnackBar(
      //   duration: Duration(seconds: 4),
      //   backgroundColor: Colors.red,
      //   content: Text(
      //     'Greater than Qty!!..',
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // );

      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      final audio = AudioPlayer();
      await audio.stop();
      await audio.setAsset("Asset/when_checklist_popup.mp3");
      audio.play();
      mycontroller[1].clear();
      serialscannedData = '';
      mycontroller[2].clear();
      mycontroller[2].text = '1';

      FocusScope.of(context).unfocus();
      // showtoastInw(
      //   "Greater than Qty..!!",
      // );
      isfinalloop = true;
      notifyListeners();
      showdialogtoast(context, "Greater than Qty..!!");
      // isfinalloop = false;

      notifyListeners();
//  await      playsound("when_checklist_popup");
      notifyListeners();
      // focus.requestFocus();
    } else {
      if (dbdata.length > 0 && mycontroller[1].text.isNotEmpty) {
        log("ifffff1111: ");
        int datapresent = 0;
        for (int i = 0; i < dbdata.length; i++) {
          print("for serail1111: " + dbdata[i].serialNum);
          if (dbdata[i].serialNum == mycontroller[1].text &&
              dbdata[i].ManageBy.toLowerCase() == 's') {
            datapresent = datapresent + 1;
          }
        }
        if (datapresent == 0) {
          if (inwItemList[index!].ManageBy!.toLowerCase() == "b") {
            alreadyaded = false;
            indexbatch = null;
            // await DBoperation.getProductsbatch(
            //         db,
            //         inwItemList[index!].DocEntry.toString(),
            //         inwItemList[index!].ItemCode,
            //         mycontroller[0].text,
            //         mycontroller[1].text)
            //     .then((value) async{
            //   if (value != null) {
            for (int ij = 0; ij < dbdata.length; ij++) {
              if (dbdata[ij].docEntry == inwItemList[index!].DocEntry &&
                  dbdata[ij].itemCode == inwItemList[index!].ItemCode &&
                  dbdata[ij].binCode == mycontroller[0].text &&
                  dbdata[ij].serialNum == mycontroller[1].text) {
                alreadyaded = true;
                indexbatch = ij;
                notifyListeners();
                break;
              }
            }
            if (alreadyaded == true) {
              dbdata[indexbatch!].quantity = dbdata[indexbatch!].quantity +
                  double.parse(mycontroller[2].text);
              final audio = AudioPlayer();
              await audio.stop();
              await audio.setAsset("Asset/scan_serial_correct.mp3");
              audio.play();
              //  savelistinwardState().  playsound("scan_serial_correct");

              mycontroller[1].clear();
              serialscannedData = '';
              mycontroller[2].clear();
              mycontroller[2].text = '1';
              mycontroller[3].clear();

              isfinalloop = false;
            } else {
              List<binlines> binlinelist = [
                binlines(
                    bincode: mycontroller[0].text.toString() ?? '',
                    binqty: int.parse(mycontroller[2].text.toString()))
              ];
              dbdata.add(
                Documents(
                    itemname: inwItemList[index!].ItemName!,
                    ManageBy: inwItemList[index!].ManageBy!,
                    MfgDate: Config.currentDate(),
                    Pack_Quantity: inwItemList[index!].Pack_Quantity!,
                    Unit_Quantity: inwItemList[index!].Unit_Quantity!,
                    TagText: "",
                    WhsCode: ConstantValues.Whsecode,
                    binCode: mycontroller[0].text.toString() ?? '',
                    docEntry: inwItemList[index!].DocEntry!,
                    itemCode: inwItemList[index!].ItemCode.toString(),
                    lineNum: inwItemList[index!].LineNum!,
                    numAtCard: "",
                    serialNum: mycontroller[1].text,
                    quantity: double.parse(mycontroller[2].text.toString()),
                    expirydate: mycontroller[3].text.isEmpty
                        ? ""
                        : mycontroller[3].text,
                    binlinelist: binlinelist),
              );
              final audio = AudioPlayer();
              await audio.stop();
              await audio.setAsset("Asset/scan_serial_correct.mp3");
              audio.play();
              //  savelistinwardState().  playsound("scan_serial_correct");

              mycontroller[1].clear();
              serialscannedData = '';
              mycontroller[2].clear();
              mycontroller[2].text = '1';
              mycontroller[3].clear();

              isfinalloop = false;
            }
            // }
            // });
          } else {
            DBoperation.serialExists(inwItemList[index!].DocEntry.toString(),
                    mycontroller[1].text.toString(), db)
                .then((valueserial) async {
              log("valueserialvalueserial: " + valueserial.toString());
              if (valueserial != null) {
                log("valueserialvalueserial: " + valueserial.toString());
                if (valueserial < 1) {
                  log("value222222222222: " + valueserial.toString());
                  if (mycontroller[1].text.isNotEmpty &&
                      mycontroller[1].text != '') {
                    List<binlines> binlinelist = [
                      binlines(
                          bincode: mycontroller[0].text.toString() ?? '',
                          binqty: int.parse(mycontroller[2].text.toString()))
                    ];
                    dbdata.add(
                      Documents(
                          itemname: inwItemList[index!].ItemName!,
                          ManageBy: inwItemList[index!].ManageBy!,
                          MfgDate: Config.currentDate(),
                          Pack_Quantity: inwItemList[index!].Pack_Quantity!,
                          Unit_Quantity: inwItemList[index!].Unit_Quantity!,
                          TagText: "",
                          WhsCode: ConstantValues.Whsecode,
                          binCode: mycontroller[0].text.toString() ?? '',
                          docEntry: inwItemList[index!].DocEntry!,
                          itemCode: inwItemList[index!].ItemCode.toString(),
                          lineNum: inwItemList[index!].LineNum!,
                          numAtCard: "",
                          serialNum: mycontroller[1].text,
                          quantity:
                              double.parse(mycontroller[2].text.toString()),
                          expirydate: mycontroller[3].text.isEmpty
                              ? ""
                              : mycontroller[3].text,
                          binlinelist: binlinelist),
                    );
                    final audio = AudioPlayer();
                    await audio.stop();
                    await audio.setAsset("Asset/scan_serial_correct.mp3");
                    audio.play();
                    //  savelistinwardState().  playsound("scan_serial_correct");

                    mycontroller[1].clear();
                    serialscannedData = '';
                    mycontroller[2].clear();
                    mycontroller[2].text = '1';
                    mycontroller[3].clear();

                    isfinalloop = false;
                    notifyListeners();
                  }
                } else {
                  // const snackBar = SnackBar(
                  //   duration: Duration(seconds: 2),
                  //   backgroundColor: Colors.red,
                  //   content: Text(
                  //     "Serial number already added!!..",
                  //     style: TextStyle(),
                  //   ),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  final audio = AudioPlayer();
                  await audio.stop();
                  await audio.setAsset("Asset/scan_serial_wrong.mp3");
                  mycontroller[1].clear();
                  serialscannedData = '';
                  mycontroller[2].clear();
                  mycontroller[2].text = '1';
                  notifyListeners();

                  audio.play();

                  // showtoastInw(
                  //   "Serial number already added..!!",
                  // );
                  isfinalloop = true;
                  notifyListeners();
                  showdialogtoast(context, "Serial number already added..!!");
                  // isfinalloop = false;
                  notifyListeners();
                  //  await  playsound("scan_serial_wrong");
                  notifyListeners();
                }
              } else {
                if (mycontroller[1].text.isNotEmpty &&
                    mycontroller[1].text != '') {
                  List<binlines> binlinelist = [
                    binlines(
                        bincode: mycontroller[0].text.toString() ?? '',
                        binqty: int.parse(mycontroller[2].text.toString()))
                  ];
                  dbdata.add(Documents(
                      itemname: inwItemList[index!].ItemName!,
                      ManageBy: inwItemList[index!].ManageBy!,
                      MfgDate: Config.currentDate(),
                      Pack_Quantity: inwItemList[index!].Pack_Quantity!,
                      Unit_Quantity: inwItemList[index!].Unit_Quantity!,
                      TagText: "",
                      WhsCode: ConstantValues.Whsecode,
                      binCode: mycontroller[0].text.toString() ?? '',
                      docEntry: inwItemList[index!].DocEntry!,
                      itemCode: inwItemList[index!].ItemCode.toString(),
                      lineNum: inwItemList[index!].LineNum!,
                      numAtCard: "",
                      serialNum: mycontroller[1].text,
                      quantity: double.parse(mycontroller[2].text.toString()),
                      expirydate: mycontroller[3].text.isEmpty
                          ? ""
                          : mycontroller[3].text,
                      binlinelist: binlinelist));
                  final audio = AudioPlayer();
                  await audio.stop();
                  await audio.setAsset("Asset/scan_serial_correct.mp3");
                  audio.play();
                  // savelistinwardState().   playsound("scan_serial_correct");
                  notifyListeners();
                  mycontroller[1].clear();
                  serialscannedData = '';
                  mycontroller[2].clear();
                  mycontroller[3].clear();
                  mycontroller[2].text = '1';
                  isfinalloop = false;
                  notifyListeners();
                  notifyListeners();
                } else {
                  // final snackBar = SnackBar(
                  //   duration: Duration(seconds: 2),
                  //   backgroundColor: Colors.red,
                  //   content: Text(
                  //     "Serial number already added!!..",
                  //     style: TextStyle(),
                  //   ),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  final audio = AudioPlayer();
                  await audio.stop();
                  await audio.setAsset("Asset/scan_serial_wrong.mp3");
                  audio.play();
                  mycontroller[1].clear();
                  serialscannedData = '';
                  mycontroller[2].clear();
                  mycontroller[2].text = '1';
                  notifyListeners();

                  // showtoastInw(
                  //   "Serial number already added..!!",
                  // );
                  isfinalloop = true;
                  notifyListeners();
                  showdialogtoast(context, "Serial number already added..!!");
                  // isfinalloop = false;
                  notifyListeners();
                  // await playsound("scan_serial_wrong");
                  notifyListeners();
                }
              }
            });
          }
        } else {
          // final snackBar = SnackBar(
          //   duration: Duration(seconds: 2),
          //   backgroundColor: Colors.red,
          //   content: Text(
          //     "Serial number already added!!..",
          //     style: TextStyle(),
          //   ),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          final audio = AudioPlayer();
          await audio.stop();
          await audio.setAsset("Asset/scan_serial_wrong.mp3");
          audio.play();
          mycontroller[1].clear();
          serialscannedData = '';
          mycontroller[2].clear();
          mycontroller[2].text = '1';

          // showtoastInw(
          //   "Serial number already added..!!",
          // );
          isfinalloop = true;
          notifyListeners();
          showdialogtoast(context, "Serial number already added..!!");
          // isfinalloop = false;
          notifyListeners();
          //  await  playsound("scan_serial_wrong");
          notifyListeners();
          // focus.requestFocus();
        }
      } else {
        if (inwItemList[index!].ManageBy!.toLowerCase() == "b") {
          alreadyaded = false;
          indexbatch = null;
          // await DBoperation.getProductsbatch(
          //         db,
          //         inwItemList[index!].DocEntry.toString(),
          //         inwItemList[index!].ItemCode,
          //         mycontroller[0].text,
          //         mycontroller[1].text)
          //     .then((value)async {
          //   if (value != null) {
          for (int ij = 0; ij < dbdata.length; ij++) {
            if (dbdata[ij].docEntry == inwItemList[index!].DocEntry &&
                dbdata[ij].itemCode == inwItemList[index!].ItemCode &&
                dbdata[ij].binCode == mycontroller[0].text &&
                dbdata[ij].serialNum == mycontroller[1].text) {
              alreadyaded = true;
              indexbatch = ij;
              notifyListeners();
              break;
            }
          }
          if (alreadyaded == true) {
            dbdata[indexbatch!].quantity = dbdata[indexbatch!].quantity +
                double.parse(mycontroller[2].text);
            final audio = AudioPlayer();
            await audio.stop();
            await audio.setAsset("Asset/scan_serial_correct.mp3");
            audio.play();
            //  savelistinwardState().  playsound("scan_serial_correct");

            mycontroller[1].clear();
            serialscannedData = '';
            mycontroller[2].clear();
            mycontroller[2].text = '1';
            mycontroller[3].clear();

            isfinalloop = false;
          } else {
            List<binlines> binlinelist = [
              binlines(
                  bincode: mycontroller[0].text.toString() ?? '',
                  binqty: int.parse(mycontroller[2].text.toString()))
            ];
            dbdata.add(
              Documents(
                  itemname: inwItemList[index!].ItemName!,
                  ManageBy: inwItemList[index!].ManageBy!,
                  MfgDate: Config.currentDate(),
                  Pack_Quantity: inwItemList[index!].Pack_Quantity!,
                  Unit_Quantity: inwItemList[index!].Unit_Quantity!,
                  TagText: "",
                  WhsCode: ConstantValues.Whsecode,
                  binCode: mycontroller[0].text.toString() ?? '',
                  docEntry: inwItemList[index!].DocEntry!,
                  itemCode: inwItemList[index!].ItemCode.toString(),
                  lineNum: inwItemList[index!].LineNum!,
                  numAtCard: "",
                  serialNum: mycontroller[1].text,
                  quantity: double.parse(mycontroller[2].text.toString()),
                  expirydate:
                      mycontroller[3].text.isEmpty ? "" : mycontroller[3].text,
                  binlinelist: binlinelist),
            );
            final audio = AudioPlayer();
            await audio.stop();
            await audio.setAsset("Asset/scan_serial_correct.mp3");
            audio.play();
            //  savelistinwardState().  playsound("scan_serial_correct");

            mycontroller[1].clear();
            serialscannedData = '';
            mycontroller[2].clear();
            mycontroller[2].text = '1';
            mycontroller[3].clear();

            isfinalloop = false;
          }
          //   }
          // });
        } else {
          DBoperation.serialExists(inwItemList[index!].DocEntry.toString(),
                  mycontroller[1].text.toString(), db)
              .then((valueSerial) async {
            if (valueSerial != null) {
              if (valueSerial < 1) {
                if (mycontroller[1].text.isNotEmpty &&
                    mycontroller[1].text != '') {
                  List<binlines> binlinelist = [
                    binlines(
                        bincode: mycontroller[0].text.toString() ?? '',
                        binqty: int.parse(mycontroller[2].text.toString()))
                  ];
                  dbdata.add(Documents(
                      itemname: inwItemList[index!].ItemName!,
                      ManageBy: inwItemList[index!].ManageBy!,
                      MfgDate: Config.currentDate(),
                      Pack_Quantity: inwItemList[index!].Pack_Quantity!,
                      Unit_Quantity: inwItemList[index!].Unit_Quantity!,
                      TagText: "",
                      WhsCode: ConstantValues.Whsecode,
                      binCode: mycontroller[0].text.toString() ?? '',
                      docEntry: inwItemList[index!].DocEntry!,
                      itemCode: inwItemList[index!].ItemCode.toString(),
                      lineNum: inwItemList[index!].LineNum!,
                      numAtCard: "",
                      serialNum: mycontroller[1].text,
                      quantity: double.parse(mycontroller[2].text.toString()),
                      expirydate: mycontroller[3].text.isEmpty
                          ? ""
                          : mycontroller[3].text,
                      binlinelist: binlinelist));

                  final audio = AudioPlayer();
                  await audio.stop();
                  await audio.setAsset("Asset/scan_serial_correct.mp3");
                  audio
                      .play(); // savelistinwardState().     playsound("scan_serial_correct");
                  notifyListeners();
                  mycontroller[1].clear();
                  serialscannedData = '';
                  mycontroller[2].clear();
                  mycontroller[3].clear();
                  mycontroller[2].text = '1';
                  notifyListeners();
                  isfinalloop = false;
                  notifyListeners();
                }
              } else {
                // const snackBar = SnackBar(
                //   duration: Duration(seconds: 2),
                //   backgroundColor: Colors.red,
                //   content: Text(
                //     "Serial number already added!!..",
                //     style: TextStyle(),
                //   ),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                final audio = AudioPlayer();
                await audio.stop();
                await audio.setAsset("Asset/scan_serial_wrong.mp3");
                audio.play();
                mycontroller[1].clear();
                serialscannedData = '';

                mycontroller[2].clear();
                mycontroller[2].text = '1';

                // showtoastInw(
                //   "Serial number already added..!!",
                // );
                isfinalloop = true;
                notifyListeners();
                showdialogtoast(context, "Serial number already added..!!");
                // isfinalloop = false;
                notifyListeners();
                //  await  playsound();
                notifyListeners();
              }
            }
          });
        }
      }
    }
    //  mycontroller[1].clear();
  }

  String? expiryDate = '';
  void showexpDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      expiryDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[3].text = chooseddate;
      notifyListeners();
    });
  }

  List<double>? grpSum;
  double? grpTotalDouble;
  int? grpTotal;
  int? ScanTotal;
  GetAllDBqty() async {
    final Database db = (await DBhelper.getinstance())!;
    finaldoc = await DBoperation.getAllProducts(
      db,
      inwItemList[0].DocEntry.toString(),
    );
    if (finaldoc.isNotEmpty) {
      log("finaldoc::" + finaldoc.length.toString());
      for (int i = 0; i < finaldoc.length; i++) {
        String? qty2 = finaldoc[i].quantity.toStringAsFixed(0);
        log("qty2::" + qty2.toString());
        log("ScanTotalbefore::" + qty2.toString());
        ScanTotal = ScanTotal! + int.parse(qty2);
        log("ScanTotal::" + ScanTotal.toString());
      }
    }

    return ScanTotal;
  }

  getAllQuantity() {
    if (inwItemList.length != 0) {
      var ab = inwItemList
          .map((itemdet) => itemdet.Unit_Quantity!.toStringAsFixed(0));
      // print("getAllQuantity : $ab");
      grpSum = ab.map(double.parse).toList();
      print(grpSum);
      grpTotalDouble = grpSum!.reduce((a, b) => a + b); //for adding array items
      //   print("grpTotalDouble: " + grpTotalDouble.toString());
      grpTotal = int.parse(grpTotalDouble!.toStringAsFixed(0));
      log("grpTotal::" + grpTotal.toString());
      // print("grpTotal: "+grpTotal.toString());
    } else {
      // setState(() {
      //   grandTotal = 0.00;
      //   total = 0.00;
      // });
    }
  }

  List<Documents> finalsavelist = [];
  bool finallodaing = false;
  List<Documentsputaway> addputaway = [];
  methodfinalsave(Documents values) {
    bool finaladded = false;
    int? finalindex;
    finalindex = null;
    finaladded = false;

    for (int ij = 0; ij < finalsavelist.length; ij++) {
      if (finalsavelist[ij].docEntry == values.docEntry &&
          finalsavelist[ij].itemCode == values.itemCode &&
          finalsavelist[ij].serialNum == values.serialNum &&
          finalsavelist[ij].lineNum == values.lineNum) {
        finaladded = true;
        finalindex = ij;
        notifyListeners();
        break;
      }
    }
    if (finaladded == true) {
      finalsavelist[finalindex!].quantity =
          finalsavelist[finalindex!].quantity + values.quantity;
      notifyListeners();
    } else {
      List<binlines> binlinelist = [
        binlines(bincode: values.binCode, binqty: values.quantity.toInt())
      ];
      finalsavelist.add(Documents(
          itemname: values.itemname!,
          binCode: values.binCode,
          docEntry: values.docEntry,
          itemCode: values.itemCode,
          lineNum: values.lineNum,
          numAtCard: values.numAtCard,
          serialNum: values.serialNum,
          quantity: values.quantity,
          expirydate: values.expirydate,
          ManageBy: values.ManageBy,
          MfgDate: values.MfgDate,
          Pack_Quantity: values.Pack_Quantity,
          TagText: values.TagText,
          Unit_Quantity: values.Unit_Quantity,
          WhsCode: values.WhsCode,
          binlinelist: binlinelist));
    }
  }

  Future<void> copyDatabaseToExternalStorage(BuildContext context) async {
    // final Database db = (await DBhelper.getinstance())!;
    // dball=await DBoperation. getAllProductsdash(db);
    // log("dball::"+dball.length.toString());
    await getPermissionStorage(context);

    final internalDbPath = await getDatabasesPath();
    final dbFile = File('$internalDbPath/waresmart.db');
    log("message::" + dbFile.toString());

    final externalDir = await getExternalStorageDirectory();
    log("message::" + externalDir.toString());
    final externalDbPath = '${externalDir?.path}/waresmart.db';

    if (await dbFile.exists()) {
      await dbFile.copy(externalDbPath);
      print("Database copied to: $externalDbPath");
      showSnackBars(
          "${externalDbPath} db saved Successfully", Colors.green, context);
    } else {
      print("Database file does not exist.");
    }
  }

  showSnackBars(String e, Color color, BuildContext context) {
    SnackBar snackBar = SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: color,
        content: Text(
          "${e.toString()}",
          style: const TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> getPermissionStorage(BuildContext context) async {
    try {
      var statusStorage = await Permission.storage.status;
      if (statusStorage.isDenied) {
        Permission.storage.request();
        return Future.value(false);
      }
      if (statusStorage.isGranted) {
        return Future.value(true);
      }
    } catch (e) {
      showSnackBars("$e", Colors.red, context);
    }
    return Future.value(false);
  }

  finalindexupdate(int i, Documents values) {
    finalsavelist[i].quantity = finalsavelist[i].quantity + values.quantity;
    notifyListeners();
  }

  methodputaway(List<Documents> values, postInwitemBatchlist postBatchlist) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].binCode.isNotEmpty &&
          values[i].itemCode == postBatchlist.ItemCode &&
          values[i].serialNum == postBatchlist.SerialBatchCode) {
        addputaway.add(Documentsputaway(
          itemname:values[i].itemname,
            tagText: values[i].TagText,
            packquantity: values[i].Pack_Quantity,
            linenum: values[i].lineNum,
            seriallinenum: postBatchlist.LineNum!,
            binCode: values[i].binCode,
            docEntry: values[i].docEntry,
            itemCode: values[i].itemCode,
            DocNum: values[i].docEntry,
            serialNum: values[i].serialNum,
            quantity: values[i].quantity,
            ManageBy: values[i].ManageBy,
            SerialBatchQty: values[i].Unit_Quantity,
            Unit_Quantity: values[i].Unit_Quantity,
            WhsCode: values[i].WhsCode));
        // log("addputaway::" + addputaway[i].serialNum.toString());
      }
    }
  }

  methodfinalsave2222(Documents values) {
    // binlinelist222.clear();
    bool finaladded = false;
    int? finalindex;
    int? subfinalindex;
    finalindex = null;
    finaladded = false;
    subfinalindex = null;
    for (int ij = 0; ij < finalsavelist.length; ij++) {
      if (finalsavelist[ij].docEntry == values.docEntry &&
          finalsavelist[ij].serialNum == values.serialNum) {
        notifyListeners();
        // for (int il = 0; il < binlinelist222.length; il++) {
        //   // if (binlinelist222[ij].bincode == values.binCode) {
        //     // subfinalindex = il;
        //   // }
        // }
        finaladded = true;
        finalindex = ij;
        //
        notifyListeners();
        break;
      }
    }
    if (finaladded == true) {
      finalsavelist[finalindex!].quantity =
          finalsavelist[finalindex!].quantity + values.quantity;
      // if (subfinalindex != null) {
      // for(finalsavelist)
        // binlinelist222.add(
            // binlines(bincode: values.binCode, binqty: values.quantity.toInt()));
            finalsavelist[finalindex].binlinelist!.add(binlines(bincode: values.binCode, binqty: values.quantity.toInt()));
      // }
      // binlinelist222[subfinalindex!].binqty=   binlinelist222[subfinalindex!].binqty! + values.quantity.toInt();
      notifyListeners();
    } else {
       List<binlines> newBinlinesList = [];
      newBinlinesList.add(
          binlines(bincode: values.binCode, binqty: values.quantity.toInt())
          );
      finalsavelist.add(Documents(
          itemname: values.itemname!,
          binCode: values.binCode,
          docEntry: values.docEntry,
          itemCode: values.itemCode,
          lineNum: values.lineNum,
          numAtCard: values.numAtCard,
          serialNum: values.serialNum,
          quantity: values.quantity,
          expirydate: values.expirydate,
          ManageBy: values.ManageBy,
          MfgDate: values.MfgDate,
          Pack_Quantity: values.Pack_Quantity,
          TagText: values.TagText,
          Unit_Quantity: values.Unit_Quantity,
          WhsCode: values.WhsCode,
          binlinelist: newBinlinesList
          ));
    }
  }

  List<binlines> binlinelist222 = [];
  List<Documentsbackup> finalbackup = [];
  List<postInwitemBatchlist> postBatchlist = [];
  savefinal(BuildContext context) async {
    binlinelist222.clear();
    postBatchlist.clear();
    finalsavelist.clear();
    addputaway.clear();
    final Database db = (await DBhelper.getinstance())!;
    finallodaing = true;
    notifyListeners();
    // await gettotal();
    for (int i = 0; i < inwItemList.length; i++) {
      if (inwItemList[i].Unit_Quantity == getqty[i]) {
        ;
        await DBoperation.saveAllDatafinal(
                inwItemList[i].DocEntry.toString(),
                inwItemList[i].ItemCode.toString(),
                inwItemList[i].LineNum.toString(),
                db)
            .then((value) {
          if (value != null) {
            for (int ik = 0; ik < value.length; ik++) {
              //  binlinelist222.clear();
              methodfinalsave2222(value[ik]);
              //   binlinelist222.add(
              //     binlines(
              //       bincode: value[i].binCode,
              //       binqty: value[i].quantity.toInt()
              //       )

              //   );
              //   finalsavelist.add(Documents(
              //     binlinelist: binlinelist222,
              //       itemname: value[i].itemname,
              //       binCode:value[i]. binCode,
              //       docEntry:value[i]. docEntry,
              //       itemCode:value[i]. itemCode,
              //       lineNum:value[i]. lineNum,
              //       numAtCard:value[i]. numAtCard,
              //       serialNum:value[i]. serialNum,
              //       quantity:value[i]. quantity,
              //       expirydate:value[i]. expirydate,
              //       ManageBy:value[i]. ManageBy,
              //       MfgDate:value[i]. MfgDate,
              //       Pack_Quantity:value[i]. Pack_Quantity,
              //       TagText: value[i].TagText,
              //       Unit_Quantity:value[i]. Unit_Quantity,
              //       WhsCode:value[i]. WhsCode
              //       )) ;
              // log("binlinelist222::"+finalsavelist[0].binlinelist![0].binqty.toString());
            }
          }
          log("finalsavelist::" + finalsavelist.length.toString());
        });
      }
    }
    // await DBoperation.saveAllData("${inwItemList[index ?? 0].DocEntry}", db)
    //     .then((values) async {
//     for(int i=0;i< finalsavelist.length;i++){
// binlinelist.add(
//   binlines(
//     bincode: finalsavelist[i].binCode,
//     binqty: finalsavelist[i].quantity.toInt()
//     )
// );
//     }

    await InwSaveApi.getData(
      finalsavelist,
    ).then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        finallodaing = false;
        // postBatchlist = value.inwardsaveheader!.datadetail!;
        // for (int i = 0; i < postBatchlist.length; i++) {
        //   // if (postBatchlist[i].ManageBy!.toLowerCase() == 'b') {
        //   methodputaway(values, postBatchlist[i]);
        //   // }
        // }

        // if (addputaway.isNotEmpty) {
        //   await PutawaysaveApi.getData(addputaway).then((value) async {
        //     if (value.stcode! >= 200 && value.stcode! <= 210) {
        //       finallodaing = false;
        //       notifyListeners();
        //       // final audio = AudioPlayer();

        //       // audio.setAsset("Asset/next_click.mp3");
        //       // audio.play();
        //       // //  savelistinwardState().  playsound("next_click");
        //       // showdialogsave(context, "Asset/check.png", "Success",
        //       //     value.exception.toString());
        //       //  await DBoperation.putawaydeleteAll(db);
        //       notifyListeners();
        //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        //       finallodaing = false;
        //       notifyListeners();
        //       final audio = AudioPlayer();
        //       audio.setAsset("Asset/Invalid_bin.mp3");
        //       audio.play();
        //       //  savelistinwardState().    playsound("Invalid_bin");
        //       showdialogsave(context, "Asset/cancel.png", "Failed",
        //           "${value.message}..${value.exception.toString()}");
        //       notifyListeners();
        //     } else {
        //       if (value.exception!.contains("Network is unreachable")) {
        //         finallodaing = false;
        //         final audio = AudioPlayer();
        //         audio.setAsset("Asset/Invalid_bin.mp3");
        //         audio.play();
        //         // savelistinwardState(). playsound("Invalid_bin");
        //         showdialogsave(context, "Asset/cancel.png", "Failed",
        //             "Network Issue..Try again Later..!!");
        //         // inwexception2 =
        //         //     "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
        //         notifyListeners();
        //       } else {
        //         finallodaing = false;
        //         final audio = AudioPlayer();
        //         audio.setAsset("Asset/Invalid_bin.mp3");
        //         audio.play();
        //         // savelistinwardState().  playsound("Invalid_bin");
        //         showdialogsave(context, "Asset/cancel.png", "Failed",
        //             "${value.stcode}..${value.exception}..!!");

        //         // inwexception2 = "${value.stcode}..${value.exception}..!!";
        //         notifyListeners();
        //       }
        //     }
        //   });
        // }
        notifyListeners();
        final audio = AudioPlayer();

        audio.setAsset("Asset/next_click.mp3");
        audio.play();
        //  savelistinwardState().  playsound("next_click");
        showdialogsave(
            context, "Asset/check.png", "Success", value.exception.toString());
//               await DBoperation.saveAllDataBin("${inwItemList[index ?? 0].DocEntry}", db).then((value){
// if(value != null && value.isNotEmpty){
//   log("binnnn");
// }
//               });
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
    // });
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
                                    isfinalloop = false;

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

  bool isPressed = false;
  showdialogback(BuildContext context) async {
    isPressed = true;
    notifyListeners();
    final audio = AudioPlayer();

    await audio.stop();

    await audio.setAsset("Asset/scan_serial_wrong.mp3");
    showDialog(
        context: context,
        builder: (_) {
          final theme = Theme.of(context);

          audio.play();
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
                              "Do you want go back without saving anything??",
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setst(() {
                                        isPressed = false;
                                        notifyListeners();
                                        Navigator.pop(context);
                                        FocusScope.of(context).unfocus();
                                        pageController.animateToPage(
                                            --pageChanged,
                                            duration:
                                                Duration(milliseconds: 250),
                                            curve: Curves.bounceIn);
                                      });
                                    },
                                    child: Text("Yes")),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setst(() {
                                        isPressed = false;
                                        notifyListeners();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("No"))
                              ],
                            )
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

  // showdialogcheck(BuildContext context) async {
  //   final audio = AudioPlayer();
  //   await audio.stop();

  //   await audio.setAsset("Asset/scan_serial_wrong.mp3");
  //   await audio.play();
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (_) {
  //         final theme = Theme.of(context);
  //         return StatefulBuilder(builder: (context, setst) {
  //           return WillPopScope(
  //             onWillPop: () async => false,
  //             child: AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               insetPadding: EdgeInsets.all(2),
  //               content: Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(5),
  //                   topRight: Radius.circular(5),
  //                 )),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                           color: theme.primaryColor,
  //                           borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(5),
  //                             topRight: Radius.circular(5),
  //                           )),
  //                       width: Screens.width(context),
  //                       height: Screens.padingHeight(context) * 0.05,
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "Alert",
  //                         style: theme.textTheme.bodyText1!
  //                             .copyWith(color: Colors.white),
  //                       ),
  //                     ),
  //                     Container(
  //                       padding: EdgeInsets.all(8),
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Container(
  //                               child: Text(
  //                             "In mobile device has an existing scanned data for this item..!!\n which data do u want shown..??",
  //                             textAlign: TextAlign.center,
  //                           )),
  //                           SizedBox(
  //                             height: Screens.padingHeight(context) * 0.02,
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               ElevatedButton(
  //                                   onPressed: () {
  //                                     setst(() {
  //                                       // getDBData(index!);
  //                                       Navigator.pop(context);
  //                                     });
  //                                   },
  //                                   child: Text("Mobile")),
  //                               SizedBox(
  //                                 width: Screens.width(context) * 0.02,
  //                               ),
  //                               ElevatedButton(
  //                                   onPressed: () {
  //                                     setst(() {
  //                                       dbdata.clear();
  //                                       addcheckfrombatch();
  //                                       Navigator.pop(context);
  //                                     });
  //                                   },
  //                                   child: Text("Portal"))
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         });
  //       });
  // }

  showdialogputaway(BuildContext context) async {
    // final audio = AudioPlayer();
    // await audio.stop();

    // await audio.setAsset("Asset/scan_serial_wrong.mp3");
    //  audio.play();
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
                              "Changing to putaway will clear the scanned items ..do you want to proceed..?",
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setst(() {
                                        isputawaycheck = !isputawaycheck;

                                        isonputchange = false;
                                        dbdata.clear();
                                        notifyListeners();
                                        Navigator.pop(context);
                                        // FocusScope.of(context).unfocus();
                                        mycontroller[1].clear();
                                      });
                                    },
                                    child: Text("Yes")),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setst(() {
                                        isonputchange = false;
                                        isPressed = false;
                                        notifyListeners();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("No"))
                              ],
                            )
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

  savedbinw() async {
    final Database db = (await DBhelper.getinstance())!;
    int docEntry = inwItemList[index!].DocEntry!;
    DBoperation.uidExists(
            docEntry.toString(),
            inwItemList[index!].ItemCode.toString(),
            inwItemList[index!].LineNum.toString(),
            db)
        .then((value) async {
      log("valalalal :" + value.toString());
      if (value != null) {
        DBoperation.delete(docEntry, inwItemList[index!].ItemCode.toString(),
            inwItemList[index!].LineNum.toString(), db);
        var values;
        for (int i1 = 0; i1 < dbdata.length; i1++) {
          print("data.length: ${dbdata.length}");
          print("i11111: $i1");
          List<binlines> binlinelist = [
            binlines(
                bincode: dbdata[i1].binCode,
                binqty: dbdata[i1].quantity.toInt())
          ];
          var val = Documents(
              itemname: inwItemList[index!].ItemName!,
              ManageBy: inwItemList[index!].ManageBy!,
              MfgDate: Config.currentDate(),
              Pack_Quantity: inwItemList[index!].Pack_Quantity!,
              Unit_Quantity: inwItemList[index!].Unit_Quantity!,
              TagText: "",
              WhsCode: ConstantValues.Whsecode,
              binCode: dbdata[i1].binCode,
              docEntry: dbdata[i1].docEntry,
              itemCode: dbdata[i1].itemCode,
              lineNum: dbdata[i1].lineNum,
              numAtCard: dbdata[i1].numAtCard,
              serialNum: dbdata[i1].serialNum,
              quantity: dbdata[i1].quantity,
              expirydate: dbdata[i1].expirydate,
              binlinelist: binlinelist);
          values = val;
          DBoperation.insert(values, db).then((value) async {
            print("inserted!!..");
            DBoperation.uidExists(
                docEntry.toString(),
                inwItemList[index!].ItemCode.toString(),
                inwItemList[index!].LineNum.toString(),
                db);
            // setState(() {

            // grpDetails
            //     .clear();
            // });
            notifyListeners();
            // callApi();

            // getItemsQty();
            // getAllQuantity();
            // getLocalQuantity();
          });
        }
        getqty.clear();
        await gettotal();
        await getsaveenable();
        ScanTotal = 0;
        finaldoc.clear();
        GetAllDBqty();
        notifyListeners();
        pageController.animateToPage(--pageChanged,
            duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      } else {
        var values;
        for (int i1 = 0; i1 < dbdata.length; i1++) {
          print("data.length: ${dbdata.length}");
          print("i22222: $i1");
          List<binlines> binlinelist = [
            binlines(
                bincode: dbdata[i1].binCode,
                binqty: dbdata[i1].quantity.toInt())
          ];
          var val = Documents(
              itemname: inwItemList[index!].ItemName!,
              ManageBy: inwItemList[index!].ManageBy!,
              MfgDate: Config.currentDate(),
              Pack_Quantity: inwItemList[index!].Pack_Quantity!,
              Unit_Quantity: inwItemList[index!].Unit_Quantity!,
              TagText: "",
              WhsCode: ConstantValues.Whsecode,
              binCode: dbdata[i1].binCode,
              docEntry: dbdata[i1].docEntry,
              itemCode: dbdata[i1].itemCode,
              lineNum: dbdata[i1].lineNum,
              numAtCard: dbdata[i1].numAtCard,
              serialNum: dbdata[i1].serialNum,
              quantity: dbdata[i1].quantity,
              expirydate: dbdata[i1].expirydate,
              binlinelist: binlinelist);
          values = val;
          DBoperation.insert(values, db).then((value) async {
            print("inserted!!..");
            DBoperation.uidExists(
                docEntry.toString(),
                inwItemList[index!].ItemCode.toString(),
                inwItemList[index!].LineNum.toString(),
                db);
            // setState(() {

            //       ScanTotal=0;
            // finaldoc.clear();
            //        await GetAllDBqty();
            // grpDetails
            //     .clear();
            notifyListeners();
            // });
            // callApi();
            // getItemsQty();
            // getAllQuantity();
            // getLocalQuantity();
          });
        }

        // DataBaseHelper.insert(
        //         values)
        //     .then((value) {
        //   print("inserted!!..");
        getqty.clear();
        await gettotal();
        await getsaveenable();
        ScanTotal = 0;
        finaldoc.clear();
        GetAllDBqty();
        notifyListeners();
        pageController.animateToPage(--pageChanged,
            duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      }
    });
  }

  callgetdocentry(int docentry) async {
    isloading2 = true;
    inwexception2 = '';
    inwdocDetail.clear();
    inwItemList.clear();
    beforeinwItemList.clear();
    inwitemBatchlist.clear();
    notifyListeners();
    await GetInwardByidApi.getdata(docentry).then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getInwByidheader!.inwItemList != null &&
            value.getInwByidheader!.inwItemList!.isNotEmpty) {
          inwdocDetail = value.getInwByidheader!.inwPendingDetail!;
          beforeinwItemList = value.getInwByidheader!.inwItemList!;
          inwItemList = beforeinwItemList;
          if (value.getInwByidheader!.inwitemBatchlist != null) {
            log("inwitemBatchlist::" + inwitemBatchlist.length.toString());
            inwitemBatchlist = value.getInwByidheader!.inwitemBatchlist!;
            for (int i = 0; i < inwitemBatchlist.length; i++) {
              await checkbatchlist2(inwitemBatchlist[i]);
            }

            // checkbatchlist(docentry);
            notifyListeners();
          }
          log("inwItemList::" + inwItemList.length.toString());
          if (inwItemList.isNotEmpty) {
            getqty.clear();
            await gettotal();
            await getsaveenable();
            await getAllQuantity();
            ScanTotal = 0;
            finaldoc.clear();
            await GetAllDBqty();
            notifyListeners();
          }

          isloading2 = false;
          inwexception2 = '';
          notifyListeners();
        } else if (value.getInwByidheader!.inwItemList! == null ||
            value.getInwByidheader!.inwItemList!.isEmpty) {
          isloading2 = false;
          inwexception2 = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading2 = false;
        inwexception2 = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading2 = false;
          inwexception2 =
              "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else if (value.exception!.contains("<html><head>")) {
          final RegExp pTagRegExp = RegExp(r'<p>(.*?)</p>', dotAll: true);
          final Match? match = pTagRegExp.firstMatch(value.exception!);
          final String pTagContent = match != null ? match.group(1) ?? '' : '';
          isloading2 = false;
          inwexception2 = "${value.stcode}..${pTagContent}..!!";
        } else {
          isloading2 = false;
          inwexception2 = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
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
          inwexception = '';
          log("Bincodelist::" + Bincodelist.length.toString());
          notifyListeners();
        } else if (value.binDetailheader!.itemlist == null ||
            value.binDetailheader!.itemlist!.isEmpty) {
          isloading = false;
          inwexception = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        inwexception = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading = false;
          inwexception =
              "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading = false;
          inwexception = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
    // });
  }

  mapvalues(List<InwPendingDetailList> pendingdata) async {
    pendinglist.clear();
    filterpendinglist.clear();
    for (int i = 0; i < pendingdata.length; i++) {
      if (pendingdata[i].OrderStatus!.toLowerCase() == 'open' ||
          pendingdata[i].OrderStatus!.toLowerCase() == 'pending') {
        pendinglist.add(InwPendingDetailList(
            AlternateMobileNo: pendingdata[i].AlternateMobileNo,
            AttachURL1: pendingdata[i].AttachURL1,
            AttachURL2: pendingdata[i].AttachURL2,
            AttachURL3: pendingdata[i].AttachURL3,
            AttachURL4: pendingdata[i].AttachURL4,
            AttachURL5: pendingdata[i].AttachURL5,
            BaseDocDate: pendingdata[i].BaseDocDate,
            BaseDocId: pendingdata[i].BaseDocId,
            BaseDocRef: pendingdata[i].BaseDocRef,
            Bil_Address1: pendingdata[i].Bil_Address1,
            Bil_Address2: pendingdata[i].Bil_Address2,
            Bil_Address3: pendingdata[i].Bil_Address3,
            Bil_Area: pendingdata[i].Bil_Area,
            Bil_City: pendingdata[i].Bil_City,
            Bil_Country: pendingdata[i].Bil_Country,
            Bil_District: pendingdata[i].Bil_District,
            Bil_Pincode: pendingdata[i].Bil_Pincode,
            Bil_State: pendingdata[i].Bil_State,
            CancelledDate: pendingdata[i].CancelledDate,
            CancelledReason: pendingdata[i].CancelledReason,
            CancelledRemarks: pendingdata[i].CancelledRemarks,
            CompanyName: pendingdata[i].CompanyName,
            ContactName: pendingdata[i].ContactName,
            CreatedBy: pendingdata[i].CreatedBy,
            CreatedDatetime: pendingdata[i].CreatedDatetime,
            Del_Address1: pendingdata[i].Del_Address1,
            Del_Address2: pendingdata[i].Del_Address2,
            Del_Address3: pendingdata[i].Del_Address3,
            Del_Area: pendingdata[i].Del_Area,
            Del_City: pendingdata[i].Del_City,
            Del_Country: pendingdata[i].Del_Country,
            Del_District: pendingdata[i].Del_District,
            Del_Pincode: pendingdata[i].Del_Pincode,
            Del_State: pendingdata[i].Del_State,
            Discount: pendingdata[i].Discount,
            DocDate: pendingdata[i].DocDate,
            DocEntry: pendingdata[i].DocEntry,
            DocNum: pendingdata[i].DocNum,
            DocTotal: pendingdata[i].DocTotal,
            GSTNo: pendingdata[i].GSTNo,
            GrossTotal: pendingdata[i].GrossTotal,
            InwardDocDate: pendingdata[i].InwardDocDate,
            InwardType: pendingdata[i].InwardType,
            OrderNote: pendingdata[i].OrderNote,
            OrderStatus: pendingdata[i].OrderStatus,
            PORef: pendingdata[i].PORef,
            RoundOff: pendingdata[i].RoundOff,
            SubTotal: pendingdata[i].SubTotal,
            SupplierCode: pendingdata[i].SupplierCode,
            SupplierEmail: pendingdata[i].SupplierEmail,
            SupplierMobile: pendingdata[i].SupplierMobile,
            SupplierName: pendingdata[i].SupplierName,
            TaxAmount: pendingdata[i].TaxAmount,
            TransRef: pendingdata[i].TransRef,
            UpdatedBy: pendingdata[i].UpdatedBy,
            UpdatedDatetime: pendingdata[i].UpdatedDatetime,
            WhsCode: pendingdata[i].WhsCode,
            WhsName: pendingdata[i].WhsName,
            isCancelled: pendingdata[i].isCancelled,
            traceid: pendingdata[i].traceid));
        // pendinglist = pendinglist;
        filterpendinglist = pendinglist;
      }
    }
    notifyListeners();
  }

  List<InwPendingDetailList> pendinglist = [];
  List<InwPendingDetailList> filterpendinglist = [];
  List<InwPendingDetailList> get getpendinglist => pendinglist;
  Getinwardpending() async {
    pendinglist.clear();
    filterpendinglist.clear();
    isloading = true;
    notifyListeners();
    // Future.delayed(const Duration(seconds: 3), () {
    await PendingInwardApi.getdata().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.inwardDetailheader!.itemlist != null &&
            value.inwardDetailheader!.itemlist!.isNotEmpty) {
          pendinglist = value.inwardDetailheader!.itemlist!;
          filterpendinglist = pendinglist;
          // isloading = false;
          // mapvalues(value.inwardDetailheader!.itemlist!);
          inwexception = '';
          GetBinMaster();
          log("pendinglist::" + pendinglist.length.toString());
          notifyListeners();
        } else if (value.inwardDetailheader!.itemlist == null ||
            value.inwardDetailheader!.itemlist!.isEmpty) {
          isloading = false;
          inwexception = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        inwexception = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading = false;
          inwexception =
              "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading = false;
          inwexception = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
    // });
  }
  //  bool _isPlaying = false;
  // Future<void> playsound(String sound) async {

  // AudioPlayer audio =  AudioPlayer();
  //   if (_isPlaying) {

  //     await audio.stop();
  //   }

  //     _isPlaying = true;
  //     notifyListeners();

  //   try {

  //     await audio.setAsset("Asset/$sound.mp3");
  //     await audio.play();
  //   } catch (e) {
  //     log("Error: $e");
  //   } finally {
  //     // setState(() {
  //       _isPlaying = false;
  //       notifyListeners();
  //     // });
  //   }
  // }
// Future<void> playsound(String sound)async{
//   log("soundsound::"+sound.toString());
//   AudioPlayer audio =  AudioPlayer();
//  try{
//   audio.stop();
//   audio.setAsset("Asset/$sound.mp3");
//   audio.play();
//  }catch(e){
//   log("eee::"+e.toString());
//  }
//   // audio.setAsset("Asset/$sound.mp3");
//   // audio.play();

// }
  afterBinScanned(String code, BuildContext context) async {
    bool isbintrue = false;
    if (Bincodelist.isNotEmpty) {
      for (int i = 0; i < Bincodelist.length; i++) {
        if (Bincodelist[i].BinCode!.toLowerCase() == code.toLowerCase()) {
          isbintrue = true;

          notifyListeners();
          break;
        }
      }
      if (isbintrue == true) {
        mycontroller[0].text = code;
        final audio = AudioPlayer();
        await audio.setAsset("Asset/bin_selection.mp3");
        audio.play();
        notifyListeners();
      } else {
        final audio = AudioPlayer();
        await audio.setAsset("Asset/scan_serial_wrong.mp3");
        audio.play();
        showdialogtoast(context, "Entered Bincode is not in Bin Master..!!");
        mycontroller[0].clear();
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

    //  savelistinwardState(). playsound("bin_selection");
    notifyListeners();
  }

  Scanneddata() {}
  secondpage(InwPendingDetailList pendinglist) async {
    savelistinwardState.pendinglist = pendinglist;
    Get.toNamed(ConstantRoutes.inwardsavepage);
    notifyListeners();
  }

  bool iscamera = false;
  bool iscamera2 = false;
  bool iscamera3 = false;
  clearbinfield() {
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    iscamera = false;
    iscamera2 = false;
    mycontroller[2].text = '1';
    isputawaycheck = false;
    notifyListeners();
  }

  clearontap() {
    isloading2 = false;
    inwexception2 = '';
    isputawaycheck = false;
    index = null;
    inwdocDetail.clear();
    finallodaing = false;
    inwItemList.clear();
    beforeinwItemList.clear();
    inwitemBatchlist.clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    notifyListeners();
  }

  clearAll() {
    clearbinfield();
    finalsavelist.clear();
    addputaway.clear();
    isfinalloop = false;
    mycontroller[6].clear();
    finallodaing = false;
    iscamera = false;
    iscamera2 = false;
    isputawaycheck = false;
    isloading2 = false;
    index = null;
    mycontroller[5].clear();
    inwexception2 = '';
    inwdocDetail.clear();
    inwItemList.clear();
    beforeinwItemList.clear();
    inwitemBatchlist.clear();
    getqty.clear();
    //
    isloading = false;
    inwexception = '';
    pendinglist.clear();
    filterpendinglist.clear();
    Bincodelist.clear();
    notifyListeners();
  }

  init() {
    clearAll();
    Getinwardpending();
    // GetBinMaster();
  }
// inwardcontroller(){
//   clearAll();
//   Getinwardpending();

// //    Future.delayed(const Duration(seconds: 3), () {
// // dummyshow=[
// //     dummylist(
// //       itemcode: "231120",
// //       itemname: "Sony india Ltd",
// //       itemcount: "5",
// //       itemqty: "45",
// //       itemcode2: "V0001"
// //       ),
// // dummylist(
// //       itemcode: "231121",
// //       itemname: "Sony india Ltd",
// //       itemcount: "5",
// //       itemqty: "45",
// //        itemcode2: "V0002"
// //       ),
// //       dummylist(
// //       itemcode: "231122",
// //       itemname: "Sony india Ltd",
// //       itemcount: "6",
// //       itemqty: "46",
// //        itemcode2: "V0003"
// //       ),
// //       dummylist(
// //       itemcode: "231123",
// //       itemname: "Sony india Ltd",
// //       itemcount: "7",
// //       itemqty: "47",
// //        itemcode2: "V0005"
// //       ),
// //       dummylist(
// //       itemcode: "231117",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //       dummylist(
// //       itemcode: "231116",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //       dummylist(
// //       itemcode: "231115",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //       dummylist(
// //       itemcode: "231114",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //       dummylist(
// //       itemcode: "231113",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //       dummylist(
// //       itemcode: "231112",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //       dummylist(
// //       itemcode: "231111",
// //       itemname: "Sony india Ltd",
// //       itemcount: "8",
// //       itemqty: "48",
// //        itemcode2: "V0004"
// //       ),
// //   ];
// //   notifyListeners();
// //    });

// }
}

class dummylist {
  String? itemcode;
  String? itemname;
  String? itemcode2;
  String? itemcount;
  String? itemqty;
  dummylist({
    required this.itemcode2,
    required this.itemcode,
    required this.itemname,
    required this.itemcount,
    required this.itemqty,
  });
}
