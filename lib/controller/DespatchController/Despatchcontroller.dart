import 'dart:developer';

import 'package:WareSmart/Model/DespatchModel/getaLldetailsModel.dart';
import 'package:WareSmart/Services/DesptachApi/GetdesptchApi.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:flutter/material.dart';

class DespatchController extends ChangeNotifier {
  init() {
    clearall();

    getopendata();
  }

  List<dummydata> dummylist = [];
  bool isloading = false;
  String iserror = '';
  List<DesOPENList> openlist = [];
  Config config =Config();
  getopendata() async {
    openlist.clear();
    iserror = '';
    isloading = true;
    notifyListeners();
    await GetDespatchApi.getdata().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.desopenheader!.itemlist != null &&
            value.desopenheader!.itemlist!.isNotEmpty) {
          openlist = value.desopenheader!.itemlist!;

          isloading = false;

         
          iserror = '';
          

          log("pendinglist::" + openlist.length.toString());
          notifyListeners();
        } else if (value.desopenheader!.itemlist == null ||
            value.desopenheader!.itemlist!.isEmpty) {
          isloading = false;
          iserror = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        iserror = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading = false;
          iserror = "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading = false;
          iserror = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
  }

  clearall() {
    dummylist.clear();
    openlist.clear();
    iserror = '';
    isloading = false;
    notifyListeners();
  }
}

class dummydata {
  String? Despatchno;
  String? DateTime;
  String? noofitems;
  String? driver;
  String? vehicleno;
  dummydata(
      {required this.Despatchno,
      required this.DateTime,
      required this.driver,
      required this.noofitems,
      required this.vehicleno});
}
