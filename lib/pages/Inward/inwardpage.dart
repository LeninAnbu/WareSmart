import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/inwardController/inwardcontroller.dart';
import 'package:WareSmart/pages/Inward/inwardsevepage.dart';

import 'package:WareSmart/widgets/colorpalate.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';

class inwardpage extends StatefulWidget {
  const inwardpage({super.key});

  @override
  State<inwardpage> createState() => _inwardpageState();
}

class _inwardpageState extends State<inwardpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<inwardcontroller>().init();
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
    final theme = Theme.of(context);
    // return ChangeNotifierProvider<inwardcontroller>(
    //     create: (context) => inwardcontroller(),
    //     builder: (context, child) {
    //       return Consumer<inwardcontroller>(
    //           builder: (BuildContext context, inwardCon, child) {
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(
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
                            Text("Online",
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
                      child: Text("Inward",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText1!.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: Screens.padingHeight(context) * 0.01,
              // ),

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
                      ),
                      child: TextField(
                        cursorColor: theme.primaryColor,
                        controller:
                            context.read<inwardcontroller>().mycontroller[5],
                        autocorrect: false,
                        // style: TextStyles.bodytext2(context),
                        onChanged: (v) {
                          setState(() {
                            context
                                .read<inwardcontroller>()
                                .SearchFilterPending(v);
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            if (context
                                .read<inwardcontroller>()
                                .mycontroller[5]
                                .text
                                .isNotEmpty) {
                              context.read<inwardcontroller>().scannedData =
                                  context
                                      .read<inwardcontroller>()
                                      .mycontroller[5]
                                      .text;
                              context
                                  .read<inwardcontroller>()
                                  .scanneddataget(context);
                            } else {
                              context.read<inwardcontroller>().resetfirst();
                            }
                          });
                        },
                        style: TextStyles.bodytext2(context),
                        decoration: InputDecoration(
                          hintText: 'Search Here!!..',
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
                                  onPressed: QRscannerState.inwardscan == true
                                      ? () {
                                          log("ANNNN");
                                        }
                                      : () {
                                          setState(() {
                                            QRscannerState.inwardscan = true;
                                          });

                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QRscanner()))
                                              .then((value) {
                                            QRscannerState.inwardscan = false;
                                            log(".then");
                                            if (context
                                                    .read<inwardcontroller>()
                                                    .scannedData !=
                                                '') {
                                              context
                                                  .read<inwardcontroller>()
                                                  .scanneddataget(context);
                                            }
                                          });
                                        },
                                  icon: Icon(Icons.qr_code_outlined)),
                          prefixIcon: IconButton(
                            color: theme.primaryColor,
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              FocusScopeNode focus = FocusScope.of(context);
                              if (!focus.hasPrimaryFocus) {
                                focus.unfocus();
                              }
                            }, //
                            // color: PrimaryColor.appColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
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

              Expanded(
                child: context.watch<inwardcontroller>().isloading == false &&
                        context
                            .read<inwardcontroller>()
                            .inwexception!
                            .isEmpty &&
                        context
                            .read<inwardcontroller>()
                            .filterpendinglist
                            .isEmpty
                    ? Center(
                        child: Text("No Data..!!"),
                      )
                    : context.watch<inwardcontroller>().isloading == true &&
                            context
                                .read<inwardcontroller>()
                                .inwexception!
                                .isEmpty &&
                            context
                                .read<inwardcontroller>()
                                .filterpendinglist
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
                        : context.watch<inwardcontroller>().isloading ==
                                    false &&
                                context
                                    .read<inwardcontroller>()
                                    .inwexception!
                                    .isEmpty &&
                                context
                                    .read<inwardcontroller>()
                                    .filterpendinglist
                                    .isNotEmpty
                            ? ListView.builder(
                                itemCount: context
                                    .read<inwardcontroller>()
                                    .filterpendinglist
                                    .length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.padingHeight(context) *
                                                0.002),
                                    // color: Colors.grey[200],
                                    // color:theme.primaryColor.withOpacity(0.05),
                                    child: InkWell(
                                      onTap: () {
                                        // Get.toNamed(ConstantRoutes.inwardsavepage);
                                        // context.read<inwardcontroller>().  clearontap();
                                        context
                                            .read<inwardcontroller>()
                                            .secondpage(context
                                                .read<inwardcontroller>()
                                                .filterpendinglist[i]);
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                        // savelistinward()
                                        // )
                                        // );
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
                                                  Screens.width(context) * 0.02,
                                              vertical: Screens.padingHeight(
                                                      context) *
                                                  0.015),
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor
                                                .withOpacity(0.06),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(
                                            //     color: Colors.black26)
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // width: Screens.width(context)*0.35,
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text("DocNum",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text(
                                                        "#${context.read<inwardcontroller>().filterpendinglist[i].DocNum}",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // width: Screens.width(context)*0.35,
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text("Supplier Code",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text("Supplier Name",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.005,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // width: Screens.width(context)*0.35,
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text(
                                                        "${context.read<inwardcontroller>().filterpendinglist[i].SupplierCode}",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text(
                                                        "${context.read<inwardcontroller>().filterpendinglist[i].SupplierName}",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // width: Screens.width(context)*0.35,
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text("Contact Name",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text("Doc Date",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // width: Screens.width(context)*0.35,
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text(
                                                        "${context.read<inwardcontroller>().filterpendinglist[i].ContactName}",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        // color: colorpalette.customColor2,?
                                                        border: Border(
                                                      top: BorderSide.none,
                                                      left: BorderSide.none,
                                                      right: BorderSide.none,
                                                      bottom: BorderSide.none,
                                                    )),
                                                    child: Text(
                                                        "${context.read<inwardcontroller>().config.alignDate1(context.read<inwardcontroller>().filterpendinglist[i].DocDate.toString())}",
                                                        style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.01,
                                              ),
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  "Created Date : ${context.read<inwardcontroller>().config.alignmeetingdate333(context.read<inwardcontroller>().filterpendinglist[i].CreatedDatetime.toString())}",
                                                  style: theme
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                          color: Colors.grey),
                                                ),
                                              ),
                                              //  Divider(color: Colors.black,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                    "${context.read<inwardcontroller>().inwexception}"),
                              ),
              )
            ],
          ))),
    );
    //   });
    // });
  }
}
