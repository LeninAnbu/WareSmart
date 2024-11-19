

import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/pickupcontroller/Pickupcontroller.dart';
import 'package:WareSmart/widgets/mobilescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class detailspickup extends StatefulWidget {
  const detailspickup({super.key});

  @override
  State<detailspickup> createState() => _detailspickupState();
}

class _detailspickupState extends State<detailspickup> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   context.read<PickupController>().disableKeyBoard(context);
    });
  }
   DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.toNamed(ConstantRoutes.pickupmain);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Screens.padingHeight(context)*0.02,
              horizontal: Screens.padingHeight(context)*0.02,
              
            ),
            decoration: BoxDecoration(
              color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
            ),
            height: Screens.padingHeight(context),
            width: Screens.width(context),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<PickupController>().formkey[0],
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                Container(
                                  //  padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text('Pick Slip QR',
                                            style:
                                                TextStyles.headline(context)),
                                      ),
                                       Container(
                                        //  color: Colors.green,
                                        width: Screens.width(context) * 0.05,
                                        child: Text(':',
                                            style:
                                                TextStyles.headline(context)),
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        width: Screens.width(context) * 0.44,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].QRCode}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                 Container(
                                  // padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text(
                                          'Brand',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.green,
                                        width: Screens.width(context) * 0.05,
                                        child: Text(
                                          ':',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        width: Screens.width(context) * 0.44,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].Brand}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
    SizedBox(
                                  height: Screens.padingHeight(context)  * 0.02,
                                ),
                                 Container(
                                  //  padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text(
                                          'SubCategory',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.green,
                                        width: Screens.width(context) * 0.05,
                                        child: Text(
                                          ':',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        width: Screens.width(context) * 0.44,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].SubCategory}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                Container(
                                  //padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text(
                                          'Item Code',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.green,
                                        width: Screens.width(context) * 0.05,
                                        child: Text(
                                          ':',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        width: Screens.width(context) * 0.44,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].ItemCode}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                Container(
                                  //  padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text(
                                          'Item Name',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.green,
                                        width: Screens.width(context) * 0.05,
                                        child: Text(
                                          ':',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        width: Screens.width(context) * 0.44,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].ItemName}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
    
                                SizedBox(
                                  height: Screens.width(context) * 0.02,
                                ),
                                Container(
                                  //  padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text(
                                          'Bin',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.green,
                                        width: Screens.width(context) * 0.05,
                                        child: Text(
                                          ':',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        width: Screens.width(context) * 0.44,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].BinCode}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                Container(
                                  //  padding: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        //  color: Colors.red,
                                        width: Screens.width(context) * 0.35,
                                        child: Text(
                                          'Serial Number',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.green,
                                        // width: Screens.width(context) * 0.,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.blue,
                                        width: Screens.width(context) * 0.50,
                                        child: Text(
                                          '${context.read<PickupController>().pickupdetailslist[0].Pref_BatchSerial}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Screens.width(context) * 0.05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                 Container(
                                  width: Screens.width(context),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(05),
                                      border: Border.all(color: Colors.grey)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.7,
                                          child: TextFormField(
                                            // autofocus: true,
                                            focusNode: context.read<PickupController>().focus1 ,
                                            controller: context.read<PickupController>().mycontroller[1],
                                           
                                            // validator: (value) {
                                            //   if (value!.isEmpty &&
                                            //     context.read<PickupController>().  pickupdetailslist[0]
                                            //               .serialnumber1 !=
                                            //           null) {
                                            //     return "Required *";
                                            //   }
    
                                            //   return null;
                                            // },
                                            onEditingComplete: (){
                                              setState(() {
                                                context.read<PickupController>().  SerialscannedCode =context.read<PickupController>().mycontroller[1].text;
                                               context.read<PickupController>(). checkserialNum(context);
                                              });
                                              
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Serial code",
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              border: InputBorder.none,
                                            ),
                                            cursorColor: Colors.blue,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                                 
                                                  QRscannerState
                                                          .outwarserial1 =
                                                      true;
                                                  Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  QRscanner()))
                                                      .then((value) {
                                                    setState(() {});
                                                    if (context.read<PickupController>().  SerialscannedCode != '') {
                                                    context.read<PickupController>(). checkserialNum(context);
                                                    
                                                    }
                                                  });
                                                },
                                          child: Container(
                                            // color: Colors.lightGreenAccent,
                                            child: Icon(
                                              Icons.qr_code_outlined,
                                              color:  theme.primaryColor,
                                              size: Screens.padingHeight(context) * 0.06,
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                                 SizedBox(
                                  height: Screens.padingHeight(context) * 0.02,
                                ),
                                Center(
                                  child: SizedBox(
                                    height: Screens.padingHeight(context) * 0.07,
                                    width: Screens.width(context) * 0.6,
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
                                      onPressed: context.read<PickupController>().  SerialscannedCode!.isEmpty||
                                        
                                                  context.read<PickupController>().  mycontroller[1].text.isEmpty
                                              ? null
                                              : () {
                                                context.read<PickupController>().  Postfinalapi(context.read<PickupController>().pickupdetailslist[0].QRCode,context);
                                                },
                                      child:context.watch<PickupController>(). finalloading == false
                                          ? Text(
                                              'Allocate Quantity',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: Screens.width(context) * 0.04),
                                            )
                                          : SpinKitThreeBounce(
                                              size: Screens.padingHeight(context) * 0.05,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                ),
                                //Third
    
                ],)
                ),
            ),
          ),
          Visibility(
                          visible:context.watch<PickupController>(). checkserial,
                          child: Container(
                            width: Screens.width(context),
                            height: Screens.padingHeight(context),
                            color: Colors.white54,
                            child: Center(
                              child: SpinKitThreeBounce(
                                size: Screens.width(context) * 0.1,
                                color: Colors.blue,
                              ),
                            ),
                          ))
        ],),
      )
      
    
    );
  }
}