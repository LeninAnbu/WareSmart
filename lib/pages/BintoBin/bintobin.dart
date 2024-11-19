import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/testStyle.dart';
import 'package:WareSmart/controller/BintoBinController/BintoBinController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class bintobin extends StatefulWidget {
  const bintobin({super.key});

  @override
  State<bintobin> createState() => _bintobinState();
}

class _bintobinState extends State<bintobin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BintoBinController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                    child: Text("Bin-to-Bin",
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
            Container(
              width: Screens.width(context),
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.02,
                right: Screens.width(context) * 0.02,
              ),
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: theme.primaryColor))),
                    child: Text(
                      "Recommadations",
                      style: theme.textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        // border: Border(
                        //   bottom: BorderSide(
                        //     color: theme.primaryColor
                        //   )
                        // )
                        ),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(ConstantRoutes.newscreen);
                      //  context
                      //               .read<BintoBinController>()
                      //               . clearpopup();
                      //    context
                      //               .read<BintoBinController>()
                      //               .showscanpopup(
                      //                   context,
                      //                   );
                      },
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.005,
            ),
            Expanded(
                child: context.watch<BintoBinController>().isloading == true &&
                        context.watch<BintoBinController>().emptylist.isEmpty
                    ? Center(
                        child: SpinKitThreeBounce(
                          size: Screens.width(context) * 0.1,
                          color: theme.primaryColor,
                        ),
                      )
                    : context.watch<BintoBinController>().isloading == false &&
                        context.watch<BintoBinController>().emptylist.isEmpty?Center(
                          child: Text('No data ..!!'),
                        ): ListView.builder(
                        itemCount:
                            context.read<BintoBinController>().emptylist.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.01,
                                vertical:
                                    Screens.padingHeight(context) * 0.002),
                            // color: Colors.amber,
                            child: InkWell(
                              onTap: () {
                                //  context
                                //     .read<BintoBinController>()
                                //     .showBottompopup(context,context
                                //             .read<BintoBinController>()
                                //             .emptylist[i]);
                                context
                                    .read<BintoBinController>()
                                    .showscanpopup(
                                        context,
                                        );
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Screens.padingHeight(context) * 0.01,
                                      horizontal:
                                          Screens.width(context) * 0.02),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(8),
                                    //  border: Border.all(
                                    //   color: Colors.black38
                                    //  )
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              '${context.read<BintoBinController>().emptylist[i].itemcode}',
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(),
                                            ),
                                          ),
                                          Container(
                                              child: Row(
                                            children: [
                                              Text(
                                                'Date ',
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              Text(":"),
                                              Text(
                                                ' ${context.read<BintoBinController>().emptylist[i].date}',
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              '${context.read<BintoBinController>().emptylist[i].itemname}',
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${context.read<BintoBinController>().emptylist[i].qty}',
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Row(
                                            children: [
                                              Text('Barcode ',
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: Colors.grey)),
                                              Text(":"),
                                              Text(
                                                ' #${context.read<BintoBinController>().emptylist[i].barcode}',
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                            ],
                                          )),
                                          Container(
                                            child: Text(''),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text('From Bin ',
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.grey)),
                                                Text(":"),
                                                Text(
                                                  ' ${context.read<BintoBinController>().emptylist[i].frombin}',
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text('To Bin ',
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.grey)),
                                                Text(":"),
                                                Text(
                                                  ' ${context.read<BintoBinController>().emptylist[i].Tobin}',
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
            // Container(
            //     padding: EdgeInsets.only(
            //         left: Screens.width(context) * 0.02,
            //         right: Screens.width(context) * 0.02,
            //         top: Screens.padingHeight(context) * 0.01,
            //         bottom: Screens.padingHeight(context) * 0.02),
            //     child: Center(
            //       child: Container(
            //         height: Screens.padingHeight(context) * 0.06,
            //         width: Screens.width(context),
            //         //color: Colors.red,
            //         // margin: const EdgeInsets.all(20),
            //         //   child: Center(
            //         child: ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: theme.primaryColor,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(5)),
            //             ),
            //             onPressed: (){},
            //             // context
            //             //                                 .watch<
            //             //                                     putawaycontroller>()
            //             //                                 .finallodaing ==
            //             //                             true
            //             //                         ? null
            //             //                         : () {
            //             //   setState(() {
            //             //     // FocusScope.of(context).unfocus();
            //             //     // context
            //             //     //     .read<putawaycontroller>()
            //             //     //     .savefinal(context);
            //             //   });
            //             // },
            //             child:
            //             // context
            //             //                                 .watch<
            //             //                                     putawaycontroller>()
            //             //                                 .finallodaing ==
            //             //                             true
            //             //                         ?SpinKitThreeBounce(
            //             //                         size: Screens.width(context) *
            //             //                             0.05,
            //             //                         color: Colors.white,
            //             //                       ) :
            //                                    Text('Save', style: TextStyles.btnText(context))
            //             // : SpinKitThreeBounce(
            //             //     size: width * 0.05,
            //             //     color: Colors.white,
            //             //   ),
            //             ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
