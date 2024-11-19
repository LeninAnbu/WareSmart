import 'dart:async';
import 'dart:developer';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/pages/InitialPage/updatedialogbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/controller/configcontroller/configcontroller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  String errormsg = '';
  late StreamSubscription subscription;
  var isDeviceconnected=false;
  bool isAlert=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      context.read<configcontroller>().showVersion();
        String? storeversion = await context
          .read<configcontroller>()
          .getStoreVersion('com.buson.WareSmart');
        // getconnectivity();
        if(storeversion != null){
          if (ConstantValues.appversion != storeversion){
              await showDialog(
              context: context,
              builder: ((context) => Upgraderdialogbox(
                    storeversion: storeversion,
                  ))).then((value) {
            try {
              context
                  .read<configcontroller>()
                  .init();
            } catch (e) {
              errormsg = e.toString();
            }
          });
            
          }else{
            try {
            context.read<configcontroller>().init();
          } catch (e) {
            errormsg = e.toString();
          }
          }
        }
      // context.read<configcontroller>().init();
    });
   
  }
// getconnectivity(){
// subscription= Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async{
// log("result::::"+result.toString());
// isDeviceconnected =await InternetConnectionChecker().hasConnection;
// if(!isDeviceconnected && isAlert ==false){
// showdialog();
// setState(() {

//   isAlert=true;
  
// });
// }

//  });
//    }
//    @override
// void dispose(){
//   subscription. cancel();
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return 
    // ChangeNotifierProvider<configcontroller>(
    //   create: (context) => configcontroller(context),
    //   builder: (context, child) {
    //     return Consumer<configcontroller>(
    //         builder: (BuildContext context, configcon, Widget? child) {
          return 
          Scaffold(
            // backgroundColor: theme.primaryColor,
            // backgroundColor: Colors.grey[200],
            body: Container(
              color:  theme.primaryColor.withOpacity(0.1),
              width: Screens.width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Screens.padingHeight(context) * 0.2,
                    width: Screens.width(context) * 0.3,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        // color: Colors.white, 
                        shape: BoxShape.circle),
                    child: Image.asset(
                  
                      "Asset/Applogo.jpeg",
                      // fit: BoxFit.,
                      height: Screens.padingHeight(context) * 0.15,
                      width: Screens.width(context) * 0.3,
                      // color: theme.primaryColor,
                    ),
                  ),
                  Text(
                    "WareSmart",
                    style: theme.textTheme.bodyText1!
                        .copyWith(color: theme.primaryColor, fontSize: 25),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context)*0.02,
                  ),
                  Container(
                    width: Screens.width(context)*0.5,
                    height: Screens.padingHeight(context)*0.006,
                    
                    decoration:const BoxDecoration(
color: Colors.white,
// borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: LinearProgressIndicator(color: theme.primaryColor,
                    backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
    //     });
    //   },
    // );
  }
 
}
