import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../controller/BintoBinController/BintoBinController.dart';

class newscreen extends StatefulWidget {
  const newscreen({super.key});

  @override
  State<newscreen> createState() => _newscreenState();
}

class _newscreenState extends State<newscreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BintoBinController>().clearpopup();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bin Transfer"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Screens.padingHeight(context) * 0.02,
          ),
          Container(
            child: context.watch<BintoBinController>().serialloading == true
                ? Container(
                    height: Screens.padingHeight(context) * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
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
                            
                              child: TextFormField(
                                controller: context
                                    .read<BintoBinController>()
                                    .mycontroller[0],
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                            .read<BintoBinController>()
                                            .frombincode =
                                        context
                                            .read<BintoBinController>()
                                            .mycontroller[0]
                                            .text;
                                    context
                                        .read<BintoBinController>()
                                        .afterBinScanned(
                                            context
                                                .read<BintoBinController>()
                                                .frombincode,
                                            context);
                                  });
                                },
                                focusNode:
                                    context.read<BintoBinController>().focus1,
                                decoration: InputDecoration(
                                  labelText: "From Bin..!!",
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
                                  suffixIcon: ConstantValues.scanneruser == true
                                      ? Container(
                                          width: Screens.width(context) * 0.01)
                                      : IconButton(
                                          // iconSize:
                                          //     Screens.padingHeight(context) * 0.03,
                                          color: theme.primaryColor,
                                          onPressed:
                                              QRscannerState.frombin == true
                                                  ? () {}
                                                  : () {
                                                      setState(() {
                                                        QRscannerState.frombin =
                                                            true;
                                                      });

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  QRscanner())).then(
                                                          (value) {
                                                        if (context
                                                                .read<
                                                                    BintoBinController>()
                                                                .frombincode !=
                                                            '') {
                                                          context
                                                              .read<
                                                                  BintoBinController>()
                                                              .afterBinScanned(
                                                                  context
                                                                      .read<
                                                                          BintoBinController>()
                                                                      .frombincode,
                                                                  context);
                                                        }
                                                      });
                                                    },
                                          icon: Icon(
                                            Icons.qr_code_outlined,
                                            size:
                                                Screens.padingHeight(context) *
                                                    0.04,
                                          )),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        Screens.padingHeight(context) * 0.02,
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
                                controller: context
                                    .read<BintoBinController>()
                                    .mycontroller[1],
                                onTap: () {
                                  if (context
                                      .read<BintoBinController>()
                                      .mycontroller[0]
                                      .text
                                      .isEmpty) {
                                    context
                                        .read<BintoBinController>()
                                        .showtoastInw(
                                            "Enter From Bin First..!!");
                                    context
                                        .read<BintoBinController>()
                                        .focus2
                                        .unfocus();
                                  } else if (context
                                      .read<BintoBinController>()
                                      .mycontroller[0]
                                      .text
                                      .isNotEmpty) {
                                    context
                                        .read<BintoBinController>()
                                        .afterBinScanned(
                                            context
                                                .read<BintoBinController>()
                                                .mycontroller[0]
                                                .text,
                                            context);
                                  }
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                            .read<BintoBinController>()
                                            .binbarcode =
                                        context
                                            .read<BintoBinController>()
                                            .mycontroller[1]
                                            .text;
                                    context
                                        .read<BintoBinController>()
                                        .afterserialscanned(
                                            context
                                                .read<BintoBinController>()
                                                .binbarcode,
                                            context);
                                    // afterBinScanned(frombincode, context);
                                  });
                                },
                                focusNode:
                                    context.read<BintoBinController>().focus2,
                                decoration: InputDecoration(
                                  labelText: "Scan Barcode..!!",
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
                                  suffixIcon: ConstantValues.scanneruser == true
                                      ? Container(
                                          width: Screens.width(context) * 0.01)
                                      : IconButton(
                                          // iconSize:
                                          //     Screens.padingHeight(context) * 0.03,
                                          color: theme.primaryColor,
                                          onPressed: QRscannerState.binserial ==
                                                  true
                                              ? () {}
                                              : () {
                                                  if (context
                                                      .read<
                                                          BintoBinController>()
                                                      .mycontroller[0]
                                                      .text
                                                      .isEmpty) {
                                                    context
                                                        .read<
                                                            BintoBinController>()
                                                        .showtoastInw(
                                                            "Enter From Bin First..!!");
                                                    context
                                                        .read<
                                                            BintoBinController>()
                                                        .focus2
                                                        .unfocus();
                                                  } else if (context
                                                      .read<
                                                          BintoBinController>()
                                                      .mycontroller[0]
                                                      .text
                                                      .isNotEmpty) {
                                                    context
                                                        .read<
                                                            BintoBinController>()
                                                        .afterBinScanned22(
                                                            context
                                                                .read<
                                                                    BintoBinController>()
                                                                .mycontroller[0]
                                                                .text,
                                                            context);
                                                  } else {
                                                    setState(() {
                                                      QRscannerState.binserial =
                                                          true;
                                                    });

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                QRscanner())).then(
                                                        (value) {
                                                      if (context
                                                              .read<
                                                                  BintoBinController>()
                                                              .binbarcode !=
                                                          '') {
                                                        // setState(() {
                                                        //  serialloading == false;
                                                        // });
                                                        context
                                                            .read<
                                                                BintoBinController>()
                                                            .afterserialscanned(
                                                                context
                                                                    .read<
                                                                        BintoBinController>()
                                                                    .binbarcode,
                                                                context);

                                                        // afterBinScanned(
                                                        //     frombincode, context);
                                                      }
                                                    });
                                                  }
                                                },
                                          icon: Icon(
                                            Icons.qr_code_outlined,
                                            size:
                                                Screens.padingHeight(context) *
                                                    0.04,
                                          )),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        Screens.padingHeight(context) * 0.02,
                                    horizontal: 5,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            context
                                    .read<BintoBinController>()
                                    .serialdetaillist
                                    .isEmpty
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
                                                        color:
                                                            theme.primaryColor),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            Container(
                                              child: Text(
                                                '${context.read<BintoBinController>().serialdetaillist[0].ItemCode}',
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
                                                '${context.read<BintoBinController>().serialdetaillist[0].ItemName}',
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
                            context
                                    .read<BintoBinController>()
                                    .serialdetaillist
                                    .isEmpty
                                ? Container()
                                : SizedBox(
                                    // width: Screens.width(context) ,
                                    height:
                                        Screens.padingHeight(context) * 0.06,
                                    // decoration: BoxDecoration(
                                    //     color: Colors.grey[200],
                                    //     borderRadius: BorderRadius.circular(8),
                                    //     border: Border.all(color: Colors.black26)),
                                    child: TextField(
                                      controller: context
                                          .read<BintoBinController>()
                                          .mycontroller[2],
                                      focusNode: context
                                          .read<BintoBinController>()
                                          .focus3,
                                      onEditingComplete: () {
                                        context
                                                .read<BintoBinController>()
                                                .tobincode =
                                            context
                                                .read<BintoBinController>()
                                                .mycontroller[2]
                                                .text;
                                        context
                                            .read<BintoBinController>()
                                            .afterToBinScanned(
                                                context
                                                    .read<BintoBinController>()
                                                    .tobincode,
                                                context);
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
                                        suffixIcon:
                                            ConstantValues.scanneruser == true
                                                ? Container(
                                                    width: Screens.width(
                                                            context) *
                                                        0.01)
                                                : IconButton(
                                                    iconSize:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.04,
                                                    color: theme.primaryColor,
                                                    onPressed:
                                                        QRscannerState.tobin ==
                                                                true
                                                            ? () {}
                                                            : () {
                                                                setState(() {
                                                                  QRscannerState
                                                                          .tobin =
                                                                      true;
                                                                });

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                QRscanner())).then(
                                                                    (value) {
                                                                  if (context
                                                                          .read<
                                                                              BintoBinController>()
                                                                          .tobincode !=
                                                                      '') {
                                                                    setState(
                                                                        () {
                                                                      context.read<BintoBinController>().afterToBinScanned(
                                                                          context
                                                                              .read<BintoBinController>()
                                                                              .tobincode,
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
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              Screens.padingHeight(context) *
                                                  0.02,
                                          horizontal: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                            context
                                    .read<BintoBinController>()
                                    .serialdetaillist
                                    .isEmpty
                                ? Container()
                                : SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                            context
                                    .read<BintoBinController>()
                                    .serialdetaillist
                                    .isEmpty
                                ? Container()
                                : SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.06,
                                    // width: Screens.width(context) *0.9,
                                    // decoration: BoxDecoration(
                                    //     color: Colors.grey[200],
                                    //     borderRadius: BorderRadius.circular(8),
                                    //     border: Border.all(color: Colors.black26)),
                                    child: TextFormField(
                                      controller: context
                                          .read<BintoBinController>()
                                          .mycontroller[3],
                                      readOnly: context
                                                  .read<BintoBinController>()
                                                  .serialdetaillist[0]
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
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: Screens.padingHeight(
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
                        width: Screens.width(context) * 0.95,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                    // borderRadius: BorderRadius.only(
                                    //     bottomLeft: Radius.circular(8),
                                    //     bottomRight: Radius.circular(8))
                                    )),
                            onPressed: context
                                            .read<BintoBinController>()
                                            .mycontroller[1]
                                            .text ==
                                        '' ||
                                    context
                                            .read<BintoBinController>()
                                            .mycontroller[3]
                                            .text ==
                                        '' ||
                                    context
                                        .read<BintoBinController>()
                                        .serialdetaillist
                                        .isEmpty
                                ? () {}
                                : () {
                                    setState(() {
                                      context
                                          .read<BintoBinController>()
                                          .saveFinal(context);
                                    });
                                  },
                            child: context
                                        .watch<BintoBinController>()
                                        .finalloading ==
                                    true
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
        ],
      ),
    );
  }
}
