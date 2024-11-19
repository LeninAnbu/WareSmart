import 'dart:developer';

import 'package:WareSmart/Model/BincontentModel/BincontentModel.dart';
import 'package:WareSmart/Services/BinContentApi/BincontentApi.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:flutter/material.dart';

class ItemSearchController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  String? seialScannedCode = '';
  String? itemScannedCode = '';
  String? binScannedCode = '';
  FocusNode focus1 = FocusNode();
  totalQuantity() {
    double totalqty = 0;
    for (int i = 0; i < bincontentList.length; i++) {
      int? qty = bincontentList[i].BinQty!.toInt();

      totalqty = totalqty + qty;
    }
    return totalqty.toStringAsFixed(0);
  }

  init() {
    clearAll();
  }

  List<BincontentList> bincontentList = [];
  bool isloading = false;
  String qrerror = '';
  GetAllData(BuildContext context, int? value) async {
    bincontentList.clear();

    isloading = true;
    notifyListeners();
    if (value == 1) {
      await BincontentApi.getdata(
              "All", "$seialScannedCode", "All", ConstantValues.Whsecode)
          .then((value) {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          if (value.bincontentheader!.itemlist != null &&
              value.bincontentheader!.itemlist!.isNotEmpty) {
            bincontentList = value.bincontentheader!.itemlist!;

            qrerror = '';
            FocusScope.of(context).unfocus();

            log("pendinglist::" + bincontentList.length.toString());
            notifyListeners();
          } else if (value.bincontentheader!.itemlist == null ||
              value.bincontentheader!.itemlist!.isEmpty) {
            isloading = false;
            qrerror = "No data Found..!!";
            notifyListeners();
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          isloading = false;
          qrerror = "${value.message}..${value.exception}..!!";
          notifyListeners();
        } else {
          if (value.exception!.contains("Network is unreachable")) {
            isloading = false;
            qrerror =
                "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
            notifyListeners();
          } else {
            isloading = false;
            qrerror = "${value.stcode}..${value.exception}..!!";
            notifyListeners();
          }
        }
      });
    } else if (value == 2) {
      await BincontentApi.getdata(
              "$itemScannedCode", "All", "All", ConstantValues.Whsecode)
          .then((value) {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          if (value.bincontentheader!.itemlist != null &&
              value.bincontentheader!.itemlist!.isNotEmpty) {
            bincontentList = value.bincontentheader!.itemlist!;

            qrerror = '';
            FocusScope.of(context).unfocus();

            log("pendinglist::" + bincontentList.length.toString());
            notifyListeners();
          } else if (value.bincontentheader!.itemlist == null ||
              value.bincontentheader!.itemlist!.isEmpty) {
            isloading = false;
            qrerror = "No data Found..!!";
            notifyListeners();
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          isloading = false;
          qrerror = "${value.message}..${value.exception}..!!";
          notifyListeners();
        } else {
          if (value.exception!.contains("Network is unreachable")) {
            isloading = false;
            qrerror =
                "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
            notifyListeners();
          } else {
            isloading = false;
            qrerror = "${value.stcode}..${value.exception}..!!";
            notifyListeners();
          }
        }
      });
    } else if (value == 3) {
      await BincontentApi.getdata(
              "All", "All", "$binScannedCode", ConstantValues.Whsecode)
          .then((value) {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          if (value.bincontentheader!.itemlist != null &&
              value.bincontentheader!.itemlist!.isNotEmpty) {
            bincontentList = value.bincontentheader!.itemlist!;

            qrerror = '';
            FocusScope.of(context).unfocus();

            log("pendinglist::" + bincontentList.length.toString());
            notifyListeners();
          } else if (value.bincontentheader!.itemlist == null ||
              value.bincontentheader!.itemlist!.isEmpty) {
            isloading = false;
            qrerror = "No data Found..!!";
            notifyListeners();
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          isloading = false;
          qrerror = "${value.message}..${value.exception}..!!";
          notifyListeners();
        } else {
          if (value.exception!.contains("Network is unreachable")) {
            isloading = false;
            qrerror =
                "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
            notifyListeners();
          } else {
            isloading = false;
            qrerror = "${value.stcode}..${value.exception}..!!";
            notifyListeners();
          }
        }
      });
    }
  }

  clearAll() {
    isloading = false;
    bincontentList.clear();
    qrerror = '';
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    notifyListeners();
  }
}
