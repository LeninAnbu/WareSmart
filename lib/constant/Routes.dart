import 'package:WareSmart/pages/BinContent/bincontent.dart';
import 'package:WareSmart/pages/BintoBin/bintobin.dart';
import 'package:WareSmart/pages/BintoBin/newscreen.dart';
import 'package:WareSmart/pages/DelReturn/delreturn.dart';
import 'package:WareSmart/pages/Despatch/despatch.dart';
import 'package:WareSmart/pages/Despatch/newDespatch.dart';
import 'package:WareSmart/pages/ItemSearch/itemsearch.dart';
import 'package:WareSmart/pages/Pack/pack.dart';
import 'package:WareSmart/pages/Pickup/detailspage.dart';
import 'package:WareSmart/pages/Pickup/pickup.dart';
import 'package:WareSmart/pages/Putaway/putaway.dart';
import 'package:get/get.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/pages/Inward/inwardpage.dart';
import 'package:WareSmart/pages/Inward/inwardsevepage.dart';
import 'package:WareSmart/pages/Login/Loginpage.dart';
import 'package:WareSmart/pages/dashBoard/dashboardPage.dart';

class Routes {
  static List<GetPage> allroutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.login,
        page: () => loginpage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage(
        name: ConstantRoutes.inwardpage,
        page: () => inwardpage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage(
        name: ConstantRoutes.dashboard,
        page: () => dashboard(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage(
        name: ConstantRoutes.inwardsavepage,
        page: () => savelistinward(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
        GetPage(
        name: ConstantRoutes.putawaypage,
        page: () => Putawaypage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
        GetPage(
        name: ConstantRoutes.pickupmain,
        page: () => pickup(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.detailspickup,
        page: () => detailspickup(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.packmain,
        page: () => pack(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.bintobinmain,
        page: () => bintobin(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.delreturnmain,
        page: () => delreturn(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.despatchmain,
        page: () => despatch(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.bincontentmain,
        page: () => BinContent(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.itemsearchmain,
        page: () => ItemSearch(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.newdespatch,
        page: () => NewDespatch(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
         GetPage(
        name: ConstantRoutes.newscreen,
        page: () => newscreen(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
        
  ];
}
