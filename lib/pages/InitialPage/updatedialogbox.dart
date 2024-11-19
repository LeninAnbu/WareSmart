


import 'dart:io';

import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/controller/configcontroller/configcontroller.dart';
import 'package:WareSmart/pages/InitialPage/InitaialPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Upgraderdialogbox extends StatefulWidget {
  Upgraderdialogbox({
    super.key,
    required this.storeversion,
  });
  String? storeversion;

  @override
  State<Upgraderdialogbox> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<Upgraderdialogbox> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<configcontroller>().showVersion();
      String? storeversion = await context
          .read<configcontroller>()
          .getStoreVersion('com.buson.WareSmart');
      if (ConstantValues.appversion == storeversion) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InitialPage()),
          (route) => route.isFirst,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: SizedBox(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update available",
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Text(
              "There is a new version of the WareSmart is Available! New version is ${widget.storeversion} you have ${ConstantValues.appversion}",
              style: theme.textTheme.bodyText1,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    height: Screens.bodyheight(context) * 0.08,
                    width: Screens.width(context) * 0.18,
                    padding:
                        EdgeInsets.all(Screens.bodyheight(context) * 0.008),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]),
                    child: Image.asset(
                      'Asset/Applogo.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.all(Screens.bodyheight(context) * 0.008),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5),
                    //   color: Colors.grey[200]
                    // ),
                    child: Text(
                      'Version : ${widget.storeversion}',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
              // context
              // .read<configcontroller>()
              // .checkStartingPage(pagename, docEntry);
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.25,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () async {
                        if (Platform.isAndroid || Platform.isIOS) {
                          final appId = Platform.isAndroid
                              ? 'com.buson.WareSmart'
                              : 'com.buson.WareSmart';
                          final url = Uri.parse(
                            Platform.isAndroid
                                ? "https://play.google.com/store/apps/details?id=com.buson.WareSmart"
                                : "https://apps.apple.com/app/id$appId",
                          );
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          ).then((value) {
                            // exit(0);
                          });
                        }
                      },
                      child: Text('Update')),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.25,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () async {
                       Navigator.of(context).pop('Close');
                      },
                      child: Text('Close')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
