import 'package:WareSmart/controller/BinContentController/BinContentcontroller.dart';
import 'package:WareSmart/controller/BintoBinController/BintoBinController.dart';
import 'package:WareSmart/controller/DelreturnController/DelreturnController.dart';
import 'package:WareSmart/controller/DespatchController/Despatchcontroller.dart';
import 'package:WareSmart/controller/DespatchController/NewDespatchController.dart';
import 'package:WareSmart/controller/ItemSearchController/ItemSearchController.dart';
import 'package:WareSmart/controller/pickupcontroller/Pickupcontroller.dart';
import 'package:WareSmart/controller/putawayController/putawaycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:WareSmart/DBhelper/DBhelper.dart';
import 'package:WareSmart/constant/Routes.dart';
import 'package:WareSmart/controller/configcontroller/configcontroller.dart';
import 'package:WareSmart/controller/dashboardcontroller/dashboardcontroller.dart';
import 'package:WareSmart/controller/inwardController/inwardcontroller.dart';
import 'package:WareSmart/controller/logincontroller/logincontroller.dart';
import 'package:WareSmart/pages/InitialPage/InitaialPage.dart';
import 'package:WareSmart/widgets/colorpalate.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await createDB();
  runApp(const MyApp());
}
Future createDB() async {
  await DBhelper.getinstance().then((value) {
    print("Created...");
  });
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // static const int _myHexColorValue = 0xFF01806b;
  //   static MaterialColor myMaterialColor =
  //     const MaterialColor(_myHexColorValue, <int, Color>{
  //   50: Color(0xFFE0F2F1),
  //   100: Color(0xFFB2DFDB),
  //   200: Color(0xFF80CBC4),
  //   300: Color(0xFF4DB6AC),
  //   400: Color(0xFF26A69A),
  //   500: Color(_myHexColorValue),
  //   600: Color(0xFF00796B),
  //   700: Color(0xFF00695C),
  //   800: Color(0xFF004D40),
  //   900: Color(0xFF00251A),
  // });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // networkcon = context.read<network>();
    super.initState();
    setState(() {
      // getconnectivity(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => configcontroller()),
        ChangeNotifierProvider(create: (_) => dashBoardcontroller()),
        ChangeNotifierProvider(create: (_) => logincontroller()),
        ChangeNotifierProvider(create: (_) => inwardcontroller()),
        ChangeNotifierProvider(create: (_) => putawaycontroller()),
        ChangeNotifierProvider(create: (_)=> BintoBinController()),
        ChangeNotifierProvider(create: (_)=> PickupController()),
        ChangeNotifierProvider(create: (_)=> DespatchController()),
        ChangeNotifierProvider(create: (_)=> NewDespatchController()),
        ChangeNotifierProvider(create: (_)=> BinContentController()),
        ChangeNotifierProvider(create: (_)=> ItemSearchController()),
        ChangeNotifierProvider(create: (_)=> DelreturnController()),
        
        
        
        
      ],
      child:
          Consumer<configcontroller>(builder: (context, config, Widget? child) {
        return GetMaterialApp(
          key: navigatorKey,
          localizationsDelegates: [
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            // Add more delegates as needed
          ],
          debugShowCheckedModeBanner: false,
          title: 'WareSmart',
          theme: ThemeData(
            // fontFamily: "Oswald",#00226C
            primaryColor: Color(0xFF00226C),
            //  primarySwatch:  colorpalette.customColor2,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xFF00226C),
              secondary: Color(0xFF00226C),
            ),
            brightness: Brightness.light,

            //  appBarTheme: AppBarTheme(
            //   backgroundColor: Colors.white
            //  ),
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: InitialPage(),
          getPages: Routes.allroutes,
        );
      }),
    );
  }
}
