import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/controller/ItemSearchController/ItemSearchController.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ItemSearch extends StatefulWidget {
  const ItemSearch({super.key});

  @override
  State<ItemSearch> createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ItemSearchController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    child: Text("Item Search",
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
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02,
                  vertical: Screens.padingHeight(context) * 0.01),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.06,
                        width: Screens.width(context) * 0.8,
                        // decoration: BoxDecoration(
                        //     color: Colors.grey[200],
                        //     borderRadius: BorderRadius.circular(8),
                        //     border: Border.all(color: Colors.black26)),
                        child: TextFormField(
                          controller: context
                              .read<ItemSearchController>()
                              .mycontroller[0],
                          onEditingComplete: () {
                            setState(() {
                              context
                                      .read<ItemSearchController>()
                                      .seialScannedCode =
                                  context
                                      .read<ItemSearchController>()
                                      .mycontroller[0]
                                      .text;
                              FocusScope.of(context).unfocus();
                              // context
                              //     .read<ItemSearchController>()
                              //     .GetAllData(context);
                            });
                          },
                          // focusNode:
                          //     context.read<ItemSearchController>().focus1,
                          decoration: InputDecoration(
                            labelText: "Serial number..!!",
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
                            suffixIcon: ConstantValues.scanneruser == true
                                ? Container(
                                    width: Screens.width(context) * 0.01)
                                : IconButton(
                                    // iconSize:
                                    //     Screens.padingHeight(context) * 0.03,
                                    color: theme.primaryColor,
                                    // onPressed: (){},
                                    onPressed: QRscannerState.itmeSEserial ==
                                            true
                                        ? () {}
                                        : () {
                                            setState(() {
                                              QRscannerState.itmeSEserial =
                                                  true;
                                            });

                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRscanner()))
                                                .then((value) {
                                              if (context
                                                      .read<
                                                          ItemSearchController>()
                                                      .seialScannedCode !=
                                                  '') {
                                                context
                                                        .read<
                                                            ItemSearchController>()
                                                        .mycontroller[0]
                                                        .text =
                                                    context
                                                        .read<
                                                            ItemSearchController>()
                                                        .seialScannedCode
                                                        .toString();
                                                FocusScope.of(context)
                                                    .unfocus();
                                                // context
                                                //     .read<
                                                //         ItemSearchController>()
                                                //     .GetAllData(context);
                                              }
                                            });
                                          },
                                    icon: Icon(
                                      Icons.qr_code_outlined,
                                      size:
                                          Screens.padingHeight(context) * 0.04,
                                    )),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: Screens.padingHeight(context) * 0.02,
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {
                              if (context
                                  .read<ItemSearchController>()
                                  .mycontroller[0]
                                  .text
                                  .isNotEmpty) {
                                context
                                        .read<ItemSearchController>()
                                        .seialScannedCode =
                                    context
                                        .read<ItemSearchController>()
                                        .mycontroller[0]
                                        .text;
                                if (context
                                        .read<ItemSearchController>()
                                        .seialScannedCode !=
                                    '') {
                                  context
                                      .read<ItemSearchController>()
                                      .GetAllData(context, 1);
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
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.005,
                  ),
                   Text("(OR)",style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),),
                 SizedBox(
                    height: Screens.padingHeight(context) * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.06,
                        width: Screens.width(context) * 0.8,
                        // decoration: BoxDecoration(
                        //     color: Colors.grey[200],
                        //     borderRadius: BorderRadius.circular(8),
                        //     border: Border.all(color: Colors.black26)),
                        child: TextFormField(
                          controller: context
                              .read<ItemSearchController>()
                              .mycontroller[1],
                          onEditingComplete: () {
                            setState(() {
                              context
                                      .read<ItemSearchController>()
                                      .itemScannedCode =
                                  context
                                      .read<ItemSearchController>()
                                      .mycontroller[1]
                                      .text;
                              FocusScope.of(context).unfocus();
                              // context
                              //     .read<ItemSearchController>()
                              //     .GetAllData(context);
                            });
                          },
                          // focusNode:
                          //     context.read<ItemSearchController>().focus1,
                          decoration: InputDecoration(
                            labelText: "Item code..!!",
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
                            suffixIcon: ConstantValues.scanneruser == true
                                ? Container(
                                    width: Screens.width(context) * 0.01)
                                : IconButton(
                                    // iconSize:
                                    //     Screens.padingHeight(context) * 0.03,
                                    color: theme.primaryColor,
                                    // onPressed: (){},
                                    onPressed: QRscannerState.itmeSEitem == true
                                        ? () {}
                                        : () {
                                            setState(() {
                                              QRscannerState.itmeSEitem = true;
                                            });

                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRscanner()))
                                                .then((value) {
                                              if (context
                                                      .read<
                                                          ItemSearchController>()
                                                      .itemScannedCode !=
                                                  '') {
                                                context
                                                        .read<
                                                            ItemSearchController>()
                                                        .mycontroller[1]
                                                        .text =
                                                    context
                                                        .read<
                                                            ItemSearchController>()
                                                        .itemScannedCode
                                                        .toString();
                                                // context
                                                //     .read<
                                                //         ItemSearchController>()
                                                //     .GetAllData(context);
                                              }
                                            });
                                          },
                                    icon: Icon(
                                      Icons.qr_code_outlined,
                                      size:
                                          Screens.padingHeight(context) * 0.04,
                                    )),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: Screens.padingHeight(context) * 0.02,
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {
                              if (context
                                  .read<ItemSearchController>()
                                  .mycontroller[1]
                                  .text
                                  .isNotEmpty) {
                                context
                                        .read<ItemSearchController>()
                                        .itemScannedCode =
                                    context
                                        .read<ItemSearchController>()
                                        .mycontroller[1]
                                        .text;
                                if (context
                                        .read<ItemSearchController>()
                                        .itemScannedCode !=
                                    '') {
                                  context
                                      .read<ItemSearchController>()
                                      .GetAllData(context, 2);
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
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.005,
                  ),
                  Text("(OR)",style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.06,
                        width: Screens.width(context) * 0.8,
                        // decoration: BoxDecoration(
                        //     color: Colors.grey[200],
                        //     borderRadius: BorderRadius.circular(8),
                        //     border: Border.all(color: Colors.black26)),
                        child: TextFormField(
                          controller: context
                              .read<ItemSearchController>()
                              .mycontroller[2],
                          onEditingComplete: () {
                            setState(() {
                              context
                                      .read<ItemSearchController>()
                                      .binScannedCode =
                                  context
                                      .read<ItemSearchController>()
                                      .mycontroller[2]
                                      .text;
                              FocusScope.of(context).unfocus();
                              // context
                              //     .read<ItemSearchController>()
                              //     .GetAllData(context);
                            });
                          },
                          // focusNode: context.read<ItemSearchController>().focus,
                          decoration: InputDecoration(
                            labelText: "Bin code..!!",
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
                            suffixIcon: ConstantValues.scanneruser == true
                                ? Container(
                                    width: Screens.width(context) * 0.01)
                                : IconButton(
                                    // iconSize:
                                    //     Screens.padingHeight(context) * 0.03,
                                    color: theme.primaryColor,
                                    // onPressed: (){},
                                    onPressed: QRscannerState.itmeSEbin == true
                                        ? () {}
                                        : () {
                                            setState(() {
                                              QRscannerState.itmeSEbin = true;
                                            });

                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRscanner()))
                                                .then((value) {
                                              if (context
                                                      .read<
                                                          ItemSearchController>()
                                                      .binScannedCode !=
                                                  '') {
                                                context
                                                        .read<
                                                            ItemSearchController>()
                                                        .mycontroller[2]
                                                        .text =
                                                    context
                                                        .read<
                                                            ItemSearchController>()
                                                        .binScannedCode
                                                        .toString();
                                                // context
                                                //     .read<
                                                //         ItemSearchController>()
                                                //     .GetAllData(context);
                                              }
                                            });
                                          },
                                    icon: Icon(
                                      Icons.qr_code_outlined,
                                      size:
                                          Screens.padingHeight(context) * 0.04,
                                    )),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: Screens.padingHeight(context) * 0.02,
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {
                              if (context
                                  .read<ItemSearchController>()
                                  .mycontroller[2]
                                  .text
                                  .isNotEmpty) {
                                context
                                        .read<ItemSearchController>()
                                        .binScannedCode =
                                    context
                                        .read<ItemSearchController>()
                                        .mycontroller[2]
                                        .text;
                                if (context
                                        .read<ItemSearchController>()
                                        .binScannedCode !=
                                    '') {
                                  context
                                      .read<ItemSearchController>()
                                      .GetAllData(context, 3);
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
                ],
              ),
            ),
              // context
              //           .watch<ItemSearchController>()
              //           .bincontentList
              //           .isNotEmpty?  
                          Container(
                    padding: EdgeInsets.only(
                       left: Screens.width(context)*0.03,
                      right: Screens.width(context)*0.03
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    context
                        .watch<ItemSearchController>()
                        .bincontentList
                        .isNotEmpty?      Container(
                          child: Text("Total Qty : ${context
                                                    .read<ItemSearchController>()
                                                    .totalQuantity()}",style: theme.textTheme.bodyText1!.copyWith(fontSize: 15,fontWeight: FontWeight.normal,color: theme.primaryColor)),
                        ):Container(),
                        InkWell(
                          onTap: (){
                            setState(() {
                             context
                                                    .read<ItemSearchController>()
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
                            child: Text("Clear All",style: theme.textTheme.bodyText1!.copyWith(fontSize: 15,fontWeight: FontWeight.normal,color: theme.primaryColor),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // :Container(),
            Expanded(
                child: context.watch<ItemSearchController>().qrerror == '' &&
                        context.watch<ItemSearchController>().isloading ==
                            true &&
                        context
                            .read<ItemSearchController>()
                            .bincontentList
                            .isEmpty
                    ? Container(
                        child: Center(
                          child: SpinKitThreeBounce(
                            size: Screens.width(context) * 0.1,
                            color: theme.primaryColor,
                          ),
                        ),
                      )
                    : context.read<ItemSearchController>().qrerror.isNotEmpty &&
                            context.watch<ItemSearchController>().isloading ==
                                false &&
                            context
                                .read<ItemSearchController>()
                                .bincontentList
                                .isEmpty
                        ? Container(
                            child: Center(
                              child: Text(
                                  "${context.read<ItemSearchController>().qrerror}"),
                            ),
                          )
                        : context.watch<ItemSearchController>().isloading ==
                                    false &&
                                context
                                    .read<ItemSearchController>()
                                    .bincontentList
                                    .isEmpty
                            ? Container(
                                child: Center(child: Text("No Data..!!")),
                              )
                            : ListView.builder(
                                itemCount: context
                                    .read<ItemSearchController>()
                                    .bincontentList
                                    .length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.padingHeight(context) *
                                                0.002),
                                    child: Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: theme.primaryColor
                                              .withOpacity(0.07),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Screens.width(context) * 0.02,
                                            vertical:
                                                Screens.padingHeight(context) *
                                                    0.01),
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
                                                   width: Screens.width(context)*0.5,
                                                  child: Text("Item Name",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Container(
                                                  child: Text("Bin code",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Screens.padingHeight(context)*0.005,),
                                              Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                   width: Screens.width(context)*0.7,
                                                  child: Text(
                                                      "${context.read<ItemSearchController>().bincontentList[i].ItemName}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Container(
                                                  child: Text(
                                                      "${context.read<ItemSearchController>().bincontentList[i].BinCode}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                              ],
                                            ),
                                            // Container(
                                            //   child: Text(
                                            //       "${context.read<ItemSearchController>().bincontentList[i].ItemName}",
                                            //       style: theme
                                            //           .textTheme.bodyText1!
                                            //           .copyWith(
                                            //               color: theme
                                            //                   .primaryColor,
                                            //               fontWeight:
                                            //                   FontWeight.w400)),
                                            // ),
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
                                                   width: Screens.width(context)*0.5,
                                                  child: Text("Item code",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Container(
                                                  child: Text("Bin Qty",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
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
                                                   width: Screens.width(context)*0.5,
                                                  child: Text(
                                                      "${context.read<ItemSearchController>().bincontentList[i].ItemCode}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Container(
                                                  child: Text(
                                                      "${context.read<ItemSearchController>().bincontentList[i].BinQty!.toStringAsFixed(0)}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
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
                                                  child: Text("Serial/batch",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                // Container(
                                                //   child: Text("Bin Qty",
                                                //       style: theme
                                                //           .textTheme.bodyText1!
                                                //           .copyWith(
                                                //               color: Colors
                                                //                   .grey[500],
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .w300)),
                                                // ),
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
                                                  child: Text(
                                                      "${context.read<ItemSearchController>().bincontentList[i].SerialBatchCode}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Container(
                                                   padding: EdgeInsets.all(4),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                color: Colors.lightGreen.withOpacity(0.5),

                                                              ),
                                                  child: Text(
                                                      "${context.read<ItemSearchController>().bincontentList[i].Status}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
          ],
        ),
      ),
    );
  }
}
