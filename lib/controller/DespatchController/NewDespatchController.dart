import 'dart:developer';

import 'package:WareSmart/Model/DespatchModel/getQRModel.dart';
import 'package:WareSmart/Model/DespatchModel/postreqModel.dart';
import 'package:WareSmart/Services/DesptachApi/GetQRApi.dart';
import 'package:WareSmart/Services/DesptachApi/PostsaveApi.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class NewDespatchController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  init() {
    clearAll();
  }
void showtoastforscanning(String? message) {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  bool qrloading = false;
  String qrerror = '';
  List<DesQRheaderList> DesQRlist = [];
  List<DesQRheaderList> DesQRlistsave = [];
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
// serialloading = false;
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

  addqrdetails(DesQRheaderList DesQRlistsave, BuildContext context) {
    bool isalreadyAdded = false;
    for (int i = 0; i < DesQRlist.length; i++) {
      if (DesQRlist[i].QRCode == DesQRlistsave.QRCode) {
        isalreadyAdded = true;
        notifyListeners();
        break;
      }
    }
    if (isalreadyAdded == true) {
      showdialogtoast(context, "Item already scanned..!!");
      notifyListeners();
    } else {
      if (DesQRlistsave.IsAllocated!.toLowerCase() != 'y') {
        showdialogtoast(context, "Stock not allocated..!!");
        notifyListeners();
      } else if (DesQRlistsave.isInvoiced != 1) {
        showdialogtoast(context,
            "This Item not yet invoice/valid document not created..!!");
        notifyListeners();
      } else if (DesQRlistsave.isDelivered != 1) {
        showdialogtoast(
            context, "Delivery Order not created for this item..!!");
        notifyListeners();
      } else if (DesQRlistsave.isDispatched != 0) {
        showdialogtoast(context, "Dispatched already processed..!!");
        notifyListeners();
      } else {
        DesQRlist.add(DesQRheaderList(
          ItemDisposition:DesQRlistsave.ItemDisposition ,
            Allocated_TimeStamp: DesQRlistsave.Allocated_TimeStamp,
            BinCode: DesQRlistsave.BinCode,
            Brand: DesQRlistsave.Brand,
            Category: DesQRlistsave.Category,
            CustomerCode: DesQRlistsave.CustomerCode,
            CustomerMobile: DesQRlistsave.CustomerMobile,
            CustomerName: DesQRlistsave.CustomerName,
            Del_Address1: DesQRlistsave.Del_Address1,
            Del_Address2: DesQRlistsave.Del_Address2,
            Del_Address3: DesQRlistsave.Del_Address3,
            Del_Area: DesQRlistsave.Del_Area,
            Del_City: DesQRlistsave.Del_City,
            Del_Country: DesQRlistsave.Del_Country,
            Del_District: DesQRlistsave.Del_District,
            Del_State: DesQRlistsave.Del_State,
            DeliveryDate: DesQRlistsave.DeliveryDate,
            DeliveryDueDate: DesQRlistsave.DeliveryDueDate,
            DeliveryNo: DesQRlistsave.DeliveryNo,
            DeliveryReturnReason: DesQRlistsave.DeliveryReturnReason,
            DeliveryReturnedDateTime: DesQRlistsave.DeliveryReturnedDateTime,
            DeliveryURL1: DesQRlistsave.DeliveryURL1,
            Delivery_Pic1: DesQRlistsave.Delivery_Pic1,
            Delivery_To: DesQRlistsave.Delivery_To,
            DispatchNo: DesQRlistsave.DispatchNo,
            DispatchedDateTime: DesQRlistsave.DispatchedDateTime,
            DocDate: DesQRlistsave.DocDate,
            DocEntry: DesQRlistsave.DocEntry,
            DocNumber: DesQRlistsave.DocNumber,
            DriverName: DesQRlistsave.DriverName,
            InvoiceDate: DesQRlistsave.InvoiceDate,
            InvoiceNo: DesQRlistsave.InvoiceNo,
            InvoiceTotal: DesQRlistsave.InvoiceTotal,
            InvoiceURL1: DesQRlistsave.InvoiceURL1,
            IsAllocated: DesQRlistsave.IsAllocated,
            IsDeliveryReturned: DesQRlistsave.IsDeliveryReturned,
            IsPickSlipGenerated: DesQRlistsave.IsPickSlipGenerated,
            IsReserved: DesQRlistsave.IsReserved,
            ItemCode: DesQRlistsave.ItemCode,
            ItemName: DesQRlistsave.ItemName,
            OrderNum: DesQRlistsave.OrderNum,
            OrderStatus: DesQRlistsave.OrderStatus,
            Pref_BatchSerial: DesQRlistsave.Pref_BatchSerial,
            QRCode: DesQRlistsave.QRCode,
            SerialBatch: DesQRlistsave.SerialBatch,
            StoreCode: DesQRlistsave.StoreCode,
            SubCategory: DesQRlistsave.SubCategory,
            Total_Line_Order_Qty: DesQRlistsave.Total_Line_Order_Qty,
            VehicleNo: DesQRlistsave.VehicleNo,
            WhsCode: DesQRlistsave.WhsCode,
            isDelivered: DesQRlistsave.isDelivered,
            isDispatched: DesQRlistsave.isDispatched,
            isInvoiced: DesQRlistsave.isInvoiced));
        notifyListeners();
        log("aaaa::" + DesQRlist.length.toString());
      }
      
    }
    qrloading = false;
    notifyListeners();
  }
clearpopup(){
  mycontroller[0].clear();
  mycontroller[1].clear();
  mycontroller[2].clear();
  finalloading=false;
  notifyListeners();
}
  callQRAPi(String code, BuildContext context) async {
    // DesQRlist.clear();
    qrloading = true;
    qrerror = '';
    notifyListeners();
    await GetDespatchQRApi.getdata(code).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.desQRheader!.itemlist != null &&
            value.desQRheader!.itemlist!.isNotEmpty) {
          DesQRlistsave = value.desQRheader!.itemlist!;
          addqrdetails(DesQRlistsave[0], context);
          // DesQRlist.addAll(DesQRlistsave);
          mycontroller[5].clear();
          // filterpendinglist = pendinglist;
          // isloading = false;
          // mapvalues(value.inwardDetailheader!.itemlist!);
          qrerror = '';
          // FocusScope.of(context).unfocus();

          log("pendinglist::" + DesQRlist.length.toString());
          notifyListeners();
        } else if (value.desQRheader!.itemlist == null ||
            value.desQRheader!.itemlist!.isEmpty) {
          qrloading = false;
          qrerror = "No data Found..!!";
          showtoastforscanning(qrerror);
          mycontroller[5].clear();
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        qrloading = false;
        qrerror = "${value.message}..${value.exception}..!!";
        showdialogtoast(context, qrerror);
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          qrloading = false;
          qrerror = "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
           showdialogtoast(context, qrerror);
          notifyListeners();
        } else {
          qrloading = false;
          qrerror = "${value.stcode}..${value.exception}..!!";
           showdialogtoast(context, qrerror);
          notifyListeners();
        }
      }
    });
  }

  List<postdesptachreq> postreqmodel = [];
  List<Desplines> finaldesplines = [];
  bool finalloading = false;
  validatefinal(BuildContext context) async {
     finalloading = true;
      notifyListeners();
    if (formkey[0].currentState!.validate()) {
      finaldesplines.clear();
      postreqmodel.clear();
      for(int i=0;i<DesQRlist.length;i++){
         List<Desplines>? desplines = [];
      // desplines.add(Desplines(
      //   qrcode: DesQRlist[i].QRCode)
      //   );
 finaldesplines.add(Desplines(
        qrcode: DesQRlist[i].QRCode)
        );
 log("finaldesplines::"+finaldesplines.length.toString());
      }
      postreqmodel.add(postdesptachreq(
          desplines: finaldesplines,
          docdate: Config.currentDate(),
          drivercontact: mycontroller[1].text,
          drivername: mycontroller[0].text,
          routecode: null,
          vehno: mycontroller[2].text,
          whscode: ConstantValues.Whsecode));
      // List<Desplines>? desplines = [];
      // desplines.add(Desplines(qrcode: mycontroller[5].text));
     
      await postDesSaveApi.getData(postreqmodel).then((value) async {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          finalloading = false;
          notifyListeners();
          final audio = AudioPlayer();

          await audio.setAsset("Asset/next_click.mp3");
          audio.play();

          showdialogsave(context, "Asset/check.png", "Success",
              value.exception.toString());

          notifyListeners();
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          finalloading = false;
          notifyListeners();
          final audio = AudioPlayer();
          await audio.setAsset("Asset/Invalid_bin.mp3");
          audio.play();
          // disableKeyBoard(context);
          showdialogsave(context, "Asset/cancel.png", "Failed",
              "${value.message}..${value.exception.toString()}");
          notifyListeners();
        } else {
          if (value.exception!.contains("Network is unreachable")) {
            finalloading = false;
            final audio = AudioPlayer();
            await audio.stop();
            await audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
            //  disableKeyBoard(context);
            showdialogsave(context, "Asset/cancel.png", "Failed",
                "Network Issue..Try again Later..!!");

            notifyListeners();
          } else {
            finalloading = false;
            final audio = AudioPlayer();
            await audio.stop();
            await audio.setAsset("Asset/Invalid_bin.mp3");
            audio.play();
            // disableKeyBoard(context);
            showdialogsave(context, "Asset/cancel.png", "Failed",
                "${value.stcode}..${value.exception}..!!");

            notifyListeners();
          }
        }
      });
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

  detailsentrybottom(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // useRootNavigator :true,
        // showDragHandle:true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (context) {
          return StatefulBuilder(builder: (context, setst) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.only(
                    top: Screens.padingHeight(context) * 0.02,
                    right: Screens.width(context) * 0.02,
                    left: Screens.width(context) * 0.02,
                    bottom: Screens.padingHeight(context) * 0.01),
                child: Form(
                  key: formkey[0],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: theme.primaryColor),
                        )),
                        child: Text(
                          "Vehicle Details",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.03,
                      ),
                      SizedBox(
                        // height: Screens.padingHeight(context)*0.06,
                        child: TextFormField(
                          controller: mycontroller[0],
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "*Required Field";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Driver Name",
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: theme.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: theme.primaryColor, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical:
                                      Screens.padingHeight(context) * 0.01)),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      SizedBox(
                        // height: Screens.padingHeight(context)*0.06,
                        child: TextFormField(
                          controller: mycontroller[1],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "*Required Field";
                            }
                          },
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                             FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                              labelText: "Contact Number",
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: theme.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: theme.primaryColor, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical:
                                      Screens.padingHeight(context) * 0.01)),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      Container(
                        // height: Screens.padingHeight(context)*0.06,
                        child: TextFormField(
                          controller: mycontroller[2],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "*Required Field";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Vehicle No",
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: theme.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: theme.primaryColor, width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.03,
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.3,
                        height: Screens.padingHeight(context) * 0.05,
                        child: ElevatedButton(
                          onPressed:finalloading == true?(){}: () {
                            setst(() {
                              validatefinal(context);
                            });
                          },
                          child: finalloading == true
                              ? SpinKitThreeBounce(
                                  size: Screens.width(context) * 0.03,
                                  color: Colors.white,
                                )
                              : Text("Save"),
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

  String scannedData = '';
  clearAll() {
    finalloading = false;
    postreqmodel.clear();
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[5].clear();
    scannedData = '';
    DesQRlist.clear();
    qrloading = false;
    qrerror = '';
    notifyListeners();
  }
}
