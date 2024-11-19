import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:WareSmart/Model/loginModel/loginmodel.dart';
import 'package:WareSmart/Services/LoginApi/loginApi.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/helperfunc.dart';
import 'package:html/dom.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

class configcontroller extends ChangeNotifier {
//   configcontroller(BuildContext context){

//  Future.delayed(const Duration(seconds: 2), () {

//  Get.offAllNamed(ConstantRoutes.login);
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) =>  Loginpage()));
//     });
//   }
  init() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    Url.queryApi = '${getUrl.toString()}/api/';
    bool? isLoggedIn = await HelperFunctions.getUserLoggedInSharedPreference();
    if (getUrl == null) {
      Get.offAllNamed(ConstantRoutes.login);
    } else {
      log("get url not empty");
      checkloginApi();
    }
  }
 Future<void> showVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // log("packageInfo.version::" + packageInfo.version.toString());
    ConstantValues.appversion = packageInfo.version;
    print("packageInfo.versionConstant::" + ConstantValues.appversion.toString());
    notifyListeners();
  }
  Future<String?> getStoreVersion(String myAppBundleId) async {
    String? storeVersion;
    if (Platform.isAndroid) {
      PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
      Document? result2 =
          await playStoreSearchAPI.lookupById(myAppBundleId, country: 'IN');
      if (result2 != null) storeVersion = playStoreSearchAPI.version(result2);
      print('PlayStore version: $storeVersion');
      // } else if (Platform.isIOS) {
     
      // log('AppStore version: $storeVersion}');
    }else if(Platform.isIOS){
       ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
      Map<dynamic, dynamic>? result =
          await iTunesSearchAPI.lookupByBundleId(myAppBundleId, country: 'IN');
      if (result != null) storeVersion = iTunesSearchAPI.version(result);
    } else {
      storeVersion = null;
    }
    return storeVersion;
  }
  checkloginApi() async {
    // isloading = true;
    // notifyListeners();
    PostLoginData postLoginData = new PostLoginData();
    String? fcm2 = await HelperFunctions.getFCMTokenSharedPreference();
    if (fcm2 == null) {
      fcm2 = "HGHJGFGHGGFD897657JKGJH";
      // fcm2 = (await getToken())!;
      print("FCM Token: $fcm2");
      await HelperFunctions.saveFCMTokenSharedPreference(fcm2);
    }
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    log("deviceID:::" + deviceID.toString());
    if (deviceID == null) {
      deviceID = await Config.getdeviceId();
      print("deviceID" + deviceID.toString());
      await HelperFunctions.saveDeviceIDSharedPreference(deviceID!);
      notifyListeners();
    }
    postLoginData.tenentID = await HelperFunctions.getTenetIDSharedPreference();
    postLoginData.deviceCode =
        await HelperFunctions.getDeviceIDSharedPreference();

    postLoginData.fcmToken =
        await HelperFunctions.getFCMTokenSharedPreference();

    postLoginData.username =
        await HelperFunctions.getLogginUserCodeSharedPreference();
    postLoginData.password =
        await HelperFunctions.getPasswordSharedPreference();
    String? model = await Config.getdeviceModel();
    String? brand = await Config.getdeviceBrand();
    postLoginData.devicename = '${brand} ${model}';
    // ConstantValues.tenentID =
    //     await HelperFunctions.getTenetIDSharedPreference();

    await LoginAPi.getData(postLoginData).then((value) async {
      if (value.resCode! >= 200 && value.resCode! <= 200) {
        // if (value.loginstatus!.toLowerCase().contains('success') &&
        //     value.data != null) {
        // isloading = false;
        // erroMsgVisble = false;
        // errorMsh = '';
        ConstantValues.userNamePM = value.data!.userCode;
        await HelperFunctions.saveUserName(value.data!.userCode);

        await HelperFunctions.saveLogginUserCodeSharedPreference(
            value.data!.userCode);
        // await HelperFunctions.saveSapUrlSharedPreference(
        //     value.data!.endPointUrl);
        await HelperFunctions.saveTokenSharedPreference(value.token!);
        ConstantValues.token = value.token!;
        ConstantValues.constantdevicecode = value.data!.devicecode;
        ConstantValues.constantname = value.data!.urlColumn;
        log("aaa::" + ConstantValues.token.toString());
        await HelperFunctions.saveTenetIDSharedPreference(value.data!.tenantId);
        await HelperFunctions.saveUserIDSharedPreference(value.data!.UserID);
        ConstantValues.UserId = value.data!.UserID;
        ConstantValues.Usercode = value.data!.userCode;
        ConstantValues.Whsecode = value.data!.whsecode.toString();
        await HelperFunctions.saveUserLoggedInSharedPreference(true);
        // await HelperFunctions.savePasswordSharedPreference(
        //     value.data!.);

        log("message");

        await HelperFunctions.savedbUserName(value.data!.UserID);

        await HelperFunctions.saveUserType(value.data!.userType);
        await HelperFunctions.savewhseCode(value.data!.whsecode!);

        // mycontroller[0].clear();
        // mycontroller[1].clear();

        Get.offAllNamed(ConstantRoutes.dashboard);
        // } else if (value.loginstatus!.toLowerCase().contains("failed") &&
        //     value.data == null) {
        //   isloading = false;
        //   erroMsgVisble = true;
        //   errorMsh = value.loginMsg!;
        //   notifyListeners();
        // }
      } else if (value.resCode! >= 400 && value.resCode! <= 410) {
        // erroMsgVisble = true;

        // isloading = false;
        // errorMsh = value.excep!;
        // log("errorMsh::"+errorMsh.toString());
        Get.offAllNamed(ConstantRoutes.login);
        notifyListeners();
      } else {
        if (value.excep == 'No route to host') {
          // isloading = false;
          // erroMsgVisble = true;
          // errorMsh = 'Check your Internet Connection...!!';
          Get.offAllNamed(ConstantRoutes.login);
        } else if (value.loginMsg == "Catch") {
          Get.offAllNamed(ConstantRoutes.login);
          // isloading = false;
          // erroMsgVisble = true;
          // errorMsh =
          //     '${value.resCode!}..!!Network Issue..\nTry again Later..!!';
        } else {
          Get.offAllNamed(ConstantRoutes.login);
          // isloading = false;
          // erroMsgVisble = true;
          // errorMsh = '${value.resCode!}..!!${value.excep!}';
        }
        notifyListeners();
      }
    });
  }
}
