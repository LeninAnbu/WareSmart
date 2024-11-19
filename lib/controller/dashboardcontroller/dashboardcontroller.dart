

import 'dart:developer';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:WareSmart/DBModel/inwardDBmodel.dart';
import 'package:WareSmart/DBhelper/DBhelper.dart';
import 'package:WareSmart/DBhelper/DBoperation.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/helperfunc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class dashBoardcontroller extends ChangeNotifier{
List<dummylist> dummyshow=[];
init()async{
 await clearall();
 checkConnectivity();
  callApi();
}
logout()async{
  await HelperFunctions. clearUserName();
  await HelperFunctions.clearUserCodeDSharedPref();
 await HelperFunctions. clearCheckedTennetIDSharedPref();
 await HelperFunctions.clearHost();
  Get.offAllNamed(ConstantRoutes.login);
  notifyListeners();
}
clearall()async{
  dummyshow.clear();
  // isscanner=false;
  loading =false;
  // ConstantValues.scanneruser=false;
}
List<Documents> dball=[];
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
          "${externalDbPath} db saved Successfully", Colors.green,context);
    } else {
      print("Database file does not exist.");
    }
  }
 showSnackBars(String e, Color color,BuildContext context) {
   SnackBar  snackBar = SnackBar(
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
      showSnackBars("$e", Colors.red,context);
    }
    return Future.value(false);
  }
checkConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    log("connectivityResult::"+connectivityResult.toString());
     if (connectivityResult.contains(ConnectivityResult.none)) {
      ConstantValues.networkonline=true;
      notifyListeners();
        // isLoading = false;
        // exceptionOnApiCall = 'Please Check Internet Connection..!!';
      }else{
 ConstantValues.networkonline=false;
  notifyListeners();
      }
}
bool loading =false;
callApi(){
  loading=true;
  notifyListeners();
 Future.delayed(const Duration(seconds: 2), () {
dummyshow=[
    dummylist(
      itemcode: "231120", 
      itemname: "Sony india Ltd", 
      itemcount: "5", 
      itemqty: "45"
      ),
dummylist(
      itemcode: "231121", 
      itemname: "Sony india Ltd", 
      itemcount: "5", 
      itemqty: "45"
      ),
      dummylist(
      itemcode: "231122", 
      itemname: "Sony india Ltd", 
      itemcount: "6", 
      itemqty: "46"
      ),
      dummylist(
      itemcode: "231123", 
      itemname: "Sony india Ltd", 
      itemcount: "7", 
      itemqty: "47"
      ),
      dummylist(
      itemcode: "231128", 
      itemname: "Sony india Ltd", 
      itemcount: "8", 
      itemqty: "48"
      ),
  ];
  loading =false;
  notifyListeners();
  });
}
bool isscanner=false;
choosescanner(bool val,BuildContext context){
  log("val::"+val.toString());
isscanner=val;
ConstantValues.scanneruser=val;
 
notifyListeners();
}
// final audio=AudioPlayer();
//  Future<void> playsound(String sound)async{
  
//  String audiopath ='when_checklist_popup.mp3';
  
// audio.play(AssetSource(audiopath));

// }
showdialogmenu(BuildContext context){
  showDialog(
    context: context, 
    builder: (_){
      final theme=Theme.of(context);
      return StatefulBuilder(
        builder: (context,setst) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            alignment: Alignment.topRight,
            content: Container(
             child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           Container(
                // color: Colors.amber,
          // height: Screens.padingHeight(context)*0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  
                  children: [
                    Text("Is this mobile scanner"),
                    Switch(
                  // thumb color (round icon)
                  activeColor: Colors.white,
                  activeTrackColor: theme.primaryColor,
                  inactiveThumbColor: theme.primaryColor,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: isscanner,
                  // changes the state of the switch
                  onChanged: (value) {
                    setst((){
 choosescanner(value,context);
                    });
          
          //  notifyListeners();
                  } 
             
                 
                  )
               ]  ),
                )
                    // CupertinoSwitch(
                    //  activeColor: theme.primaryColor,
                    //   thumbColor: Colors.white,
                    //    trackColor: Colors.black12,
                    //  value:context.watch<SalesNewController>(). isscanner,
                    //   // changes the state of the switch
                    //   onChanged: (value) => setState(() {
                    //     // isscanner=value;
                    // context.read<SalesNewController>().choosescanner(value);
                    //   } ),
                    // ),
                
           
              ],)
            ),
          );
        }
      );
    });
}

}

class dummylist{
  String? itemcode;
  String? itemname;
  String? itemcount;
  String? itemqty;
  dummylist({
    required this.itemcode,
    required this.itemname,
    required this.itemcount,
    required this.itemqty,


  });
}