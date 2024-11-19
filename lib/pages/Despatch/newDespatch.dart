import 'dart:developer';

import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/DespatchController/NewDespatchController.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class NewDespatch extends StatefulWidget {
  const NewDespatch({super.key});

  @override
  State<NewDespatch> createState() => _NewDespatchState();
}

class _NewDespatchState extends State<NewDespatch> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewDespatchController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text("New Despatch"),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.03,
                  right: Screens.width(context) * 0.03,
                  top: Screens.padingHeight(context) * 0.01),
              child: Column(
                children: [
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                  Container(
                    height: Screens.padingHeight(context) * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      cursorColor: theme.primaryColor,
                      controller:
                          context.read<NewDespatchController>().mycontroller[5],
                      autocorrect: false,
                      // style: TextStyles.bodytext2(context),
                      onChanged: (v) {
                        // setState(() {
                        //   context
                        //       .read<NewDespatchController>()
                        //       .SearchFilterPending(v);
                        // });
                      },
                      onEditingComplete: () {
                        setState(() {
                          if (context
                              .read<NewDespatchController>()
                              .mycontroller[5]
                              .text
                              .isNotEmpty) {
                            context.read<NewDespatchController>().scannedData =
                                context
                                    .read<NewDespatchController>()
                                    .mycontroller[5]
                                    .text;
                            context.read<NewDespatchController>().callQRAPi(
                                context
                                    .read<NewDespatchController>()
                                    .mycontroller[5]
                                    .text,
                                context);
                            // context
                            //     .read<NewDespatchController>()
                            //     .scanneddataget(context);
                          } else {
                            // context.read<NewDespatchController>().resetfirst();
                          }
                        });
                      },
                      style: TextStyles.bodytext2(context),
                      decoration: InputDecoration(
                        hintText: 'Scan QR..',
                        // AppLocalizations.of(context)!
                        //     .search_sales_quot,

                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: ConstantValues.scanneruser == true
                            ? Container(width: Screens.width(context) * 0.01)
                            : IconButton(
                                iconSize: Screens.padingHeight(context) * 0.04,
                                color: theme.primaryColor,
                                onPressed: QRscannerState.despatchscan == true
                                    ? () {
                                        log("ANNNN");
                                      }
                                    : () {
                                        setState(() {
                                          QRscannerState.despatchscan = true;
                                        });

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QRscanner())).then((value) {
                                          QRscannerState.despatchscan = false;
                                          log(".then");
                                          if (context
                                                  .read<NewDespatchController>()
                                                  .scannedData !=
                                              '') {
                                            context
                                                    .read<NewDespatchController>()
                                                    .mycontroller[5]
                                                    .text =
                                                context
                                                    .read<
                                                        NewDespatchController>()
                                                    .scannedData;
                                            context
                                                .read<NewDespatchController>()
                                                .callQRAPi(
                                                    context
                                                        .read<
                                                            NewDespatchController>()
                                                        .mycontroller[5]
                                                        .text,
                                                    context);
                                          }
                                        });
                                      },
                                icon: Icon(Icons.qr_code_outlined)),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                ],
              ),
            ),
            Expanded(
              child: 
                      context.watch<NewDespatchController>().qrloading ==
                          true 
                  ? Container(
                      child: Center(
                        child: SpinKitThreeBounce(
                          size: Screens.width(context) * 0.1,
                          color: theme.primaryColor,
                        ),
                      ),
                    )
                  // : context.read<NewDespatchController>().qrerror.isNotEmpty &&
                  //         context.watch<NewDespatchController>().qrloading ==
                  //             false
                  //     ? Container(
                  //         child: Center(
                  //           child: Text(
                  //               "${context.read<NewDespatchController>().qrerror}"),
                  //         ),
                  //       )
                      : context.watch<NewDespatchController>().qrloading ==
                                  false &&
                              context
                                  .read<NewDespatchController>()
                                  .DesQRlist
                                  .isEmpty
                          ? Container(
                              child: Center(child: Text("No Data..!!")),
                            )
                          : ListView.builder(
                              itemCount: context
                                  .read<NewDespatchController>()
                                  .DesQRlist
                                  .length,
                              itemBuilder: (context, i) {
                                return Container(
                                  // color: Colors.amber,
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
                                         color: theme.primaryColor.withOpacity(0.07),
                                         borderRadius: BorderRadius.circular(8),
                                      ),
                                       padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.padingHeight(context) *
                                                0.01),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.2,
                                                  child: Text("Item Name",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
                                                ),
                                                Container(
                                                  child: Text(" : "),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  child: Text(
                                                      "${context.read<NewDespatchController>().DesQRlist[i].ItemName}",
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
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.015,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.2,
                                                  child: Text("Serial number",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
                                                ),
                                                Container(
                                                  child: Text(" : "),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  child: Text(
                                                      "${context.read<NewDespatchController>().DesQRlist[i].SerialBatch}",
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
                                          ),
                                         
                                         
                                          // SizedBox(
                                          //   height:
                                          //       Screens.padingHeight(context) *
                                          //           0.01,
                                          // ),
                                          // Container(
                                          //   child: Row(
                                          //     children: [
                                          //       Container(
                                          //         width:
                                          //             Screens.width(context) *
                                          //                 0.2,
                                          //         child: Text("Sub Catagory",
                                          //             style: theme
                                          //                 .textTheme.bodyText1!
                                          //                 .copyWith(
                                          //                     color:
                                          //                         Colors.black,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w300)),
                                          //       ),
                                          //       Container(
                                          //         child: Text(" : "),
                                          //       ),
                                          //       Container(
                                          //         width:
                                          //             Screens.width(context) *
                                          //                 0.6,
                                          //         child: Text(
                                          //             "${context.read<NewDespatchController>().DesQRlist[i].SubCategory}",
                                          //             style: theme
                                          //                 .textTheme.bodyText1!
                                          //                 .copyWith(
                                          //                     color: theme
                                          //                         .primaryColor,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w400)),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height:
                                          //       Screens.padingHeight(context) *
                                          //           0.02,
                                          // ),
                                          // Container(
                                          //   child: Row(
                                          //     children: [
                                          //       Container(
                                          //         width:
                                          //             Screens.width(context) *
                                          //                 0.2,
                                          //         child: Text("Brand",
                                          //             style: theme
                                          //                 .textTheme.bodyText1!
                                          //                 .copyWith(
                                          //                     color:
                                          //                         Colors.black,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w300)),
                                          //       ),
                                          //       Container(
                                          //         child: Text(" : "),
                                          //       ),
                                          //       Container(
                                          //         width:
                                          //             Screens.width(context) *
                                          //                 0.6,
                                          //         child: Text(
                                          //             "${context.read<NewDespatchController>().DesQRlist[i].Brand}",
                                          //             style: theme
                                          //                 .textTheme.bodyText1!
                                          //                 .copyWith(
                                          //                     color: theme
                                          //                         .primaryColor,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w400)),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.015,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.2,
                                                  child: Text("Pickslip code",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
                                                ),
                                                Container(
                                                  child: Text(" : "),
                                                ),
                                                Container(
                                                  // color: Colors.amber,
                                                  width:
                                                      Screens.width(context) *
                                                          0.55,
                                                  child: Text(
                                                      "${context.read<NewDespatchController>().DesQRlist[i].QRCode}",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)
                                                                      
                                                                      ),
                                                ),
                                                 Container(
                                                  // color: Colors.amber,
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  child: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        context.read<NewDespatchController>().DesQRlist.removeAt(i);
                                                      });

                                                    },
                                                    child: Icon(Icons.delete,color: Colors.red,))
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // padding: EdgeInsets.all(8),
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.06,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed:
                        context.read<NewDespatchController>().DesQRlist.isEmpty
                            ? () {}
                            : () {
                               context
                                    .read<NewDespatchController>()
                                    .clearpopup();
                                context
                                    .read<NewDespatchController>()
                                    .detailsentrybottom(context);
                              },
                    child: Text(
                      "Next",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
