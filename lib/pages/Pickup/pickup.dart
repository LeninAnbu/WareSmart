
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/pickupcontroller/Pickupcontroller.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class pickup extends StatefulWidget {
  const pickup({super.key});

  @override
  State<pickup> createState() => _pickupState();
}

class _pickupState extends State<pickup> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PickupController>().init();
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
    final theme=Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
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
                                  Text("User     : ${ConstantValues.Usercode} / ${ConstantValues.Whsecode}",
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
                                            shape: BoxShape.circle,
                                            color: Colors.green),
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
                                            shape: BoxShape.circle,
                                            color: Colors.red),
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
                          child: Text("Pickup",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ), 
                            ],
                          ),
                        ),
                       context.watch<PickupController>().  loading == false
                ? Container(
                  alignment: Alignment.center,
                  width: Screens.width(context) ,
                  height: Screens.padingHeight(context) * 0.8,
                  padding: EdgeInsets.all(Screens.padingHeight(context) * 0.07),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                      
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Scan - QR",
                        style: TextStyles.headline(context),
                      ),
                      Container(
                        width: Screens.width(context) * 0.82,
                        color: Colors.grey[200],
                        child: TextFormField(
                          autofocus: true,
                          
                          controller: context.read<PickupController>().mycontroller[0],
                          onEditingComplete: () {
                            context.read<PickupController>(). scannedCode =  context.read<PickupController>().mycontroller[0].text;
                            if (context.read<PickupController>(). scannedCode != '') {
                            context.read<PickupController>().  callapiscan(context);
                            }
                           
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.4,
                        width: Screens.width(context) ,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                           setState(() {
                            QRscannerState.outwardMain = true; 
                           });
                            
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => QRscanner()))
                                .then((value) {
                              setState(() {});
                              if (context.read<PickupController>(). scannedCode != '') {
                              context.read<PickupController>().  callapiscan(context);
                              }
                            });
                          },
                          child: Icon(Icons.qr_code_scanner_rounded,
                              size: Screens.width(context) * 0.5),
                        ),
                      ),
                      Text(
                        "Click the icon to scan",
                        style: TextStyles.headline(context),
                      ),
                    ],
                  ),
                )
                : Container(
                  height: Screens.padingHeight(context)*0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
          ],
          ),
        ),
      ),
    );
  }
}