import 'dart:developer';

import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/controller/DelreturnController/DelreturnController.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class delreturn extends StatefulWidget {
  const delreturn({super.key});

  @override
  State<delreturn> createState() => _delreturnState();
}

class _delreturnState extends State<delreturn> {
  @override
  void initState(){
     WidgetsBinding.instance.addPostFrameCallback((timeStamp){
context.read<DelreturnController>().init();
     });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Text("Delivery Return",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            Expanded(
              child: Container(
                // color: Colors.amber,
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.06,
                        child: TextFormField(
                          controller:
                              context.read<DelreturnController>().mycontroller[0],
                          onEditingComplete: () {
                            setState(() {
                              context.read<DelreturnController>().Delscannedslip =
                                  context
                                      .read<DelreturnController>()
                                      .mycontroller[0]
                                      .text;
                              context.read<DelreturnController>().afterQRScanned(
                                  context
                                      .read<DelreturnController>()
                                      .Delscannedslip,
                                  context);
                            });
                          },
                          focusNode: context.read<DelreturnController>().focus1,
                          decoration: InputDecoration(
                            labelText: "Scan Pickslip..!!",
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
                                ? Container(width: Screens.width(context) * 0.01)
                                : IconButton(
                                    // iconSize:
                                    //     Screens.padingHeight(context) * 0.03,
                                    color: theme.primaryColor,
                                    onPressed: QRscannerState.delpickslip == true
                                        ? () {}
                                        : () {
                                            setState(() {
                                              QRscannerState.delpickslip = true;
                                            });
                  
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRscanner()))
                                                .then((value) {
                                              if (context
                                                      .read<DelreturnController>()
                                                      .Delscannedslip !=
                                                  '') {
                                                     context
                                                    .read<DelreturnController>()
                                                    .mycontroller[0].text=context
                                                      .read<DelreturnController>()
                                                      .Delscannedslip;
                                                context
                                                    .read<DelreturnController>()
                                                    .afterQRScanned(
                                                        context
                                                            .read<
                                                                DelreturnController>()
                                                            .Delscannedslip,
                                                        context);
                                              }
                                            });
                                          },
                                    icon: Icon(
                                      Icons.qr_code_outlined,
                                      size: Screens.padingHeight(context) * 0.04,
                                    )),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: Screens.padingHeight(context) * 0.02,
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
                        child: TextFormField(
                          controller:
                              context.read<DelreturnController>().mycontroller[1],
                          onTap: () {
                            if (context
                                .read<DelreturnController>()
                                .mycontroller[0]
                                .text
                                .isEmpty) {
                              context
                                  .read<DelreturnController>()
                                  .showtoastInw("Scan Pick Slip First..!!");
                              context
                                  .read<DelreturnController>()
                                  .focus2
                                  .unfocus();
                            } else if (context
                                .read<DelreturnController>()
                                .mycontroller[0]
                                .text
                                .isNotEmpty) {
                              context.read<DelreturnController>().afterQRScanned(
                                  context
                                      .read<DelreturnController>()
                                      .mycontroller[0]
                                      .text,
                                  context);
                            }
                          },
                          onEditingComplete: () {
                            setState(() {
                              context
                                      .read<DelreturnController>()
                                      .Delscannedbarcode =
                                  context
                                      .read<DelreturnController>()
                                      .mycontroller[1]
                                      .text;
                              context
                                  .read<DelreturnController>()
                                  .afterserialScanned(
                                      context
                                          .read<DelreturnController>()
                                          .Delscannedbarcode,
                                      context);
                            });
                          },
                          focusNode: context.read<DelreturnController>().focus2,
                          decoration: InputDecoration(
                            labelText: "Scan Barcode..!!",
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
                                ? Container(width: Screens.width(context) * 0.01)
                                : IconButton(
                                    // iconSize:
                                    //     Screens.padingHeight(context) * 0.03,
                                    color: theme.primaryColor,
                                    onPressed: QRscannerState.delbarcode == true
                                        ? () {}
                                        : () {
                                            setState(() {
                                              QRscannerState.delbarcode = true;
                                            });
                  
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRscanner()))
                                                .then((value) {
                                              if (context
                                                      .read<DelreturnController>()
                                                      .Delscannedbarcode !=
                                                  '') {
                                                    context
                                                    .read<DelreturnController>()
                                                    .mycontroller[1].text=context
                                                      .read<DelreturnController>()
                                                      .Delscannedbarcode;
                                                context
                                                    .read<DelreturnController>()
                                                    .afterserialScanned(
                                                        context
                                                            .read<
                                                                DelreturnController>()
                                                            .Delscannedbarcode,
                                                        context);
                                              }
                                            });
                                          },
                                    icon: Icon(
                                      Icons.qr_code_outlined,
                                      size: Screens.padingHeight(context) * 0.04,
                                    )),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: Screens.padingHeight(context) * 0.02,
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                    (context.read<DelreturnController>().mycontroller[1].text.isEmpty|| context.watch<DelreturnController>().iscorrect==false)  ||  context.read<DelreturnController>().DesQRlistsave.isEmpty
                          ? Container()
                          : Container(
                              width: Screens.width(context),
                              padding: EdgeInsets.only(
                                  //            left: Screens.width(context) * 0.02,
                                  // right: Screens.width(context) * 0.02,
                                  ),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   child: Text(
                                      //     "Item Details :",
                                      //     style: theme
                                      //         .textTheme.bodyMedium!
                                      //         .copyWith(
                                      //             color:
                                      //                 theme.primaryColor),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: Screens.padingHeight(
                                      //           context) *
                                      //       0.01,
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text("Customer Name",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                          Container(
                                            child: Text("Ordernum",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w300)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.padingHeight(context) * 0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // color: Colors.amber,
                                            width: Screens.width(context) * 0.7,
                                            child: Text(
                                                "${context.read<DelreturnController>().DesQRlistsave[0].CustomerName}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                          Container(
                                            child: Text(
                                                "${context.read<DelreturnController>().DesQRlistsave[0].OrderNum}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.padingHeight(context) * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text("Item Name",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                          Container(
                                            child: Text("Area",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w300)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.padingHeight(context) * 0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // color: Colors.amber,
                                            width: Screens.width(context) * 0.7,
                                            child: Text(
                                                "${context.read<DelreturnController>().DesQRlistsave[0].ItemName}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                          Container(
                                            child: Text(
                                                "${context.read<DelreturnController>().DesQRlistsave[0].OrderNum}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.padingHeight(context) * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text("Item Code",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                          Container(
                                            child: Text("QR code",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w300)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.padingHeight(context) * 0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // color: Colors.amber,
                                            width: Screens.width(context) * 0.7,
                                            child: Text(
                                                "${context.read<DelreturnController>().DesQRlistsave[0].ItemCode}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                          Container(
                                            child: Text(
                                                "${context.read<DelreturnController>().DesQRlistsave[0].QRCode}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                   ( context.read<DelreturnController>().mycontroller[1].text.isEmpty|| context.watch<DelreturnController>().iscorrect==false)||  context.read<DelreturnController>().DesQRlistsave.isEmpty
                          ? Container():  Container(
                        width: Screens.width(context),
                        // height: Screens.,
                        padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                            border: Border.all(color: theme.primaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton(
                          hint: Text(
                            "Reason",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          ),
                        underline: SizedBox.shrink(),
                          value: context
                              .read<DelreturnController>()
                              .valuecancelStatus,
                          //dropdownColor:Colors.green,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          isExpanded: true,
                          onChanged: (val) {
                            setState(() {
                              context
                                  .read<DelreturnController>()
                                  .valuecancelStatus = val;
                            });
                          },
                          items: <String>['A', 'B', 'C', 'D'].map((e) {
                            return DropdownMenuItem(
                              
                                value: "${e}",
                                child: Container(
                                    
                                    child: Text("${e}")));
                          }).toList(),
                        ),
                      ),
                  SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
           (context.read<DelreturnController>().mycontroller[1].text.isEmpty|| context.watch<DelreturnController>().iscorrect==false) ||   context.read<DelreturnController>().DesQRlistsave.isEmpty
                          ? Container():       Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                       border: Border.all(color: theme.primaryColor,
                       
                       ),
                    ),
                    child: TextFormField(
                      controller: context.read<DelreturnController>().mycontroller[4],
                      minLines: 3,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: "Notes",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder:  InputBorder.none,
                      ),
                    ),
                  )
                                 ,SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
              (context.read<DelreturnController>().mycontroller[1].text.isEmpty|| context.watch<DelreturnController>().iscorrect==false) ||  context.read<DelreturnController>().DesQRlistsave.isEmpty
                          ? Container():    Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Screens.padingHeight(context)*0.01,
                      horizontal: Screens.width(context)*0.01
                    ),
                    width: Screens.width(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.primaryColor
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Conditions :",style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),),
                      SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Center(
                                    child: Wrap(
                                        spacing: 5.0, // width
                                        runSpacing: 10.0, // height
                                        children: listContainerstags(
                                          theme,
                                        )),
                                  ),
                    ],),
                  ),
                  
                   SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
          (context.read<DelreturnController>().mycontroller[1].text.isEmpty|| context.watch<DelreturnController>().iscorrect==false) ||   context.read<DelreturnController>().DesQRlistsave.isEmpty
                          ? Container():        Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border:
                                              Border.all(color:theme.primaryColor)),
                                      padding: EdgeInsets.only(
                                          top: Screens.padingHeight(context) * 0.01,
                                          left:
                                              Screens.padingHeight(context) * 0.01,
                                          bottom:
                                              Screens.padingHeight(context) * 0.015,
                                          right:
                                              Screens.padingHeight(context) * 0.01),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Attachment',
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          color: context
                                                                      .read<
                                                                          DelreturnController>()
                                                                      .fileValidation ==
                                                                  true
                                                              ? Colors.red
                                                              : Colors.grey)),
                                              Row(
                                                children: [
                                                  Container(
                                                      // alignment: Alignment.center,
                                                      height: Screens.padingHeight(
                                                              context) *
                                                          0.06,
                                                      width:
                                                          Screens.width(context) *
                                                              0.13,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  6),
                                                          color: context
                                                                      .read<
                                                                          DelreturnController>()
                                                                      .fileValidation ==
                                                                  true
                                                              ? Colors.red
                                                              : theme.primaryColor
                                                          // shape: BoxShape
                                                          //     .circle
                                                          ),
                                                      child: Center(
                                                        child: IconButton(
                                                            onPressed: () {
                                                                    setState(() {
                                                                      log("files length" +
                                                                          context
                                                                              .read<
                                                                                  DelreturnController>()
                                                                              .files
                                                                              .length
                                                                              .toString());
                                                                      // showtoast();
                                                                     
                                                                        setState(
                                                                            () {
                                                                          context
                                                                              .read<
                                                                                  DelreturnController>()
                                                                              .imagetoBinary(
                                                                                  ImageSource.camera);
                                                                          context
                                                                              .read<
                                                                                  DelreturnController>()
                                                                              .fileValidation = false;
                                                                        });
                                                                     
                                                                    });
                                                                  },
                                                            icon: Icon(
                                                              Icons.photo_camera,
                                                              color: Colors.white,
                                                            )),
                                                      )),
                                                  SizedBox(
                                                    width: Screens.width(context) *
                                                        0.02,
                                                  ),
                            
                                                  //old
                                                  Container(
                                                      // alignment: Alignment.center,
                                                      height: Screens.padingHeight(
                                                              context) *
                                                          0.06,
                                                      width:
                                                          Screens.width(context) *
                                                              0.13,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  6),
                                                          color: context
                                                                      .read<
                                                                          DelreturnController>()
                                                                      .fileValidation ==
                                                                  true
                                                              ? Colors.red
                                                              : theme.primaryColor
                                                          // shape: BoxShape
                                                          //     .circle
                                                          ),
                                                      child: Center(
                                                        child: IconButton(
                                                            onPressed:  () {
                                                                    setState(() {
                                                                      log("files222 length" + context
                                                                              .read<
                                                                                  DelreturnController>()
                                                                              .files.length.toString());
                                                                      // showtoast();
                                                                    
                                                                        setState(
                                                                            () {
                                                                          context
                                                                              .read<
                                                                                  DelreturnController>()
                                                                              .selectattachment();
                            
                                                                          context
                                                                              .read<
                                                                                  DelreturnController>()
                                                                              .fileValidation = false;
                                                                        });
                                                                      
                                                                    });
                                                                  },
                                                            icon: Icon(
                                                              Icons.attach_file,
                                                              color: Colors.white,
                                                            )),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                       
                                      context.watch<DelreturnController>().files == null
                                        ?Container(
                                            height:
                                                Screens.padingHeight(context) * 0.3,
                                            padding: EdgeInsets.only(
                                              top: Screens.padingHeight(context) *
                                                  0.001,
                                              right: Screens.padingHeight(context) *
                                                  0.015,
                                              left: Screens.padingHeight(context) *
                                                  0.015,
                                              bottom:
                                                  Screens.padingHeight(context) *
                                                      0.015,
                                            ),
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "No Files Selected",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: context
                                                                          .read<
                                                                              DelreturnController>()
                                                                          .fileValidation ==
                                                                      true
                                                                  ? Colors.red
                                                                  : Colors.green),
                                                    )),
                                                    Icon(
                                                      Icons.file_present_outlined,
                                                      color: theme.primaryColor,
                                                    )
                                                  ],
                                                ))):
                                                Container(
                                                    height: context
                                                        .read<DelreturnController>()
                                                        .files
                                                        .length ==
                                                    0
                                                ? Screens.padingHeight(context) *
                                                    0.0
                                                : Screens.padingHeight(context) *
                                                    0.2,
                                                  
                                            padding: EdgeInsets.only(
                                              top: Screens.padingHeight(context) *
                                                  0.001,
                                              right: Screens.padingHeight(context) *
                                                  0.005,
                                              left: Screens.padingHeight(context) *
                                                  0.005,
                                              bottom:
                                                  Screens.padingHeight(context) *
                                                      0.015,
                                            ),
                                            child: ListView.builder(
                                               itemCount: context
                                                    .read<DelreturnController>()
                                                    .files
                                                    .length,
                                              itemBuilder: (context,i){
                                                return Container(
                                                        child: Column(children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                width:
                                                                    Screens.width(
                                                                            context) *
                                                                        0.09,
                                                                height: Screens
                                                                        .padingHeight(
                                                                            context) *
                                                                    0.06,
                                                                child: Center(
                                                                    child: Image.asset(
                                                                        "Asset/img.jpg"))),
                                                            Container(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(),
                                                                width: Screens.width(
                                                                        context) *
                                                                    0.6,
                                                                // height: Screens.padingHeight(context) * 0.06,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  context
                                                                      .watch<
                                                                          DelreturnController>()
                                                                      .files[i]
                                                                      .path
                                                                      .split('/')
                                                                      .last,
                                                                  // overflow: TextOverflow.ellipsis,
                                                                )),
                                                            Container(
                                                                width:
                                                                    Screens.width(
                                                                            context) *
                                                                        0.1,
                                                                height: Screens
                                                                        .padingHeight(
                                                                            context) *
                                                                    0.06,
                                                                child: IconButton(
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        context
                                                                            .read<
                                                                                DelreturnController>()
                                                                            .files
                                                                            .removeAt(
                                                                                i);
                                                                                context
                                                                            .read<
                                                                                DelreturnController>()
                                                                            .filedata
                                                                            .removeAt(
                                                                                i);
                                                                      });
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .cancel_rounded,
                                                                      color: Colors
                                                                          .grey,
                                                                    )))
                                                          ])
                                                    ])
                                                        // )
                                                        );
                                              }
                                              ),
                                                )
                                        ],
                                      ),
                                    ),
                                    
                   SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
              (context.read<DelreturnController>().mycontroller[1].text.isEmpty|| context.watch<DelreturnController>().iscorrect==false) ||    context.read<DelreturnController>().DesQRlistsave.isEmpty
                          ? Container():    Row(children: [
                    Container(
                    child:   Text("Reschedule",style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor,fontSize: 16,fontWeight: FontWeight.w400),)
                  
                    ),
                    Container(
                      child: Checkbox(
                        value:context.read<DelreturnController>(). checkvalue, 
                        onChanged: (val){
                          setState(() {
                            context.read<DelreturnController>(). checkvalue = !context.read<DelreturnController>(). checkvalue;
                          });
                        }
                        ),
                    ),
                  ],),
                          context.read<DelreturnController>(). checkvalue ==false ?Container():        Container(
                                                      // width:
                                                      //     Screens.width(context) *
                                                      //         0.78,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(
                                                                  color: theme.primaryColor
                                                                )
                                                              ),
                                                      child: TextFormField(
                                                        controller: context
                                                            .read<
                                                                DelreturnController>()
                                                            .mycontroller[3],
                                                        readOnly: true,
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  DelreturnController>()
                                                              .showexpDate(
                                                                  context);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon: IconButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        DelreturnController>()
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
                                                                  0.02,
                                                              horizontal:
                                                                  Screens.width(
                                                                          context) *
                                                                      0.02),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                 
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context)*0.06,
                  child: ElevatedButton(
                onPressed: () {},
                child: Text("Save"),
              )),
            ),
          ],
        ),
      ),
    );
  }
  List<Widget> listContainerstags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<DelreturnController>().filterDisplist.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
         context.read<DelreturnController>().selectCustomerTag(
              context
                  .read<DelreturnController>()
                  .filterDisplist[index]
                  .DispListVal
                  .toString(),
              context
                  .read<DelreturnController>()
                  .filterDisplist[index]
                  .DispID!.toString(),
              );
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          alignment: Alignment.center,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color:  context.watch<DelreturnController>().Dispname ==
                      context.watch<DelreturnController>().filterDisplist[index]
                          .DispListVal
                          .toString()
                  ? theme.primaryColor //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
              context.watch<DelreturnController>().filterDisplist[index]
                  .DispListVal
                  .toString(),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color:
                    context.watch<DelreturnController>().Dispname ==
                            context.watch<DelreturnController>().filterDisplist[index]
                                .DispListVal
                                .toString()
                        ?Colors.white //,Colors.white
                        : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}
