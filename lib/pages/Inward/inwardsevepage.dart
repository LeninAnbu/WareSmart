import 'dart:developer';

import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:WareSmart/Model/InwardModel/GetPendingModel.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/inwardController/inwardcontroller.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';

class savelistinward extends StatefulWidget {
  savelistinward({super.key});
  // inwardcontroller? inwardCon;
// dummylist?

  @override
  State<savelistinward> createState() => savelistinwardState();
}

class savelistinwardState extends State<savelistinward> {
  static InwPendingDetailList? pendinglist;

  FocusNode focus = FocusNode();
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      if (context.read<inwardcontroller>().pageChanged == 1) {
        // getQty.clear();
        // getItemsQty();
        // getAllQuantity();
        // if(context.read<inwardcontroller>().isPressed==false){
        context.read<inwardcontroller>().showdialogback(context);
        // return Future.value(false);
        //       }

        // context.read<inwardcontroller>().pageController.animateToPage(
        //     --context.read<inwardcontroller>().pageChanged,
        //     duration: Duration(milliseconds: 250),
        //     curve: Curves.bounceIn);
        // data.clear();
        // mycontroller[0].text = '';
        // mycontroller[1].clear();
        // serialScannedData = '';
        return Future.value(false);
      } else if (context.read<inwardcontroller>().pageChanged == 0) {
        Get.offAllNamed(ConstantRoutes.inwardpage);
        return Future.value(true);
      }
    }
    return Future.value(true);
  }

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log("pendinglist::" + pendinglist!.DocEntry.toString());
      context.read<inwardcontroller>().clearontap();
      context.read<inwardcontroller>().callgetdocentry(pendinglist!.DocEntry!);
    });
  }

