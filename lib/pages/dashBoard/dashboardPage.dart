import 'package:WareSmart/pages/BinContent/bincontent.dart';
import 'package:WareSmart/pages/BintoBin/bintobin.dart';
import 'package:WareSmart/pages/DelReturn/delreturn.dart';
import 'package:WareSmart/pages/Despatch/despatch.dart';
import 'package:WareSmart/pages/ItemSearch/itemsearch.dart';
import 'package:WareSmart/pages/Pack/pack.dart';
import 'package:WareSmart/pages/Pickup/detailspage.dart';
import 'package:WareSmart/pages/Pickup/pickup.dart';
import 'package:WareSmart/pages/Putaway/putaway.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/controller/dashboardcontroller/dashboardcontroller.dart';
import 'package:WareSmart/pages/dashBoard/widgets/customContainer.dart';
import 'package:WareSmart/widgets/colorpalate.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
   @override
   void initState(){
     super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp){
context.read<dashBoardcontroller>().init();
     });
   }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return ChangeNotifierProvider<dashBoardcontroller>(
    //   create: (context) => dashBoardcontroller(),
    //   builder: (context, child) {
    //     return Consumer<dashBoardcontroller>(
    //       builder: (BuildContext context, dashCon, child) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              // appBar: AppBar(
              //   automaticallyImplyLeading : false,
                
              // ),
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.01,
                          vertical: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Container(
                            // color: Colors.amber,
                             height: Screens.padingHeight(context) * 0.04,
                             alignment: Alignment.centerRight,
                            //  width: Screens.width(context)*0.1,
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.centerRight,
                              onPressed: (){
                              // context.read<dashBoardcontroller>().playsound("scan_serial_wrong");
context.read<dashBoardcontroller>().showdialogmenu(context);
                            }, icon: Icon(Icons.settings,size: 20,color: Colors.white,)
                            ),
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
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                      context.read<dashBoardcontroller>().   copyDatabaseToExternalStorage(context);
                                     
                                      });
                                    },
                                    child: Text("Online",
                                        style:
                                            theme.textTheme.bodyText1!.copyWith(
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.02,
                                  ),
                               ConstantValues.networkonline ==false?   Container(
                                    width: Screens.width(context) * 0.04,
                                    height:
                                        Screens.padingHeight(context) * 0.04,
                                    decoration :BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green)
                                  ):Container(
                                    width: Screens.width(context) * 0.04,
                                    height:
                                        Screens.padingHeight(context) * 0.04,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red)
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
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

                                  // Row(
                                  //   children: [
                                      Padding(
                                         padding: EdgeInsets.only(
                                          right: Screens.width(context)*0.02
                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            context.read<dashBoardcontroller>().logout();
                                          },
                                          child: Container(
                                           
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.white
                                                )
                                              )
                                            ),
                                            child: Text("Logout",style: theme.textTheme.bodyText1!.copyWith(
                                              color: Colors.white,
                                              fontSize: 16
                                            ),),
                                          ),
                                        ),
                                      ),
                                  // Container(
                                  //   child: Icon(Icons.logout,color: Colors.white,),
                                  // ),
                                  //   ],
                                  // ),
                              // Row(
                              //   children: [
                              //     Text("Scanner ",
                              //         style:
                              //             theme.textTheme.bodyText1!.copyWith(
                              //           color: Colors.white,
                              //         )),
                              //     SizedBox(
                              //       width: Screens.width(context) * 0.02,
                              //     ),
                              //   ConstantValues.scanneruser == true
                              // ?   Container(
                              //       width: Screens.width(context) * 0.04,
                              //       height:
                              //           Screens.padingHeight(context) * 0.04,
                              //       decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: Colors.green)): Container(
                              //       width: Screens.width(context) * 0.04,
                              //       height:
                              //           Screens.padingHeight(context) * 0.04,
                              //       decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: Colors.red),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: Screens.width(context) * 0.03,
                          vertical: Screens.padingHeight(context) * 0.02
                          ),
                      color: theme.primaryColor.withOpacity(0.01),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: Screens.padingHeight(context) * 0.02,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            
                            children: [
                              customcontainer(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.inwardpage);
                                },
                                imageurl: "Asset/inward2.png",
                                name: "Inward",
                              ),
                             
                              customcontainer(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.putawaypage);
                                },
                                imageurl: "Asset/putaway2.png",
                                name: "Putaway",
                              ),
                              customcontainer(
                                theme: theme,
                                callback: () {
                                    Get.toNamed(ConstantRoutes.pickupmain);
                                    },
                                imageurl: "Asset/pickup2.png",
                                name: "Pickup",
                              ),
                            
                            ],
                          ),
                           SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
