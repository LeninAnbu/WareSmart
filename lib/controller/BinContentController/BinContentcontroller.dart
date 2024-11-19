import 'dart:developer';

import 'package:WareSmart/Model/BincontentModel/BincontentModel.dart';
import 'package:WareSmart/Services/BinContentApi/BincontentApi.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:flutter/material.dart';

class BinContentController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  String? ScannedCode = '';
  FocusNode focus1 = FocusNode();

  init() {
    clearAll();
    notifyListeners();
  }
List<BincontentList> bincontentList=[];
bool isloading=false;
String qrerror='';

  GetAllData(BuildContext context) async {
    bincontentList.clear();
    bincontentList.clear();
    isloading=true;
    notifyListeners();
    await BincontentApi.getdata(
            "All", "All", ScannedCode, ConstantValues.Whsecode)
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
           isloading=false;
          qrerror = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
         isloading=false;
        qrerror = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading=false;
          qrerror = "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading=false;
          qrerror = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
        });
  }
totalQuantity(){
  double totalqty=0;
  for (int i=0;i<bincontentList.length;i++){
    int? qty=bincontentList[i].BinQty!.toInt();
    
totalqty=totalqty+qty;
  }
  return totalqty.toStringAsFixed(0);
}
  clearAll() {
    isloading=false;
    bincontentList.clear();
    qrerror='';
    mycontroller[0].clear();
    ScannedCode = '';
    notifyListeners();
  }
}
