
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class pack extends StatefulWidget {
  const pack({super.key});

  @override
  State<pack> createState() => _packState();
}

class _packState extends State<pack> {
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
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
                        child: Text("pack",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText1!.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ), 
                          ],
                        ),
                      ),
            Expanded(child: Center(child: Text("No data..!!"))),
          ],
        ),
      ),
    );
  }
}