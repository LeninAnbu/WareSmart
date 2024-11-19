

import 'dart:developer';

import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/putawayController/putawaycontroller.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Putawaypage extends StatefulWidget {
  const Putawaypage({super.key});

  @override
  State<Putawaypage> createState() => _PutawaypageState();
}

class _PutawaypageState extends State<Putawaypage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<putawaycontroller>().init();
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final finaldbdata =
        context.watch<putawaycontroller>().filterputawaylist.toList();
        finaldbdata.sort((a,b)=> b.isdone==true?1:0.compareTo(a.isdone==true?1:0));
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.01,
                    vertical: Screens.width(context) * 0.02),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  // border: Border(
                  //     bottom:
                  //         BorderSide(color: Colors.white,)
                  //         )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "User     : ${ConstantValues.Usercode} / ${ConstantValues.Whsecode}",
                            style: theme.textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            )),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                
                               context
                                .read<putawaycontroller>()
                                .   deleteall();
                              },
                              child: Text("Online",
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.02,
                            ),
                            Container(
                              width: Screens.width(context) * 0.04,
                              height: Screens.padingHeight(context) * 0.04,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                            ),
                          ],
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: Screens.padingHeight(context) * 0.01,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Device : ${ConstantValues.constantdevicecode}",
                            style: theme.textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            )),
                        Row(
                          children: [
                            Text("Scanner ",
                                style: theme.textTheme.bodyText1!.copyWith(
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: Screens.width(context) * 0.02,
                            ),
                            Container(
                              width: Screens.width(context) * 0.04,
                              height: Screens.padingHeight(context) * 0.04,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.01,
                          vertical: Screens.width(context) * 0.01),
                      decoration: BoxDecoration(
                          // color: theme.primaryColor,
                          // border: Border(
                          //     bottom:
                          //         BorderSide(color: Colors.grey, width: 2.0))
                          ),
                      child: Text("Putaway",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText1!.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.03,
                    right: Screens.width(context) * 0.03,
                    top: Screens.padingHeight(context) * 0.01),
                child: Column(
                  children: [
                    Container(
                      height: Screens.padingHeight(context) * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black26)),
                      child: TextField(
                        cursorColor: theme.primaryColor,
                        controller:
                            context.read<putawaycontroller>().mycontroller[0],
                        autocorrect: false,
                        focusNode: context.read<putawaycontroller>().focus1,
                        onChanged: (v) {
                          setState(() {
                            context
                                .read<putawaycontroller>()
                                .SearchFilterPending(v);
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            if (context
                                .read<putawaycontroller>()
                                .mycontroller[0]
                                .text
                                .isNotEmpty) {
                              context
                                      .read<putawaycontroller>()
                                      .putawayserialscan =
                                  context
                                      .read<putawaycontroller>()
                                      .mycontroller[0]
                                      .text;
                              context
                                  .read<putawaycontroller>()
                                  .scanneddataget(context);
                            } else {
                              context.read<putawaycontroller>().resetfirst();
                            }
                          });
                        },
                        style: TextStyles.bodytext2(context),
                        
                        decoration: InputDecoration(
                          // contentPadding:EdgeInsets.all(0),
                          hintText: 'Scan Barcode..',
                          // AppLocalizations.of(context)!
                          //     .search_sales_quot,

                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          
                          suffixIcon: ConstantValues.scanneruser == true
                              ? Container(width: Screens.width(context) * 0.01)
                              : IconButton(
                                  iconSize:
                                      Screens.padingHeight(context) * 0.04,
                                  color: theme.primaryColor,
                                  onPressed:context
                                                        .watch<
                                                            putawaycontroller>()
                                                        .  iscamera==true
                                      ? () {}
                                      : () {
                                          setState(() {
                                             context
                                                        .read<
                                                            putawaycontroller>()
                                                        .  iscamera=true;
                                            QRscannerState.putawayserial = true;
                                          });

                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QRscanner()))
                                              .then((value) {
                                                setState(() {
                                                   context
                                                        .read<
                                                            putawaycontroller>()
                                                        .  iscamera=false;
                                                });
                                            if (context
                                                    .read<putawaycontroller>()
                                                    .putawayserialscan !=
                                                '') {
                                              context
                                                  .read<putawaycontroller>()
                                                  .scanneddataget(context);
                                            }
                                          });
                                        },
                                  icon: Icon(Icons.qr_code_outlined,)),

                          contentPadding:  EdgeInsets.symmetric(
                            vertical: Screens.padingHeight(context)*0.01,
                            horizontal: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.005,
                    ),
                  ],
                ),
              ),

              //Bin
              context.watch<putawaycontroller>().selectedputawaylist.isEmpty
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: Screens.width(context) * 0.03,
                          right: Screens.width(context) * 0.03,
                          top: Screens.padingHeight(context) * 0.005),
                      child: Column(
                        children: [
                          Container(
                            height: Screens.padingHeight(context) * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black26)),
                            child: TextFormField(
                              cursorColor: theme.primaryColor,
                              controller: context
                                  .read<putawaycontroller>()
                                  .mycontroller[1],
                              autocorrect: false,
                              focusNode:
                                  context.read<putawaycontroller>().focus2,
                              onChanged: (v) {
                                setState(() {
                                  //  context.read<putawaycontroller>().SearchFilterPending(v);
                                });
                              },
                              onEditingComplete: () {
                                if (context
                                        .read<putawaycontroller>()
                                        .selectedputawaylist[0]
                                        .ManageBy!
                                        .toLowerCase() ==
                                    "s") {
                                  setState(() {
                                    if (context
                                        .read<putawaycontroller>()
                                        .mycontroller[1]
                                        .text
                                        .isNotEmpty) {
                                      context
                                              .read<putawaycontroller>()
                                              .putawaybinscan =
                                          context
                                              .read<putawaycontroller>()
                                              .mycontroller[1]
                                              .text;
                                      context
                                          .read<putawaycontroller>()
                                          .afterBinScanned(
                                              context
                                                  .read<putawaycontroller>()
                                                  .putawaybinscan,
                                              context);
                                    }
                                  });
                                } else {
                                  setState(() {
                                    context
                                        .read<putawaycontroller>()
                                        .mangedbyBatch(context
                                            .read<putawaycontroller>()
                                            .mycontroller[1]
                                            .text);
                                  });
                                }
                              },
                              style: TextStyles.bodytext2(context),
                              decoration: InputDecoration(
                                hintText: 'Bin Code!!..',
                                // AppLocalizations.of(context)!
                                //     .search_sales_quot,

                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: ConstantValues.scanneruser == true
                                    ? Container(
                                        width: Screens.width(context) * 0.01)
                                    : IconButton(
                                        iconSize:
                                            Screens.padingHeight(context) *
                                                0.04,
                                        color: theme.primaryColor,
                                        onPressed:  context
                                                        .watch<
                                                            putawaycontroller>()
                                                        .  iscamera2==true
                                            ? () {}
                                            : () {
                                              setState(() {
                                                  
                                                });
                                                setState(() {
                                                   context
                                                        .read<
                                                            putawaycontroller>()
                                                        .  iscamera2=true;
                                                  QRscannerState.putawayBin =
                                                      true;
                                                });

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRscanner())).then(
                                                    (value) {
                                                      setState(() {
                                                   context
                                                        .read<
                                                            putawaycontroller>()
                                                        .  iscamera2=false;
                                                });
                                                  if (context
                                                          .read<
                                                              putawaycontroller>()
                                                          .putawaybinscan !=
                                                      '') {
                                                    if (context
                                                            .read<
                                                                putawaycontroller>()
                                                            .selectedputawaylist[
                                                                0]
                                                            .ManageBy!
                                                            .toLowerCase() ==
                                                        "s") {
                                                          
                                                      context
                                                          .read<
                                                              putawaycontroller>()
                                                          .afterBinScanned(
                                                              context
                                                                  .read<
                                                                      putawaycontroller>()
                                                                  .putawaybinscan,
                                                              context);
                                                    } else {
                                                      context
                                                          .read<
                                                              putawaycontroller>()
                                                          .mangedbyBatch(context
                                                              .read<
                                                                  putawaycontroller>()
                                                              .putawaybinscan);
                                                    }
                                                  }
                                                });
                                              },
                                        icon: Icon(Icons.qr_code_outlined)),
                                // prefixIcon: IconButton(
                                //   color: theme.primaryColor,
                                //   icon: const Icon(Icons.search),
                                //   onPressed: () {
                                //     FocusScopeNode focus = FocusScope.of(context);
                                //     if (!focus.hasPrimaryFocus) {
                                //       focus.unfocus();
                                //     }
                                //   }, //
                                //   // color: PrimaryColor.appColor,
                                // ),
                                contentPadding:  EdgeInsets.symmetric(
                                  vertical: Screens.padingHeight(context)*0.005,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.005,
                          ),
                        ],
                      ),
                    ),
              context
                          .watch<putawaycontroller>()
                          .selectedputawaylist
                          .isNotEmpty &&
                      context
                              .watch<putawaycontroller>()
                              .selectedputawaylist[0]
                              .ManageBy!
                              .toLowerCase() !=
                          's'
                  ? Container(
                      padding: EdgeInsets.only(
                          left: Screens.width(context) * 0.03,
                          right: Screens.width(context) * 0.03,
                          top: Screens.padingHeight(context) * 0.005),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.78,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: TextFormField(
                                    controller: context
                                        .read<putawaycontroller>()
                                        .mycontroller[2],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],

                                    // readOnly: context
                                    //             .read<
                                    //                 putawaycontroller>()
                                    //             .inwItemList2!
                                    //             .ManageBy!
                                    //             .toLowerCase() ==
                                    //         "s"
                                    //     ? true
                                    //     : false,
                                    decoration: InputDecoration(
                                      hintText: 'Quantity',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              Screens.padingHeight(context) *
                                                  0.01,
                                          horizontal:
                                              Screens.width(context) * 0.01),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.005,
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: IconButton(
                                  // onPressed: () {},
                                  onPressed: context
                                              .read<putawaycontroller>()
                                              .selectedputawaylist[0]!
                                              .ManageBy!
                                              .toLowerCase() ==
                                          "s"
                                      ? () {}
                                      : () {
                                          if (context
                                                  .read<putawaycontroller>()
                                                  .mycontroller[2]
                                                  .text
                                                  .isNotEmpty &&
                                              int.parse(context
                                                      .read<putawaycontroller>()
                                                      .mycontroller[2]
                                                      .text) >
                                                  0) {
                                            setState(() {
                                              context
                                                  .read<putawaycontroller>()
                                                  .afterBinScanned(
                                                      context
                                                          .read<
                                                              putawaycontroller>()
                                                          .mycontroller[1]
                                                          .text,
                                                      context);
                                              FocusScope.of(context).unfocus();
                                            });
                                          } else {
                                            if (int.parse(context
                                                    .read<putawaycontroller>()
                                                    .mycontroller[2]
                                                    .text) <=
                                                0) {
                                              const snackBar = SnackBar(
                                                  duration:
                                                      Duration(seconds: 4),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Value 0 not accepted..!!",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              const snackBar = SnackBar(
                                                  duration:
                                                      Duration(seconds: 4),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Enter Quantity..!!",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        },
                                  icon: Icon(
                                    Icons.double_arrow,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
               context
                        .watch<putawaycontroller>()
                        .selectedputawaylist
                        .isNotEmpty?    Container(
                    padding: EdgeInsets.only(
                      right: Screens.width(context)*0.03
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                             context
                                                    .read<putawaycontroller>()
                                                    .    init();
                                    //  context
                                    //                 .read<putawaycontroller>()
                                    //                 .   resetfirst(); 
                            });
                        
                          },
                          child: Container(
                          //  width: Screens.width(context)*0.15,
                            // alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              //  color: Colors.amber,
                              border:Border(
                                bottom: BorderSide(color: theme.primaryColor)
                              ) 
                            ),
                            child: Text("Back",style: theme.textTheme.bodyText1!.copyWith(fontSize: 15,fontWeight: FontWeight.normal,color: theme.primaryColor),),
                          ),
                        ),
                      ],
                    ),
                  ):Container(),

              Expanded(
                child: context
                        .watch<putawaycontroller>()
                        .selectedputawaylist
                        .isNotEmpty
                    ? ListView.builder(
                        itemCount: context
                            .read<putawaycontroller>()
                            .selectedputawaylist
                            .length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical:
                                    Screens.padingHeight(context) * 0.002),
                            decoration: BoxDecoration(
                                // color:  Colors.green[100]
                                ),
                            child: Card(
                              elevation: 2,
                              // shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Screens.width(context) * 0.02,
                                    vertical:
                                        Screens.padingHeight(context) * 0.015),
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(5),
                                  // border: Border.all(
                                  //     color: Colors.black26)
                                ),
                                child: Column(
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Container(
                                    //       child: Text("Scan Barocde..!!",
                                    //           style: theme.textTheme.bodyText1!
                                    //               .copyWith(
                                    //                   color: Colors.grey,
                                    //                   fontWeight:
                                    //                       FontWeight.normal)),
                                    //     ),
                                    //     Container(
                                    //       child: Text(
                                    //         "Inward Type",
                                    //         style: theme.textTheme.bodyText1!
                                    //             .copyWith(
                                    //                 color: Colors.grey,
                                    //                 fontWeight:
                                    //                     FontWeight.normal),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height:
                                    //       Screens.padingHeight(context) * 0.005,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Container(
                                                         width: Screens.width(context)*0.7,
                                                        child: Text(
                                                            "Barcode #${context.read<putawaycontroller>().selectedputawaylist[i].SerialBatchCode}"),
                                                      ),
                                       
                                        Container(
                                          child: Text(
                                              "${context.read<putawaycontroller>().selectedputawaylist[i].InwardType}"),
                                        ),
                                      ],
                                    ),
                                   SizedBox(
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: Screens.width(context)*0.8,
                                                        child: Text(
                                                            "${context.read<putawaycontroller>().selectedputawaylist[i].ItemCode}"),
                                                      ),
                                                      Container(
                                                        child: context
                                                                    .watch<
                                                                        putawaycontroller>()
                                                                    .selectedputawaylist[
                                                                        i]
                                                                    .isdone ==
                                                                true
                                                            ? Icon(
                                                                Icons
                                                                    .check_circle,
                                                                size: 30,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Text(""),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                         width: Screens.width(context)*0.7,
                                                        child: Text(
                                                            "Quantity #${context.read<putawaycontroller>().selectedputawaylist[i].SerialBatchQty!.toStringAsFixed(0)}"),
                                                      ),
                                                      Container(
                                                        child:context.watch<putawaycontroller>().selectedputawaylist[i].localbincode!.isEmpty?Text(""): Text(
                                                            "Bin : ${context.read<putawaycontroller>().selectedputawaylist[i].localbincode}"),
                                                      ),
                                                    ],
                                                  ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : context.watch<putawaycontroller>().isloading == false &&
                            context
                                .read<putawaycontroller>()
                                .putexception!
                                .isEmpty &&
                            finaldbdata
                                .isEmpty
                        ? Center(
                            child: Text("No Data..!!"),
                          )
                        : context.watch<putawaycontroller>().isloading ==
                                    true &&
                                context
                                    .read<putawaycontroller>()
                                    .putexception!
                                    .isEmpty &&
                                finaldbdata
                                    .isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SpinKitThreeBounce(
                                      size: Screens.width(context) * 0.1,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            : context.watch<putawaycontroller>().isloading ==
                                        false &&
                                    context
                                        .read<putawaycontroller>()
                                        .putexception!
                                        .isEmpty &&
                                    finaldbdata
                                        .isNotEmpty
                                ? ListView.builder(
                                    itemCount: finaldbdata
                                        .length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Screens.width(context) * 0.02,
                                            vertical:
                                                Screens.padingHeight(context) *
                                                    0.002),
                                        child: InkWell(
                                          onTap: () {
                                            log("finaldbdata[i].SerialBatchQty::"+finaldbdata[i].isdone.toString());
                                            context
                                                .read<putawaycontroller>()
                                                .  checkquantity =null;
                                                context
                                                .read<putawaycontroller>()
                                                .  checkquantity =finaldbdata[i].SerialBatchQty;
                                          context
                                                .read<putawaycontroller>()
                                                .  putawayserialscan ='';
                                                context
                                                .read<putawaycontroller>()
                                                .  putawayserialscan =finaldbdata[i].SerialBatchCode.toString();

                                            context
                                                .read<putawaycontroller>()
                                                .scanneddataget(context);
                                                // addselectedlist(context
                                                //     .read<putawaycontroller>()
                                                //     .filterputawaylist[i]);
                                          },
                                          child: Card(
                                            elevation: 2,
                                            // shadowColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Screens.width(context) *
                                                          0.02,
                                                  vertical:
                                                      Screens.padingHeight(
                                                              context) *
                                                          0.015),
                                              decoration: BoxDecoration(
                                                color: finaldbdata[
                                                                i]
                                                            .isdone ==
                                                        true
                                                    ? Colors.green[50]
                                                    : Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // border: Border.all(
                                                //     color: Colors.black26)
                                              ),
                                              child: Column(
                                                children: [
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     Container(
                                                  //       child: Text(
                                                  //           "Serial Number",
                                                  //           style: theme
                                                  //               .textTheme
                                                  //               .bodyText1!
                                                  //               .copyWith(
                                                  //                   color: Colors
                                                  //                       .grey,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .normal)),
                                                  //     ),
                                                  //     Container(
                                                  //       child: Text(
                                                  //         "Inward Type",
                                                  //         style: theme.textTheme
                                                  //             .bodyText1!
                                                  //             .copyWith(
                                                  //                 color: Colors
                                                  //                     .grey,
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .normal),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // SizedBox(
                                                  //   height:
                                                  //       Screens.padingHeight(
                                                  //               context) *
                                                  //           0.005,
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                         width: Screens.width(context)*0.7,
                                                        child: Text(
                                                            "Barcode #${finaldbdata[i].SerialBatchCode}"),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            "${finaldbdata[i].InwardType}"),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: Screens.width(context)*0.8,
                                                        child: Text(
                                                            "${finaldbdata[i].ItemCode}"),
                                                      ),
                                                      Container(
                                                        child: finaldbdata[
                                                                        i]
                                                                    .isdone ==
                                                                true
                                                            ? Icon(
                                                                Icons
                                                                    .check_circle,
                                                                size: 30,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Text(""),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                         width: Screens.width(context)*0.7,
                                                        child: Text(
                                                            "Quantity #${finaldbdata[i].SerialBatchQty!.toStringAsFixed(0)}"),
                                                      ),
                                                      Container(
                                                        child:finaldbdata[i].localbincode!.isEmpty||finaldbdata[i].localbincode! ==null?Text(""): Text(
                                                            "Bin : ${finaldbdata[i].localbincode}"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text(
                                        "${context.read<putawaycontroller>().putexception}"),
                                  ),
              ),

              context
                        .watch<putawaycontroller>()
                        .selectedputawaylist
                        .isNotEmpty
                    ?Container(): Container(
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.02,
                    right: Screens.width(context) * 0.02,
                    top: Screens.padingHeight(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.02),
                child: Center(
                  child: Container(
                    height: Screens.padingHeight(context) * 0.06,
                    width: Screens.width(context),
                    //color: Colors.red,
                    // margin: const EdgeInsets.all(20),
                    //   child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: context
                                                        .watch<
                                                            putawaycontroller>()
                                                        .finallodaing ==
                                                    true
                                                ? null
                                                : () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            context
                                .read<putawaycontroller>()
                                .savefinal(context);
                          });
                        },
                        child:context
                                                        .watch<
                                                            putawaycontroller>()
                                                        .finallodaing ==
                                                    true
                                                ?SpinKitThreeBounce(
                                                size: Screens.width(context) *
                                                    0.05,
                                                color: Colors.white,
                                              ) : Text('Save', style: TextStyles.btnText(context))
                        // : SpinKitThreeBounce(
                        //     size: width * 0.05,
                        //     color: Colors.white,
                        //   ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
