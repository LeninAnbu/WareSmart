
import 'dart:developer';

import 'package:WareSmart/Model/PickupModel/GetPickupModel.dart';
import 'package:WareSmart/Services/PickupApi/getpickupApi.dart';
import 'package:WareSmart/Services/PickupApi/postpickupApi.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/helperfunc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PickupController extends ChangeNotifier{
 List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  bool loading =false;
 bool finalloading=false;
   bool checkserial =false;
  String? scannedCode='';
  String? SerialscannedCode='';
  
  init(){
    clearalldata();
  
  }
  checkserialNum(BuildContext context)async{
    log("pickupdetailslist[0].SerialBatch::"+pickupdetailslist[0].SerialBatch!.toString());
    if(pickupdetailslist[0].Pref_BatchSerial !=null &&pickupdetailslist[0].Pref_BatchSerial!.isNotEmpty){
      if(pickupdetailslist[0].Pref_BatchSerial!.toLowerCase() == SerialscannedCode!.toLowerCase()){
       final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
        mycontroller[1].text =SerialscannedCode!;
      //  disableKeyBoard(context);
      focus1.unfocus();
         notifyListeners();

      }else{
        final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
        showdialogtoast(context,"Entered serial number is not match with given serial number");
     mycontroller[1].clear();
      notifyListeners();
      }
    }else{
       final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/next_click.mp3");
            audio.play();
      mycontroller[1].text =SerialscannedCode!;
      //  disableKeyBoard(context);
       focus1.unfocus();
      notifyListeners();
    }
  }
  List<PickupDetailList> pickupdetailslist=[];
  callapiscan(BuildContext context)async{
    pickupdetailslist.clear();
    mycontroller[1].clear();
    SerialscannedCode='';
    finalloading=false;
    loading =true;
    notifyListeners();
    await GetPickupApi.getdata(scannedCode).then((value) async{
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.pickupheaderheader!.itemlist != null &&
            value.pickupheaderheader!.itemlist!.isNotEmpty) {
          pickupdetailslist = value.pickupheaderheader!.itemlist!;
          disableKeyBoard(context);
           final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/next_click.mp3");
            audio.play();
          Get.toNamed(ConstantRoutes.detailspickup);
           
          mycontroller[0].clear();
        
         loading =false;
    notifyListeners();
          log("pendinglist::" + pickupdetailslist.length.toString());
          notifyListeners();
        } else if (value.pickupheaderheader!.itemlist == null ||
            value.pickupheaderheader!.itemlist!.isEmpty) {
          loading =false;
           final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
          showdialogtoast(context,"${value.message!}..!!No data Found..!!");
          mycontroller[0].clear();
    notifyListeners();
          
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        loading =false;
     showdialogtoast(context,"${value.message!}..!!${value.exception!}..!!");
        mycontroller[0].clear();  
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          loading =false;
           showdialogtoast(context,"${value.message!}..!!Network Issue..\nTry again Later..!!");
          
          notifyListeners();
        } else {
          loading = false;
         showdialogtoast(context,"${value.message!}..!!${value.exception!}..!!");
          notifyListeners();
        }
      }
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
                            
                            ElevatedButton(
                                onPressed: () {
                                  setst(() {
                                    

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
 FocusNode focus1=FocusNode();
  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }
  Postfinalapi(String? qrcode,BuildContext context)async{
    focus1.unfocus();
     disableKeyBoard(context);
    finalloading =true;
    notifyListeners();
     String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
        log("deviceID:::" + deviceID.toString());
        if (deviceID == null) {
          deviceID = await Config.getdeviceId();
          print("deviceID" + deviceID.toString());
          await HelperFunctions.saveDeviceIDSharedPreference(deviceID!);
          notifyListeners();
        }
        await postpickupApi.getData(ConstantValues.Whsecode, qrcode!, mycontroller[1].text, deviceID).then((value)async {
            if (value.stcode! >= 200 && value.stcode! <= 210) {
          finalloading = false;
          notifyListeners();
          final audio = AudioPlayer();

       await   audio.setAsset("Asset/next_click.mp3");
          audio.play();
          
          showdialogsave(context, "Asset/check.png", "Success",
              value.exception.toString());
              
          notifyListeners();
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          finalloading = false;
          notifyListeners();
          final audio = AudioPlayer();
        await  audio.setAsset("Asset/Invalid_bin.mp3");
          audio.play();
        disableKeyBoard(context);
          showdialogsave(context, "Asset/cancel.png", "Failed",
              "${value.message} ${value.exception.toString()}");
          notifyListeners();
        } else {
          if (value.exception!.contains("Network is unreachable")) {
            finalloading = false;
            final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
           disableKeyBoard(context);
            showdialogsave(context, "Asset/cancel.png", "Failed",
                "Network Issue..Try again Later..!!");
           
            notifyListeners();
          } else {
            finalloading = false;
             final audio = AudioPlayer();
            await audio.stop();
          await  audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
            disableKeyBoard(context);
            showdialogsave(context, "Asset/cancel.png", "Failed",
                "${value.stcode} ${value.exception}..!!");

           
            notifyListeners();
          }
        }
        });
  }
  clearalldata(){
    finalloading=false;
    loading =false;
    scannedCode='';
   
    mycontroller[0].clear();
    mycontroller[1].clear();
    SerialscannedCode='';
    pickupdetailslist.clear();
    notifyListeners();
  }
  
}
class dummydata{
    int? AutoID;
    String? orderqrid;
    String? shortqrid;
    String? brand;
    String? segment;
    String? itemcode;
    String? itemname;
    String? serialnumber1;
    String? serialnumber2;
    String? bin;
    dummydata({
      required this.AutoID,
      required this.bin,
      required this.brand,
      required this.itemcode,
      required this.itemname,
      required this.orderqrid,
      required this.segment,
      required this.serialnumber1,
      required this.serialnumber2,
      required this.shortqrid

    });
}