//2nd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customcontainer(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.packmain);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>pack()));
                                },
                                imageurl: "Asset/pack2.png",
                                name: "Pack",
                              ),
                              customcontainer(
                                theme: theme,
                                callback: () {
                                   Get.toNamed(ConstantRoutes.bintobinmain);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>bintobin()));
                                },
                                imageurl: "Asset/bintobin2.png",
                                name: "Bin-to-Bin",
                              ),
                              customcontainer(
                                theme: theme,
                                callback: () {
                                   Get.toNamed(ConstantRoutes.delreturnmain);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>delreturn()));
                                },
                                imageurl: "Asset/delret2.png",
                                name: "Del. Return",
                              ),
                            
                            ],
                          ),
                           SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          //3rd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customcontainer(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.despatchmain);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>despatch()));
                                },
                                imageurl: "Asset/delivery2.png",
                                name: "Despatch",
                              ),
                              customcontainer(
                                theme: theme,
                                callback: () {
                                   Get.toNamed(ConstantRoutes.bincontentmain);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>BinContent()));
                                },
                                imageurl: "Asset/bincontent2.png",
                                name: "Bin Content",
                              ),
                              customcontainer(
                                theme: theme,
                                callback: () {
                                   Get.toNamed(ConstantRoutes.itemsearchmain);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemSearch()));
                                },
                                imageurl: "Asset/itemsearch2.png",
                                name: "Item Search",
                              ),
                             
                            ],
                          ),

                          // SizedBox(
                          //   height: Screens.padingHeight(context) * 0.02,
                          // ),
                        ],
                      ),
                    ),

                    //  Divider(color: Colors.black,),
                    //  Container(

                    //  child:
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(

                          // color: Colors.amber,
                          border: Border(
                              top:
                                  BorderSide(color: Colors.black, width: 1.0))),
                      // child:context.watch<dashBoardcontroller>().loading==true?Center(
                      //     child: CircularProgressIndicator(),
                      //   ):
                        
                      //     ListView.builder(
                      //     itemCount: context.watch<dashBoardcontroller>().dummyshow.length,
                      //     itemBuilder: (context, i) {
                      //       return Container(
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: Screens.width(context) * 0.02,
                      //             vertical:
                      //                 Screens.padingHeight(context) * 0.001
                      //                 ),
                      //         // color: Colors.blue,
                      //         child: Card(
                      //           elevation: 1,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8)
                      //           ),
                      //           child: Container(
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: Screens.width(context) * 0.02,
                      //                 vertical:
                      //                     Screens.padingHeight(context) * 0.02
                      //                     ),
                      //             decoration: BoxDecoration(
                      //                 color: theme.primaryColor.withOpacity(0.1),
                      //                 border: Border.all(color: Colors.black45),
                      //                 borderRadius: BorderRadius.circular(8)),
                      //             child: Column(
                      //               children: [
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Container(
                      //                       width: Screens.width(context) * 0.35,
                      //                       decoration: const BoxDecoration(
                      //                           // color: colorpalette.customColor2,?
                      //                           border: Border(
                      //                         top: BorderSide.none,
                      //                         left: BorderSide.none,
                      //                         right: BorderSide.none,
                      //                         bottom: BorderSide.none,
                      //                       )),
                      //                       child: Text(
                      //                           "Purchase #${context.watch<dashBoardcontroller>()..dummyshow[i].itemcode}",
                      //                           style: theme.textTheme.bodyText1!
                      //                               .copyWith(
                      //                                   color: Colors.black)),
                      //                     ),
                      //                     // Container(
                      //                     //   decoration: const BoxDecoration(
                      //                     //       // color: colorpalette.customColor2,?
                      //                     //       border: Border(
                      //                     //     top: BorderSide.none,
                      //                     //     left: BorderSide.none,
                      //                     //     right: BorderSide.none,
                      //                     //     bottom: BorderSide.none,
                      //                     //   )),
                      //                     //   child: Text("|",
                      //                     //       style: theme.textTheme.bodyText1!
                      //                     //           .copyWith(
                      //                     //               color: Colors.black)),
                      //                     // ),
                      //                     Container(
                      //                       decoration: const BoxDecoration(
                      //                           // color: colorpalette.customColor2,?
                      //                           border: Border(
                      //                         top: BorderSide.none,
                      //                         left: BorderSide.none,
                      //                         right: BorderSide.none,
                      //                         bottom: BorderSide.none,
                      //                       )),
                      //                       child: Text(
                      //                           "${context.watch<dashBoardcontroller>().dummyshow[i].itemname}",
                      //                           style: theme.textTheme.bodyText1!
                      //                               .copyWith(
                      //                                   color: Colors.black)),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 SizedBox(
                      //                   height:
                      //                       Screens.padingHeight(context) * 0.01,
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Container(
                      //                       width: Screens.width(context) * 0.33,
                      //                       decoration: const BoxDecoration(
                      //                           // color: colorpalette.customColor2,?
                      //                           border: Border(
                      //                         top: BorderSide.none,
                      //                         left: BorderSide.none,
                      //                         right: BorderSide.none,
                      //                         bottom: BorderSide.none,
                      //                       )),
                      //                       child: Text(
                      //                           "Number of items #${context.watch<dashBoardcontroller>().dummyshow[i].itemcount}",
                      //                           style: theme.textTheme.bodyText1!
                      //                               .copyWith(
                      //                                   color: Colors.black)),
                      //                     ),
                      //                     // Container(
                      //                     //   decoration: const BoxDecoration(
                      //                     //       // color: colorpalette.customColor2,?
                      //                     //       border: Border(
                      //                     //     top: BorderSide.none,
                      //                     //     left: BorderSide.none,
                      //                     //     right: BorderSide.none,
                      //                     //     bottom: BorderSide.none,
                      //                     //   )),
                      //                     //   child: Text("|",
                      //                     //       style: theme.textTheme.bodyText1!
                      //                     //           .copyWith(
                      //                     //               color: Colors.black)),
                      //                     // ),
                      //                     Container(
                      //                       decoration: const BoxDecoration(
                      //                           // color: colorpalette.customColor2,?
                      //                           border: Border(
                      //                         top: BorderSide.none,
                      //                         left: BorderSide.none,
                      //                         right: BorderSide.none,
                      //                         bottom: BorderSide.none,
                      //                       )),
                      //                       child: Text(
                      //                           "Quantity #${context.watch<dashBoardcontroller>().dummyshow[i].itemqty}",
                      //                           style: theme.textTheme.bodyText1!
                      //                               .copyWith(
                      //                                   color: Colors.black)),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 //  Divider(color: Colors.black,)
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     }),
                  
                    )),
                  ],
                ),
              ),
            );
    //       },
    //     );
    //   },
    // );
  }
}
