import 'dart:developer';

import 'package:WareSmart/Model/BintoBinModel/getserialModel.dart';
import 'package:WareSmart/Model/BintoBinModel/requestpostModel.dart';
import 'package:WareSmart/Model/InwardModel/BinmasterModel.dart';
import 'package:WareSmart/Services/BintoBinApi/getserialdetailsApi.dart';
import 'package:WareSmart/Services/BintoBinApi/postbinApi.dart';
import 'package:WareSmart/Services/InwardApi/BinMasterApi.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/helperfunc.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class BintoBinController extends ChangeNotifier {
  List<dummylist> emptylist = [];
  init() {
    clearall();
    GetBinMaster();
    // getdata();
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

  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  String inwexception = '';
  clearall() {
    emptylist.clear();
    inwexception = '';
    frombincode = '';
    tobincode = '';
    binbarcode = '';
    serialloading == false;
    finalloading = false;
    serialdetaillist.clear();
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    notifyListeners();
  }

  clearpopup() {
    frombincode = '';
    tobincode = '';
    binbarcode = '';
    serialloading == false;
    finalloading = false;
    serialdetaillist.clear();
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    notifyListeners();
  }

  String frombincode = '';
  String tobincode = '';
  String binbarcode = '';
  bool finalloading = false;
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

  bool isloading = false;

  afterBinScanned22(String code, BuildContext context) async {
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
        focus1.unfocus();
        focus2.requestFocus();
        final audio = AudioPlayer();

        await audio.setAsset("Asset/bin_selection.mp3");
        audio.play();
        //  setState(() {
        QRscannerState.binserial = true;
        notifyListeners(); // });

        Navigator.push(
                context, MaterialPageRoute(builder: (context) => QRscanner()))
            .then((value) {
          if (binbarcode != '') {
            afterserialscanned(binbarcode, context);
          }
        });
        notifyListeners();
      } else {
        final audio = AudioPlayer();
        await audio.setAsset("Asset/scan_serial_wrong.mp3");
        audio.play();
        showdialogtoast(context, "Entered Bincode is not in Bin Master..!!");
        mycontroller[0].clear();
        focus2.unfocus();
        focus1.requestFocus();
        notifyListeners();
      }
    } else {
      final audio = AudioPlayer();
      await audio.setAsset("Asset/scan_serial_wrong.mp3");
      audio.play();
      showdialogtoast(context, "Bin Master is Empty..!!");
      mycontroller[0].clear();
      focus2.unfocus();
      focus1.requestFocus();
      notifyListeners();
    }

    //  savelistinwardState(). playsound("bin_selection");
    notifyListeners();
  }

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
        focus1.unfocus();
        focus2.requestFocus();
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
        focus2.unfocus();
        focus1.requestFocus();
        notifyListeners();
      }
    } else {
      final audio = AudioPlayer();
      await audio.setAsset("Asset/scan_serial_wrong.mp3");
      audio.play();
      showdialogtoast(context, "Bin Master is Empty..!!");
      mycontroller[0].clear();
      focus2.unfocus();
      focus1.requestFocus();
      notifyListeners();
    }

    //  savelistinwardState(). playsound("bin_selection");
    notifyListeners();
  }

  afterToBinScanned(String code, BuildContext context) async {
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
        mycontroller[2].text = code;
        FocusScope.of(context).unfocus();
        final audio = AudioPlayer();
        await audio.setAsset("Asset/bin_selection.mp3");
        audio.play();
        notifyListeners();
      } else {
        final audio = AudioPlayer();
        await audio.setAsset("Asset/scan_serial_wrong.mp3");
        audio.play();
        showdialogtoast(context, "Entered Bincode is not in Bin Master..!!");
        mycontroller[2].clear();
        notifyListeners();
      }
    } else {
      final audio = AudioPlayer();
      await audio.setAsset("Asset/scan_serial_wrong.mp3");
      audio.play();
      showdialogtoast(context, "Bin Master is Empty..!!");
      mycontroller[2].clear();
      notifyListeners();
    }

    //  savelistinwardState(). playsound("bin_selection");
    notifyListeners();
  }

  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
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
                                    serialloading = false;
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

  List<Binreqpost> binreqpostdata = [];
  String? inwexception2 = '';
  List<BinserialList> serialdetaillist = [];
  bool serialloading = false;
  afterserialscanned(String code, BuildContext context) async {
    mycontroller[1].text = code;
    serialdetaillist.clear();
    serialloading = true;

    notifyListeners();
    await GetBinSerialApi.getdata(code.trim(), ConstantValues.Whsecode)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.inwardDetailheader!.itemlist != null &&
            value.inwardDetailheader!.itemlist!.isNotEmpty) {
          serialdetaillist = value.inwardDetailheader!.itemlist!;
          notifyListeners();
          serialloading = false;

          mycontroller[1].text = code;
          mycontroller[3].text = "1";
          focus3.requestFocus();
          // serialdetaillist[0].SerialBatchQty!.toStringAsFixed(2);
          // isloading = false;
          // mapvalues(value.inwardDetailheader!.itemlist!);
          inwexception2 = '';

          notifyListeners();
        } else if (value.inwardDetailheader!.itemlist == null ||
            value.inwardDetailheader!.itemlist!.isEmpty) {
          // inwexception2 = "No data Found..!!";
          mycontroller[1].clear();
          showdialogtoast(context, "No data Found..!!");
          serialloading = false;
          focus2.requestFocus();
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        serialloading = false;
        mycontroller[1].clear();
        inwexception2 = "${value.message}..${value.exception}..!!";
        showdialogtoast(context, "$inwexception2");
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          serialloading = false;
          mycontroller[1].clear();
          inwexception2 =
              "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          showdialogtoast(context, "$inwexception2");
          notifyListeners();
        } else {
          serialloading = false;
          mycontroller[1].clear();
          inwexception = "${value.stcode}..${value.exception}..!!";
          showdialogtoast(context, "$inwexception2");
          notifyListeners();
        }
      }
    });
  }

  List<Binreqpost> finalsavelist = [];
  saveFinal(BuildContext context) async {
    finalsavelist.clear();
    finalloading = true;
    notifyListeners();
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    log("deviceID:::" + deviceID.toString());
    if (deviceID == null) {
      deviceID = await Config.getdeviceId();
      print("deviceID" + deviceID.toString());
      await HelperFunctions.saveDeviceIDSharedPreference(deviceID!);
      notifyListeners();
    }
    finalsavelist.add(Binreqpost(
        devicecode: deviceID,
        docdate: Config.currentDate(),
        docentry: 0,
        frombin: mycontroller[0].text,
        itemcode: serialdetaillist[0].ItemCode,
        itemname: serialdetaillist[0].ItemName,
        quantity: mycontroller[3].text,
        serialbatch: mycontroller[1].text,
        tobin: mycontroller[2].text,
        whscode: ConstantValues.Whsecode));

    await BintinSaveApi.getData(finalsavelist).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        finalloading = false;
        notifyListeners();
        final audio = AudioPlayer();

        audio.setAsset("Asset/next_click.mp3");
        audio.play();
        //  savelistinwardState().  playsound("next_click");
        showdialogsave(
            context, "Asset/check.png", "Success", value.exception.toString());

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        finalloading = false;
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
          finalloading = false;
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
          finalloading = false;
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
                                    Get.offAllNamed(
                                        ConstantRoutes.bintobinmain);
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

  showscanpopup(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          final theme = Theme.of(context);
          return StatefulBuilder(builder: (context, setst) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              content: Container(
                child: serialloading == true
                    ? Container(
                        height: Screens.padingHeight(context) * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpinKitThreeBounce(
                              size: Screens.width(context) * 0.1,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: Screens.padingHeight(context) * 0.06,
                            width: Screens.width(context),
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Text(
                              "Bin-to-Bin",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: Screens.width(context) * 0.02,
                              right: Screens.width(context) * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.06,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.grey[200],
                                  //     borderRadius: BorderRadius.circular(8),
                                  //     border: Border.all(color: Colors.black26)),
                                  child: TextFormField(
                                    controller: mycontroller[0],
                                    onEditingComplete: () {
                                      setst(() {
                                        frombincode = mycontroller[0].text;
                                        afterBinScanned(frombincode, context);
                                      });
                                    },
                                    focusNode: focus1,
                                    decoration: InputDecoration(
                                      labelText: "From Bin..!!",
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor,
                                            width: 2.0),
                                      ),
                                      suffixIcon: ConstantValues.scanneruser ==
                                              true
                                          ? Container(
                                              width:
                                                  Screens.width(context) * 0.01)
                                          : IconButton(
                                              // iconSize:
                                              //     Screens.padingHeight(context) * 0.03,
                                              color: theme.primaryColor,
                                              onPressed: QRscannerState
                                                          .frombin ==
                                                      true
                                                  ? () {}
                                                  : () {
                                                      setst(() {
                                                        QRscannerState.frombin =
                                                            true;
                                                      });

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  QRscanner())).then(
                                                          (value) {
                                                        if (frombincode != '') {
                                                          afterBinScanned(
                                                              frombincode,
                                                              context);
                                                        }
                                                      });
                                                    },
                                              icon: Icon(
                                                Icons.qr_code_outlined,
                                                size: Screens.padingHeight(
                                                        context) *
                                                    0.04,
                                              )),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            Screens.padingHeight(context) *
                                                0.02,
                                        horizontal: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.01,
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.06,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.grey[200],
                                  //     borderRadius: BorderRadius.circular(8),
                                  //     border: Border.all(color: Colors.black26)),
                                  child: TextField(
                                    controller: mycontroller[1],
                                    onEditingComplete: () {
                                      setst(() {
                                        binbarcode = mycontroller[1].text;
                                        afterserialscanned(binbarcode, context);
                                        // afterBinScanned(frombincode, context);
                                      });
                                    },
                                    focusNode: focus2,
                                    decoration: InputDecoration(
                                      labelText: "Scan Barcode..!!",
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor,
                                            width: 2.0),
                                      ),
                                      suffixIcon: ConstantValues.scanneruser ==
                                              true
                                          ? Container(
                                              width:
                                                  Screens.width(context) * 0.01)
                                          : IconButton(
                                              // iconSize:
                                              //     Screens.padingHeight(context) * 0.03,
                                              color: theme.primaryColor,
                                              onPressed: QRscannerState
                                                          .binserial ==
                                                      true
                                                  ? () {}
                                                  : () {
                                                      setst(() {
                                                        QRscannerState
                                                            .binserial = true;
                                                      });

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  QRscanner())).then(
                                                          (value) {
                                                        if (binbarcode != '') {
                                                          // setst(() {
                                                          //  serialloading == false;
                                                          // });
                                                          afterserialscanned(
                                                              binbarcode,
                                                              context);

                                                          // afterBinScanned(
                                                          //     frombincode, context);
                                                        }
                                                      });
                                                    },
                                              icon: Icon(
                                                Icons.qr_code_outlined,
                                                size: Screens.padingHeight(
                                                        context) *
                                                    0.04,
                                              )),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            Screens.padingHeight(context) *
                                                0.02,
                                        horizontal: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.01,
                                ),
                                serialdetaillist.isEmpty
                                    ? Container()
                                    : Container(
                                        width: Screens.width(context),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: theme.primaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Item Details :",
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: theme
                                                                .primaryColor),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    '${serialdetaillist[0].ItemCode}',
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    '${serialdetaillist[0].ItemName}',
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.01,
                                ),
                                serialdetaillist.isEmpty
                                    ? Container()
                                    : SizedBox(
                                        // width: Screens.width(context) ,
                                        height: Screens.padingHeight(context) *
                                            0.06,
                                        // decoration: BoxDecoration(
                                        //     color: Colors.grey[200],
                                        //     borderRadius: BorderRadius.circular(8),
                                        //     border: Border.all(color: Colors.black26)),
                                        child: TextField(
                                          controller: mycontroller[2],
                                          onEditingComplete: () {
                                            tobincode = mycontroller[2].text;
                                            afterToBinScanned(
                                                tobincode, context);
                                          },
                                          decoration: InputDecoration(
                                            labelText: "To Bin..!!",
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor,
                                                  width: 2.0),
                                            ),
                                            suffixIcon: ConstantValues
                                                        .scanneruser ==
                                                    true
                                                ? Container(
                                                    width:
                                                        Screens.width(context) *
                                                            0.01)
                                                : IconButton(
                                                    iconSize:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.04,
                                                    color: theme.primaryColor,
                                                    onPressed: QRscannerState
                                                                .tobin ==
                                                            true
                                                        ? () {}
                                                        : () {
                                                            setst(() {
                                                              QRscannerState
                                                                  .tobin = true;
                                                            });

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            QRscanner())).then(
                                                                (value) {
                                                              if (tobincode !=
                                                                  '') {
                                                                setst(() {
                                                                  afterToBinScanned(
                                                                      tobincode,
                                                                      context);
                                                                });

                                                                // afterBinScanned(
                                                                //     frombincode, context);
                                                              }
                                                            });
                                                          },
                                                    icon: Icon(
                                                      Icons.qr_code_outlined,
                                                    )),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: Screens.padingHeight(
                                                      context) *
                                                  0.02,
                                              horizontal: 5,
                                            ),
                                          ),
                                        ),
                                      ),
                                serialdetaillist.isEmpty
                                    ? Container()
                                    : SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.01,
                                      ),
                                serialdetaillist.isEmpty
                                    ? Container()
                                    : SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.06,
                                        // width: Screens.width(context) *0.9,
                                        // decoration: BoxDecoration(
                                        //     color: Colors.grey[200],
                                        //     borderRadius: BorderRadius.circular(8),
                                        //     border: Border.all(color: Colors.black26)),
                                        child: TextFormField(
                                          controller: mycontroller[3],
                                          readOnly: serialdetaillist[0]
                                                      .ManageBy!
                                                      .toLowerCase() !=
                                                  'b'
                                              ? true
                                              : false,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: "Quantity",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor,
                                                    width: 2.0),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.01,
                                                      horizontal: 5)),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.02,
                          ),
                          Container(
                            height: Screens.padingHeight(context) * 0.06,
                            width: Screens.width(context),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)))),
                                onPressed: mycontroller[1].text == '' ||
                                        mycontroller[3].text == '' ||
                                        serialdetaillist.isEmpty
                                    ? () {}
                                    : () {
                                        setst(() {
                                          saveFinal(context);
                                        });
                                      },
                                child: finalloading == true
                                    ? SpinKitThreeBounce(
                                        size: Screens.width(context) * 0.1,
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Save",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.white),
                                      )),
                          ),
                        ],
                      ),
              ),
            );
          });
        });
  }

  getdata() {
    isloading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 3), () {
      emptylist = [
        dummylist(
            Tobin: "b002",
            barcode: "SI001",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG001",
            itemname: "LG SONY",
            qty: "1"),
        dummylist(
            Tobin: "b002",
            barcode: "SI001",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG002",
            itemname: "LG SONY",
            qty: "1"),
        dummylist(
            Tobin: "b002",
            barcode: "SI001",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG003",
            itemname: "LG SONY",
            qty: "1"),
        dummylist(
            Tobin: "b002",
            barcode: "SI0012",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG004",
            itemname: "LG SONY",
            qty: "1"),
        dummylist(
            Tobin: "b002",
            barcode: "SI0013",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG005",
            itemname: "LG SONY",
            qty: "1"),
        dummylist(
            Tobin: "b002",
            barcode: "SI0015",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG006",
            itemname: "LG SONY",
            qty: "1"),
        dummylist(
            Tobin: "b002",
            barcode: "SI0017",
            date: "08-08-2024",
            frombin: "b001",
            itemcode: "LG007",
            itemname: "LG SONY",
            qty: "1")
      ];
      isloading = false;
      notifyListeners();
    });

    log("emptylist::" + emptylist.length.toString());
    notifyListeners();
  }
}

