
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/controller/DespatchController/Despatchcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class despatch extends StatefulWidget {
  const despatch({super.key});

  @override
  State<despatch> createState() => _despatchState();
}

class _despatchState extends State<despatch> {
  @override
  void initState(){
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      context.read<DespatchController>().init();

     });
  }
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
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
                        child: Text("Despatch",
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
              horizontal: Screens.width(context)*0.02,
              
            ),
             child: Column(
               children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: IconButton(
                        onPressed: (){
                          Get.toNamed(ConstantRoutes.newdespatch);

                        },
                        icon: Icon(Icons.add,size: 30,)),
                    )
                  ],
                 ),
                //  SizedBox(
                //   height: Screens.padingHeight(context)*0.005,
                //  ),
               ],
             ),
           ),
           Expanded(
            child:context.watch<DespatchController>().iserror == '' &&
                      context.watch<DespatchController>().isloading ==
                          true &&
                      context.read<DespatchController>().openlist.isEmpty
                  ? Container(
                      child: Center(
                        child: SpinKitThreeBounce(
                          size: Screens.width(context) * 0.1,
                          color: theme.primaryColor,
                        ),
                      ),
                    )
                  : context.read<DespatchController>().iserror.isNotEmpty &&
                          context.watch<DespatchController>().isloading ==
                              false
                      ? Container(
                          child: Center(
                            child: Text(
                                "${context.read<DespatchController>().iserror}"),
                          ),
                        )
                      : context.watch<DespatchController>().isloading ==
                                  false &&
                              context
                                  .read<DespatchController>()
                                  .openlist
                                  .isEmpty
                          ? Container(
                              child: Center(child: Text("No Data..!!")),
                            )
                          :
             ListView.builder(
              itemCount: context.read<DespatchController>().openlist.length,
              itemBuilder: (context,i){
                return Container(
                  padding: EdgeInsets.only(
                    
                    // top: Screens.padingHeight(context)*0.0,
                    left: Screens.width(context)*0.02,
                    right: Screens.width(context)*0.02,
                    // bottom: Screens.padingHeight(context)*0.01
                  ),
                  // color: Colors.amber,
                  
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context)*0.02,
                        vertical: Screens.padingHeight(context)*0.01
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child:
                            Row(children: [
                              Container(child: Text("Despatch No",
                                 style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)
                                ),),
                                 Container(
                                  child: Text(" : "),
                                ),
                                Container(
                                  child: Text("#${context.read<DespatchController>().openlist[i].DocNumber}",
                                  style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: theme.primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                                  ),
                                ),

                            ],)
                            //  Text("Despatch No : #${context.read<DespatchController>().openlist[i].Despatchno}",
                            // style: theme.textTheme
                            //                                 .bodyText1!
                            //                                 .copyWith(
                            //                                     color: Colors
                            //                                         .black,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .normal)
                            // ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context)*0.01,
                          ),
                          Container(
                            child:Row(children: [
                               Container(child: Text("Date/Time",
                                 style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color:  Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)
                                ),),
                                 Container(
                                  child: Text(" : "),
                                ),
                                Container(
                                  child: Text("${context.read<DespatchController>().config.alignmeetingdate333(context.read<DespatchController>().openlist[i].DocDate.toString()) }",
                                  style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: theme.primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                                  ),
                                ),

                            ],) 
                            
                            // Text("Date/Time : ${context.read<DespatchController>().openlist[i].DateTime}",
                            // style: theme.textTheme
                            //                                 .bodyText1!
                            //                                 .copyWith(
                            //                                     color: Colors
                            //                                         .black,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .normal)
                            // ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context)*0.01,
                          ),
                          Container(
                            child:Row(
                              children: [
                                Container(child: Text("No.of items",
                                 style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)
                                ),),
                                Container(
                                  child: Text(" : "),
                                ),
                                Container(
                                  child: Text("${context.read<DespatchController>().openlist[i].Total_Items}",
                                  style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: theme.primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                                  ),
                                ),
                              ],
                            ),
                            
                            //  Text("No.of items : ${context.read<DespatchController>().openlist[i].noofitems}",
                            // style: theme.textTheme
                            //                                 .bodyText1!
                            //                                 .copyWith(
                            //                                     color: Colors
                            //                                         .black,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .normal)
                            // ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context)*0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                            child: Text("Driver Name",
                            style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)
                            ),
                          ),
                          Container(
                            child: Text("Vehicle No",
                            style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)
                            ),
                          ),
                          ],),
                          SizedBox(
                            height: Screens.padingHeight(context)*0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                            child: Text("${context.read<DespatchController>().openlist[i].DriverName}",
                            style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: theme.primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                            ),
                          ),
                          Container(
                            child: Text("${context.read<DespatchController>().openlist[i].Vehno}",
                            style: theme.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: theme.primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                            ),
                          ),
                          ],)


                      ],),
                    ),
                  ),
                );

              }
              )
            )
          ],
        ),
      ),
    );
  }
}