// @override
// void dispose(){
//  context
//                                   .read<inwardcontroller>()
//                                   . audio.dispose();
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    final finaldbdata =
        context.watch<inwardcontroller>().dbdata.reversed.toList();
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: context.read<inwardcontroller>().pageController,
            onPageChanged: (index) {
              setState(() {
                context.read<inwardcontroller>().pageChanged = index;
              });
              print(context.read<inwardcontroller>().pageChanged);
            },
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context),
                // color: Colors.red,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: Screens.width(context) * 0.04,
                        right: Screens.width(context) * 0.04,
                        top: Screens.padingHeight(context) * 0.04,
                        bottom: Screens.padingHeight(context) * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: context.watch<inwardcontroller>().isloading2 == true
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
                        : context.watch<inwardcontroller>().isloading2 ==
                                    false &&
                                context
                                    .watch<inwardcontroller>()
                                    .inwexception2!
                                    .isNotEmpty &&
                                context
                                    .read<inwardcontroller>()
                                    .inwItemList
                                    .isEmpty
                            ? Center(
                                child: Text(
                                    "${context.read<inwardcontroller>().inwexception2}"),
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height:
                                        Screens.padingHeight(context) * 0.06,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                      controller: context
                                          .watch<inwardcontroller>()
                                          .mycontroller[6],
                                      style: TextStyles.bodytext2(context),
                                      onChanged: (v) {
                                        setState(() {
                                          context
                                              .read<inwardcontroller>()
                                              .SearchFilterInwlist(v);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search Here!!..',
                                        // AppLocalizations.of(context)!
                                        //     .search_sales_quot,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        prefixIcon: IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {
                                            FocusScopeNode focus =
                                                FocusScope.of(context);
                                            if (!focus.hasPrimaryFocus) {
                                              focus.unfocus();
                                            }
                                          }, //
                                          color: theme.primaryColor,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  context
                                          .read<inwardcontroller>()
                                          .inwdocDetail
                                          .isEmpty
                                      ? Container()
                                      : Container(
                                          //  height: Screens.heigt(context)*0.15,
                                          width: Screens.width(context),
                                          // color: Colors.red,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Screens.width(context),
                                                // height: Screens.heigt(context)*0.07,
                                                //   color: Colors.red,
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                  onTap: (){
                                                      setState(() {
                                      context.read<inwardcontroller>().   copyDatabaseToExternalStorage(context);
                                     
                                      });
                                                  },
                                                  child: Text(
                                                    "Doc No:${context.read<inwardcontroller>().inwdocDetail[0].DocNum}",
                                                    //  ${grpDetails[0].NumAtCard}",
                                                    style: TextStyles.headline(
                                                        context),
                                                  ),
                                                ),
                                              ),
                                              context
                                                      .read<inwardcontroller>()
                                                      .inwdocDetail
                                                      .isEmpty
                                                  ? Container()
                                                  : Container(
                                                      width: Screens.width(
                                                          context),
                                                      //  height: Screens.heigt(context)*0.07,
                                                      //  color: Colors.green,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Vendor: ${context.read<inwardcontroller>().inwdocDetail[0].SupplierCode} - ${context.read<inwardcontroller>().inwdocDetail[0].SupplierName}",
                                                        // ${grpDetails[0].CardCode} - ${grpDetails[0].CardName}",
                                                        style:
                                                            TextStyles.headline(
                                                                context),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                  Expanded(
                                      child:
                                          context
                                                  .read<inwardcontroller>()
                                                  .inwItemList
                                                  .isEmpty
                                              ? Container(
                                                  child: Center(child: Text("No data..!!")))
                                              : ListView.builder(
                                                  itemCount: context
                                                      .read<inwardcontroller>()
                                                      .inwItemList
                                                      .length,
                                                  itemBuilder: (c, i) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          top: Screens.width(
                                                                  context) *
                                                              0.01,
                                                          bottom: Screens.width(
                                                                  context) *
                                                              0.01),
                                                      child: Card(
                                                        elevation: 2,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        child: InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .index = i;
                                                            // print("itemcode: " +
                                                            //     grpDetailsFilter[i]
                                                            //         .ItemCode);
                                                            // print("docentry: " +
                                                            //     grpDetailsFilter[i]
                                                            //         .DocEntry
                                                            //         .toString());
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .dataget(
                                                                    context);

                                                            // mycontroller[0].text = '';
                                                            // mycontroller[1].clear();
                                                            // serialScannedData = '';
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .inwItemList2 = null;
                                                            context
                                                                    .read<
                                                                        inwardcontroller>()
                                                                    .inwItemList2 =
                                                                context
                                                                    .read<
                                                                        inwardcontroller>()
                                                                    .inwItemList[i];
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .clearbinfield();
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .mycontroller[2]
                                                                .text = '1';
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .pageController
                                                                .animateToPage(
                                                                    ++context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .pageChanged,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            250),
                                                                    curve: Curves
                                                                        .bounceIn);
                                                          },
                                                          child: Container(
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            padding: EdgeInsets.only(
                                                                left: Screens.width(
                                                                        context) *
                                                                    0.02,
                                                                right: Screens.width(
                                                                        context) *
                                                                    0.02,
                                                                top: Screens.padingHeight(
                                                                        context) *
                                                                    0.02,
                                                                bottom: Screens
                                                                        .padingHeight(
                                                                            context) *
                                                                    0.02),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: theme
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            0.06),
                                                                    // color: Colors.grey[200],
                                                                    // border: Border.all(
                                                                    //     // color:
                                                                    //     //     Colors.black26
                                                                    //         ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.6,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                          width: Screens.width(context) *
                                                                              0.6,
                                                                          //    color: Colors.red,
                                                                          child:
                                                                              Text(
                                                                            "${context.read<inwardcontroller>().inwItemList[i].ItemCode}",
                                                                            // "${grpDetailsFilter[i].ItemCode}",
                                                                            style:
                                                                                TextStyles.bodytext3(context),
                                                                          )),
                                                                      SizedBox(
                                                                        height: Screens.padingHeight(context) *
                                                                            0.005,
                                                                      ),
                                                                      Container(
                                                                          width: Screens.width(context) *
                                                                              0.6,
                                                                          //    color: Colors.red,
                                                                          child:
                                                                              Text(
                                                                            "${context.read<inwardcontroller>().inwItemList[i].ItemName}",
                                                                            // "${grpDetailsFilter[i].Dscription}",
                                                                            style:
                                                                                TextStyles.bodytext3(context),
                                                                          )),
                                                                      SizedBox(
                                                                        height: Screens.padingHeight(context) *
                                                                            0.005,
                                                                      ),
                                                                      Container(
                                                                          width: Screens.width(context) *
                                                                              0.6,
                                                                          //  color: Colors.red,
                                                                          child:
                                                                              Text(
                                                                            "Quantity: ${context.read<inwardcontroller>().inwItemList[i].Unit_Quantity!.toStringAsFixed(0)}/${context.read<inwardcontroller>().getqty.length == 0 || context.read<inwardcontroller>().getqty.isEmpty ? '0' : context.read<inwardcontroller>().getqty[i]}",
                                                                            // ${grpDetailsFilter[i].Quantity.toStringAsFixed(0)}/${getQty[i]}",
                                                                            style:
                                                                                TextStyles.bodytext3(context),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.2,
                                                                  //  color: Colors.red,
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: Screens.width(
                                                                            context) *
                                                                        0.06,
                                                                    backgroundColor: theme
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            0.9),
                                                                    child: Icon(
                                                                      Icons
                                                                          .arrow_right_alt_rounded,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                  Center(
                                    child: SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      width: Screens.width(context),
                                      //color: Colors.red,
                                      // margin: const EdgeInsets.all(20),
                                      //   child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme.primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        // onPressed: () {},
                                        onPressed:context
                                                        .watch<
                                                            inwardcontroller>()
                                                        . saveenablebutton ==false
                                        // context
                                        //             .watch<inwardcontroller>()
                                        //             .grpTotal !=
                                        //         context
                                        //             .read<inwardcontroller>()
                                        //             .getqty
                                            ? null
                                            : context
                                                        .watch<
                                                            inwardcontroller>()
                                                        .finallodaing ==
                                                    true
                                                ? null
                                                : () {
                                                    context
                                                        .read<
                                                            inwardcontroller>()
                                                        .savefinal(context);
                                                  },
                                        child: context
                                                    .watch<inwardcontroller>()
                                                    .finallodaing ==
                                                false
                                            ? Text('Save',
                                                style:
                                                    TextStyles.btnText(context))
                                            : SpinKitThreeBounce(
                                                size: Screens.width(context) *
                                                    0.05,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ),
              ),

              //secondpage
              context.watch<inwardcontroller>().inwItemList2 == null
                  ? Container()
                  : Container(
                      height: Screens.bodyheight(context),
                      width: Screens.width(context),
                      child: Container(
                        alignment: Alignment.center,
                        height: Screens.bodyheight(context),
                        width: Screens.width(context),
                        padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.04,
                            right: Screens.width(context) * 0.04,
                            top: Screens.padingHeight(context) * 0.06,
                            bottom: Screens.padingHeight(context) * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Screens.width(context),
                              child: Column(
                                children: [
                                  context
                                          .read<inwardcontroller>()
                                          .inwdocDetail
                                          .isEmpty
                                      ? Container()
                                      : Container(
                                          width: Screens.width(context),
                                          // height: Screens.heigt(context)*0.07,
                                          //   color: Colors.red,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Doc No: ${context.read<inwardcontroller>().inwdocDetail[0].DocNum}",
                                            // ${grpDetails[ind].NumAtCard}",
                                            style:
                                                TextStyles.headline2(context),
                                          ),
                                        ),
                                  context
                                          .read<inwardcontroller>()
                                          .inwdocDetail
                                          .isEmpty
                                      ? Container()
                                      : Container(
                                          width: Screens.width(context),
                                          //  height: Screens.heigt(context)*0.07,
                                          //  color: Colors.green,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Vendor: ${context.read<inwardcontroller>().inwdocDetail[0].SupplierName}",
                                            // ${grpDetails[ind].CardCode} - ${grpDetails[ind].CardName}",
                                            style:
                                                TextStyles.headline2(context),
                                          ),
                                        ),
                                  context
                                              .watch<inwardcontroller>()
                                              .inwItemList2 !=
                                          null
                                      ? Container(
                                          width: Screens.width(context),
                                          //  height: Screens.heigt(context)*0.07,
                                          //  color: Colors.green,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${context.read<inwardcontroller>().inwItemList2!.ItemCode}",
                                            // "${grpDetails[ind].ItemCode}",
                                            style:
                                                TextStyles.headline2(context),
                                          ),
                                        )
                                      : Container(),
                                  context
                                              .watch<inwardcontroller>()
                                              .inwItemList2 !=
                                          null
                                      ? Container(
                                          width: Screens.width(context),
                                          //  height: Screens.heigt(context)*0.07,
                                          //  color: Colors.green,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${context.read<inwardcontroller>().inwItemList2!.ItemName}",
                                            // ${grpDetails[ind].Dscription}",
                                            style:
                                                TextStyles.headline2(context),
                                          ),
                                        )
                                      : Container(),
                                  context
                                              .watch<inwardcontroller>()
                                              .inwItemList2 !=
                                          null
                                      ? Container(
                                          width: Screens.width(context),
                                          //  height: Screens.heigt(context)*0.07,
                                          //  color: Colors.green,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Quantity:  ${context.read<inwardcontroller>().inwItemList2!.Unit_Quantity!.toStringAsFixed(0)}/${context.read<inwardcontroller>().ScannedQty()}",
                                            // ${grpDetails[ind].Quantity.toStringAsFixed(0)}/${data.length}",
                                            style:
                                                TextStyles.headline2(context),
                                          ),
                                        )
                                      : Container(),
                                  context
                                              .watch<inwardcontroller>()
                                              .inwItemList2 !=
                                          null
                                      ? Container(
                                          // color: Colors.amber,
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.05,
                                          child: Row(
                                            mainAxisAlignment: context
                                                            .watch<
                                                                inwardcontroller>()
                                                            .inwItemList2!
                                                            .ManageBy !=
                                                        null &&
                                                    context
                                                        .watch<
                                                            inwardcontroller>()
                                                        .inwItemList2!
                                                        .ManageBy!
                                                        .isNotEmpty
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.end,
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              context
                                                          .watch<
                                                              inwardcontroller>()
                                                          .inwItemList2!
                                                          .ManageBy !=
                                                      null
                                                  ? Container(
                                                      child: Text(
                                                          "Managed By : ${context.read<inwardcontroller>().inwItemList2!.ManageBy!}"),
                                                    )
                                                  : Container(),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text("Do Putaway"),
                                                    Switch(
                                                        value: context
                                                            .watch<
                                                                inwardcontroller>()
                                                            .isputawaycheck,
                                                        onChanged: context
                                                                    .watch<
                                                                        inwardcontroller>()
                                                                    .isonputchange ==
                                                                true
                                                            ? (val) {
                                                                log("isonputchange::");
                                                              }
                                                            : (val) {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          inwardcontroller>()
                                                                      .onchangeputaway(
                                                                          context);
                                                                  if (val ==
                                                                      true) {
                                                                    focus1
                                                                        .requestFocus();
                                                                  }
                                                                });
                                                              })
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  context
                                              .watch<inwardcontroller>()
                                              .isputawaycheck ==
                                          false
                                      ? Container()
                                      : Container(
                                          width: Screens.width(context),
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(05),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  // color: Colors.deepOrange,
                                                  width:
                                                      Screens.width(context) *
                                                          0.78,
                                                  child: TextFormField(
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    // readOnly:
                                                    //     context.watch<inwardcontroller>().isputawaycheck ==
                                                    //             false
                                                    //         ? true
                                                    //         : false,
                                                    focusNode: focus1,
                                                    autofocus: true,
                                                    controller: context
                                                        .read<
                                                            inwardcontroller>()
                                                        .mycontroller[0],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Required *";
                                                      }

                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Bin Code Scanning',
                                                      contentPadding: EdgeInsets.symmetric(
                                                          vertical: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.01,
                                                          horizontal:
                                                              Screens.width(
                                                                      context) *
                                                                  0.01),
                                                      border: InputBorder.none,
                                                    ),
                                                    onEditingComplete: () {
                                                      context
                                                          .read<
                                                              inwardcontroller>()
                                                          .afterBinScanned(
                                                              context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .mycontroller[
                                                                      0]
                                                                  .text,
                                                              context);
                                                      focus1.unfocus();
                                                      focus2.requestFocus();
                                                    },
                                                    cursorColor:
                                                        theme.primaryColor,
                                                  ),
                                                ),
                                                ConstantValues.scanneruser ==
                                                        true
                                                    ? Container()
                                                    : InkWell(
                                                        onTap: context
                                                                    .watch<
                                                                        inwardcontroller>()
                                                                    .iscamera2 ==
                                                                true
                                                            ? () {}
                                                            : () {
                                                                focus.unfocus();
                                                                // Future.delayed(
                                                                //     Duration(
                                                                //         seconds: 1),
                                                                //     () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          inwardcontroller>()
                                                                      .iscamera2 = true;
                                                                });
                                                                // setState(() {
                                                                //   startScan = true;
                                                                //   binCodeScanning =
                                                                //       true;
                                                                // });
                                                                QRscannerState
                                                                        .inwardbinscan =
                                                                    true;
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (_) =>
                                                                                QRscanner())).then(
                                                                    (value) {
                                                                  setState(() {
                                                                    context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .iscamera2 = false;
                                                                  });
                                                                  if (context
                                                                          .read<
                                                                              inwardcontroller>()
                                                                          .binscannedData !=
                                                                      '') {
                                                                    log("binScanned");
                                                                    context.read<inwardcontroller>().afterBinScanned(
                                                                        context
                                                                            .read<inwardcontroller>()
                                                                            .binscannedData,
                                                                        context);
                                                                    focus1
                                                                        .unfocus();
                                                                    focus2
                                                                        .requestFocus();
                                                                  }
                                                                });
                                                                // });
                                                              },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          // color: Colors.lightGreenAccent,
                                                          child: Icon(
                                                            Icons
                                                                .qr_code_outlined,
                                                            color: theme
                                                                .primaryColor,
                                                            size: Screens
                                                                    .padingHeight(
                                                                        context) *
                                                                0.05,
                                                          ),
                                                        ),
                                                      )
                                              ]),
                                        ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Container(
                                    width: Screens.width(context),
                                    height:
                                        Screens.padingHeight(context) * 0.06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(05),
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            // color: Colors.deepOrange,
                                            width:
                                                Screens.width(context) * 0.78,
                                            child: TextFormField(
                                              onTap: () {
                                                setState(() {
                                                  if (context
                                                              .read<
                                                                  inwardcontroller>()
                                                              .isputawaycheck ==
                                                          true &&
                                                      context
                                                          .read<
                                                              inwardcontroller>()
                                                          .mycontroller[0]
                                                          .text
                                                          .isEmpty) {
                                                    context
                                                        .read<
                                                            inwardcontroller>()
                                                        .showtoastInw(
                                                            "Enter Bincode First..!!");
                                                    focus2.unfocus();
                                                  } else if (context
                                                              .read<
                                                                  inwardcontroller>()
                                                              .isputawaycheck ==
                                                          true &&
                                                      context
                                                          .read<
                                                              inwardcontroller>()
                                                          .mycontroller[0]
                                                          .text
                                                          .isNotEmpty) {
                                                    context
                                                        .read<
                                                            inwardcontroller>()
                                                        .afterBinScanned(
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .mycontroller[0]
                                                                .text,
                                                            context);
                                                    focus2.requestFocus();
                                                  }
                                                });

                                                // context
                                                //     .read<inwardcontroller>()
                                                //     .ontapserial(context);
                                              },
                                              readOnly: context
                                                              .watch<
                                                                  inwardcontroller>()
                                                              .isputawaycheck ==
                                                          true &&
                                                      context
                                                          .watch<
                                                              inwardcontroller>()
                                                          .mycontroller[0]
                                                          .text
                                                          .isEmpty
                                                  ? true
                                                  : false,
                                              // focusNode: focus,
                                              // keyboardType:context
                                              //       .watch<inwardcontroller>()
                                              //       .isfinalloop==true ?TextInputType.none:TextInputType.text,
                                              controller: context
                                                  .read<inwardcontroller>()
                                                  .mycontroller[1],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Required *";
                                                }

                                                return null;
                                              },
                                              focusNode: focus2,
                                              onEditingComplete: () {
                                                setState(() {
                                                  if (context
                                                          .read<
                                                              inwardcontroller>()
                                                          .inwItemList2!
                                                          .ManageBy!
                                                          .toLowerCase() ==
                                                      "s") {
                                                    context
                                                        .read<
                                                            inwardcontroller>()
                                                        .afterSerialScanned(
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .mycontroller[1]
                                                                .text,
                                                            context);
                                                    focus2.unfocus();
                                                    focus2.requestFocus();
                                                  } else {
                                                    context
                                                        .read<
                                                            inwardcontroller>()
                                                        .mangedbyBatch(context
                                                            .read<
                                                                inwardcontroller>()
                                                            .mycontroller[1]
                                                            .text);
                                                    focus2.unfocus();
                                                    // focus.requestFocus();
                                                  }
                                                });
                                              },

                                              autofocus: true,
                                              decoration: InputDecoration(
                                                hintText: 'Scan Serial Number',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.01,
                                                        horizontal:
                                                            Screens.width(
                                                                    context) *
                                                                0.01),
                                                border: InputBorder.none,
                                              ),
                                              cursorColor: Colors.blue,
                                            ),
                                          ),
                                          ConstantValues.scanneruser == true
                                              ? Container()
                                              : InkWell(
                                                  onTap: context
                                                              .read<
                                                                  inwardcontroller>()
                                                              .iscamera ==
                                                          true
                                                      ? () {
                                                          log("hi hi ");
                                                        }
                                                      : () {
                                                          if (context
                                                                      .read<
                                                                          inwardcontroller>()
                                                                      .isputawaycheck ==
                                                                  true &&
                                                              context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .mycontroller[
                                                                      0]
                                                                  .text
                                                                  .isEmpty) {
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .showtoastInw(
                                                                    "Enter Bincode First..!!");
                                                            focus2.unfocus();
                                                          } else if (context
                                                                      .read<
                                                                          inwardcontroller>()
                                                                      .isputawaycheck ==
                                                                  true &&
                                                              context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .mycontroller[
                                                                      0]
                                                                  .text
                                                                  .isNotEmpty) {
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .afterBinScanned(
                                                                    context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .mycontroller[
                                                                            0]
                                                                        .text,
                                                                    context);
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .iscamera = true;
                                                            });
                                                            QRscannerState
                                                                    .inwardSerialscan =
                                                                true;
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        QRscanner())).then(
                                                                (value) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        inwardcontroller>()
                                                                    .iscamera = false;
                                                              });

                                                              if (context
                                                                      .read<
                                                                          inwardcontroller>()
                                                                      .serialscannedData !=
                                                                  '') {
                                                                setState(() {
                                                                  if (context
                                                                          .read<
                                                                              inwardcontroller>()
                                                                          .inwItemList2!
                                                                          .ManageBy!
                                                                          .toLowerCase() ==
                                                                      "s") {
                                                                    context.read<inwardcontroller>().afterSerialScanned(
                                                                        context
                                                                            .read<inwardcontroller>()
                                                                            .serialscannedData,
                                                                        context);
                                                                    focus2
                                                                        .unfocus();
                                                                    focus2
                                                                        .requestFocus();
                                                                  } else {
                                                                    context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .mangedbyBatch(context
                                                                            .read<inwardcontroller>()
                                                                            .serialscannedData);
                                                                    focus2
                                                                        .unfocus();
                                                                    // focus.requestFocus();
                                                                  }
                                                                });
                                                              }
                                                            });
                                                          } else {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .iscamera = true;
                                                            });
                                                            QRscannerState
                                                                    .inwardSerialscan =
                                                                true;
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        QRscanner())).then(
                                                                (value) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        inwardcontroller>()
                                                                    .iscamera = false;
                                                              });

                                                              if (context
                                                                      .read<
                                                                          inwardcontroller>()
                                                                      .serialscannedData !=
                                                                  '') {
                                                                setState(() {
                                                                  if (context
                                                                          .read<
                                                                              inwardcontroller>()
                                                                          .inwItemList2!
                                                                          .ManageBy!
                                                                          .toLowerCase() ==
                                                                      "s") {
                                                                    context.read<inwardcontroller>().afterSerialScanned(
                                                                        context
                                                                            .read<inwardcontroller>()
                                                                            .serialscannedData,
                                                                        context);
                                                                    focus2
                                                                        .unfocus();
                                                                    focus2
                                                                        .requestFocus();
                                                                  } else {
                                                                    context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .mangedbyBatch(context
                                                                            .read<inwardcontroller>()
                                                                            .serialscannedData);
                                                                    focus2
                                                                        .unfocus();
                                                                    // focus.requestFocus();
                                                                  }
                                                                });
                                                              }
                                                            });
                                                          }
                                                          // focus.unfocus();
                                                          // Future.delayed(
                                                          //     Duration(seconds: 1),
                                                          //     () {

                                                          // }
                                                          // );
                                                        },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    // color: Colors.lightGreenAccent,
                                                    child: Icon(
                                                      Icons.qr_code_outlined,
                                                      color: theme.primaryColor,
                                                      size:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.05,
                                                    ),
                                                  ),
                                                )
                                        ]),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.78,
                                              child: TextFormField(
                                                controller: context
                                                    .read<inwardcontroller>()
                                                    .mycontroller[2],
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                readOnly: context
                                                            .read<
                                                                inwardcontroller>()
                                                            .inwItemList2!
                                                            .ManageBy!
                                                            .toLowerCase() ==
                                                        "s"
                                                    ? true
                                                    : false,
                                                decoration: InputDecoration(
                                                  hintText: 'Quantity',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.01,
                                                          horizontal:
                                                              Screens.width(
                                                                      context) *
                                                                  0.01),
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.005,
                                            ),
                                            context
                                                        .watch<
                                                            inwardcontroller>()
                                                        .inwItemList2!
                                                        .hasExpiryDate ==
                                                    false
                                                ? Container()
                                                : Container(
                                                    width:
                                                        Screens.width(context) *
                                                            0.78,
                                                    child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              inwardcontroller>()
                                                          .mycontroller[3],
                                                      readOnly: true,
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                inwardcontroller>()
                                                            .showexpDate(
                                                                context);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: IconButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .showexpDate(
                                                                      context);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .calendar_month,
                                                              color: theme
                                                                  .primaryColor,
                                                            )),
                                                        hintText: 'Expiry Date',
                                                        contentPadding: EdgeInsets.symmetric(
                                                            vertical: Screens
                                                                    .padingHeight(
                                                                        context) *
                                                                0.01,
                                                            horizontal:
                                                                Screens.width(
                                                                        context) *
                                                                    0.01),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: theme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: IconButton(
                                              onPressed: context
                                                          .read<
                                                              inwardcontroller>()
                                                          .inwItemList2!
                                                          .ManageBy!
                                                          .toLowerCase() ==
                                                      "s"
                                                  ? () {}
                                                  : () {
                                                      if (context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .inwItemList2!
                                                                  .hasExpiryDate ==
                                                              true &&
                                                          context
                                                              .read<
                                                                  inwardcontroller>()
                                                              .mycontroller[3]
                                                              .text
                                                              .isEmpty) {
                                                        context
                                                            .read<
                                                                inwardcontroller>()
                                                            .showtoastfordate();
                                                        //       const snackBar =
                                                        //     SnackBar(
                                                        //         duration:
                                                        //             Duration(
                                                        //                 seconds:
                                                        //                     4),
                                                        //         backgroundColor:
                                                        //             Colors
                                                        //                 .red,
                                                        //         content: Text(
                                                        //           "Select Expiry Date..!!",
                                                        //           style: const TextStyle(
                                                        //               color: Colors
                                                        //                   .white),
                                                        //         ));
                                                        // ScaffoldMessenger.of(
                                                        //         context)
                                                        //     .showSnackBar(
                                                        //         snackBar);
                                                      } else {
                                                        if (context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .mycontroller[2]
                                                                .text
                                                                .isNotEmpty &&
                                                            int.parse(context
                                                                    .read<
                                                                        inwardcontroller>()
                                                                    .mycontroller[
                                                                        2]
                                                                    .text) >
                                                                0) {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .afterSerialScanned(
                                                                    context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .mycontroller[
                                                                            1]
                                                                        .text,
                                                                    context);
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          });
                                                        } else {
                                                          if (int.parse(context
                                                                  .read<
                                                                      inwardcontroller>()
                                                                  .mycontroller[
                                                                      2]
                                                                  .text) <=
                                                              0) {
                                                            const snackBar =
                                                                SnackBar(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            4),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      "Value 0 not accepted..!!",
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ));
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          } else {
                                                            const snackBar =
                                                                SnackBar(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            4),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      "Enter Quantity..!!",
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ));
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          }
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
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.005,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: finaldbdata.length,
                                    itemBuilder: (c, i) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: Screens.width(context) * 0.01,
                                            bottom:
                                                Screens.width(context) * 0.01),
                                        child: Card(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              color: Colors.grey[200],
                                              width: Screens.width(context),
                                              padding: EdgeInsets.only(
                                                left: Screens.width(context) *
                                                    0.02,
                                                right: Screens.width(context) *
                                                    0.02,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          width: Screens.width(
                                                                  context) *
                                                              0.4,
                                                          // color: Colors.green,
                                                          child: Text(
                                                            "${finaldbdata[i].serialNum}",
                                                            style: TextStyles
                                                                .bodytext2(
                                                                    context),
                                                          )),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Screens.width(
                                                                  context) *
                                                              0.2,
                                                          //  color: Colors.red,
                                                          child: finaldbdata[i]
                                                                          .binCode ==
                                                                      null ||
                                                                  finaldbdata[i]
                                                                          .binCode ==
                                                                      ''
                                                              ? Text("")
                                                              : Text(
                                                                  "${finaldbdata[i].binCode}",
                                                                  style: TextStyles
                                                                      .bodytext2(
                                                                          context),
                                                                )),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          //  color: Colors.red,
                                                          child: Text(
                                                            "${finaldbdata[i].quantity.toStringAsFixed(0)}",
                                                            style: TextStyles
                                                                .bodytext2(
                                                                    context),
                                                          )),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: Screens.width(
                                                                context) *
                                                            0.1,
                                                        //color: Colors.red,
                                                        //  child: CircleAvatar(
                                                        //    radius: Screens.width(context)*0.06,
                                                        //    backgroundColor:PrimaryColor.appColor ,
                                                        child: InkWell(
                                                          onTap: () {
                                                            int originalIndex =
                                                                context
                                                                        .read<
                                                                            inwardcontroller>()
                                                                        .dbdata
                                                                        .length -
                                                                    1 -
                                                                    i;
                                                            log("ddd::" +
                                                                originalIndex
                                                                    .toString());
                                                            context
                                                                .read<
                                                                    inwardcontroller>()
                                                                .deletescandata(
                                                                    originalIndex);
                                                            // DataBaseHelper.delete(
                                                            //     grpDetails[
                                                            //             ind]
                                                            //         .DocEntry,
                                                            //     grpDetails[
                                                            //             ind]
                                                            //         .ItemCode,
                                                            //     grpDetails[
                                                            //             ind]
                                                            //         .LineNum
                                                            //         .toString());
                                                            // setState(() {
                                                            //   data.removeAt(
                                                            //       i);
                                                            // });
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red,
                                                            size: Screens.width(
                                                                    context) *
                                                                0.1,
                                                            // ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  finaldbdata[i].expirydate ==
                                                              null ||
                                                          finaldbdata[i]
                                                                  .expirydate ==
                                                              ''
                                                      ? Container()
                                                      : Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          width: Screens.width(
                                                                  context) *
                                                              0.5,
                                                          //  color: Colors.red,
                                                          child: finaldbdata[i]
                                                                          .expirydate ==
                                                                      null ||
                                                                  finaldbdata[i]
                                                                          .expirydate ==
                                                                      ''
                                                              ? Text("")
                                                              : Text(
                                                                  "Expiry Date : ${finaldbdata[i].expirydate}",
                                                                  style: TextStyles
                                                                      .bodytext2(
                                                                          context),
                                                                )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                            Center(
                              child: SizedBox(
                                height: Screens.padingHeight(context) * 0.06,
                                width: Screens.width(context),
                                //color: Colors.red,
                                // margin: const EdgeInsets.all(20),
                                //   child: Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                        context
                                            .read<inwardcontroller>()
                                            .savedbinw();
                                      });
                                    },
                                    child: Text('Save and Back',
                                        style: TextStyles.btnText(context))
                                    // : SpinKitThreeBounce(
                                    //     size: width * 0.05,
                                    //     color: Colors.white,
                                    //   ),
                                    ),
                              ),
                            ),
                          ],
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