class dummylist {
  String? itemcode;
  String? itemname;
  String? barcode;
  String? date;
  String? qty;
  String? frombin;
  String? Tobin;
  dummylist(
      {required this.Tobin,
      required this.barcode,
      required this.date,
      required this.frombin,
      required this.itemcode,
      required this.itemname,
      required this.qty});
}

showBottompopup(BuildContext context, dummylist emptylist) {
  showModalBottomSheet(
      context: context,
      // showDragHandle:true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      builder: (_) {
        final theme = Theme.of(context);
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                // height: Screens.padingHeight(context) * 0.06,
                // width: Screens.width(context),
                decoration: BoxDecoration(

                    // color: theme.primaryColor,
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(8),
                    //     topRight: Radius.circular(8))
                    ),
                child: Text(
                  "Bin-to-Bin",
                  style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Screens.padingHeight(context) * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black26)),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Scan Barcode..!!",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: ConstantValues.scanneruser == true
                              ? Container(width: Screens.width(context) * 0.01)
                              : IconButton(
                                  // iconSize:
                                  //     Screens.padingHeight(context) * 0.03,
                                  color: theme.primaryColor,
                                  onPressed: () {},
                                  // context
                                  //                       .watch<
                                  //                           putawaycontroller>()
                                  //                       .  iscamera==true
                                  //     ? () {}
                                  //     : () {
                                  //         setState(() {
                                  //            context
                                  //                       .read<
                                  //                           putawaycontroller>()
                                  //                       .  iscamera=true;
                                  //           QRscannerState.putawayserial = true;
                                  //         });

                                  //         Navigator.push(
                                  //                 context,
                                  //                 MaterialPageRoute(
                                  //                     builder: (context) =>
                                  //                         QRscanner()))
                                  //             .then((value) {
                                  //               setState(() {
                                  //                  context
                                  //                       .read<
                                  //                           putawaycontroller>()
                                  //                       .  iscamera=false;
                                  //               });
                                  //           if (context
                                  //                   .read<putawaycontroller>()
                                  //                   .putawayserialscan !=
                                  //               '') {
                                  //             context
                                  //                 .read<putawaycontroller>()
                                  //                 .scanneddataget(context);
                                  //           }
                                  //         });
                                  //       },
                                  icon: Icon(
                                    Icons.qr_code_outlined,
                                    size: Screens.padingHeight(context) * 0.04,
                                  )),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Screens.padingHeight(context) * 0.01,
                            horizontal: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      child: Text(
                        '${emptylist.itemcode}',
                        style: theme.textTheme.bodyMedium!.copyWith(),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      child: Text(
                        '${emptylist.itemname}',
                        style: theme.textTheme.bodyMedium!.copyWith(),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      children: [
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context) * 0.2,
                          child: Text(
                            "Quantity : ",
                            style: theme.textTheme.bodyMedium!.copyWith(),
                          ),
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.06,
                          width: Screens.width(context) * 0.75,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Quantity",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        Screens.padingHeight(context) * 0.01,
                                    horizontal: 5)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                        child: Row(
                      children: [
                        Container(
                          child: Text("From Bin ",
                              style: theme.textTheme.bodyMedium!.copyWith()),
                        ),
                        Text(": "),
                        Container(
                          child: Text("${emptylist.frombin}",
                              style: theme.textTheme.bodyMedium!.copyWith()),
                        ),
                      ],
                    )),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      children: [
                        Container(
                          width: Screens.width(context) * 0.2,
                          child: Text("To Bin : ",
                              style: theme.textTheme.bodyMedium!.copyWith()),
                        ),
                        Container(
                          width: Screens.width(context) * 0.75,
                          height: Screens.padingHeight(context) * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "To Bin..!!",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: ConstantValues.scanneruser == true
                                  ? Container(
                                      width: Screens.width(context) * 0.01)
                                  : IconButton(
                                      iconSize:
                                          Screens.padingHeight(context) * 0.04,
                                      color: theme.primaryColor,
                                      onPressed: () {},
                                      // context
                                      //                       .watch<
                                      //                           putawaycontroller>()
                                      //                       .  iscamera==true
                                      //     ? () {}
                                      //     : () {
                                      //         setState(() {
                                      //            context
                                      //                       .read<
                                      //                           putawaycontroller>()
                                      //                       .  iscamera=true;
                                      //           QRscannerState.putawayserial = true;
                                      //         });

                                      //         Navigator.push(
                                      //                 context,
                                      //                 MaterialPageRoute(
                                      //                     builder: (context) =>
                                      //                         QRscanner()))
                                      //             .then((value) {
                                      //               setState(() {
                                      //                  context
                                      //                       .read<
                                      //                           putawaycontroller>()
                                      //                       .  iscamera=false;
                                      //               });
                                      //           if (context
                                      //                   .read<putawaycontroller>()
                                      //                   .putawayserialscan !=
                                      //               '') {
                                      //             context
                                      //                 .read<putawaycontroller>()
                                      //                 .scanneddataget(context);
                                      //           }
                                      //         });
                                      //       },
                                      icon: Icon(
                                        Icons.qr_code_outlined,
                                      )),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: Screens.padingHeight(context) * 0.02,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              Container(
                height: Screens.padingHeight(context) * 0.06,
                // width: Screens.width(context),
                child: ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(8),
                    //         bottomRight: Radius.circular(8)))),
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
            ],
          ),
        );
      });
}
