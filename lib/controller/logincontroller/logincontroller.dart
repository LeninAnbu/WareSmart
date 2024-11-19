import 'dart:async';
import 'dart:developer';

import 'package:WareSmart/Services/LoginApi/GetUrl.dart';
import 'package:WareSmart/Services/URL/localurl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:WareSmart/Model/loginModel/loginmodel.dart';
import 'package:WareSmart/Services/LoginApi/loginApi.dart';
import 'package:WareSmart/constant/config.dart';
import 'package:WareSmart/constant/constantRoutes.dart';
import 'package:WareSmart/constant/constantvalues.dart';
import 'package:WareSmart/constant/helperfunc.dart';

class logincontroller extends ChangeNotifier {
  logincontroller() {
    clear();
  }

  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
  List<GlobalKey<FormState>> formkey =
      List.generate(20, (i) => GlobalKey<FormState>());
  bool isloading = false;
  bool progrestext = false;
  bool erroMsgVisble = false;
  bool settingError = false;
  bool passwordvisible = true;

  String errorMsh = '';

  onchangedpass(){
    passwordvisible = !passwordvisible;
    notifyListeners();
  }
  clear() async {
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[3].clear();
    passwordvisible = true;
    //  await HelperFunctions.clearHost();
    await HelperFunctions.clearCheckedTennetIDSharedPref();
    // await HelperFunctions.clearhostIP();
    erroMsgVisble = true;
    settingError = true;
    errorMsh = "Complete the setup..!!";
    notifyListeners();
  }

  void settingvalidate(BuildContext context) async {
    // await checkLoc();

    notifyListeners();
    if (formkey[1].currentState!.validate()) {
      progrestext = true;
      errorMsh = "";
      erroMsgVisble = false;
      settingError = false;
      // setURL();
      progrestext = false;
      notifyListeners();

      Navigator.pop(context);
    }
  }
  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }
  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    String hostip = '';
    if (getUrl != null) {
      for (int i = 0; i < getUrl.length; i++) {
        if (getUrl[i] == ":") {
          break;
        }
        // log("for ${hostip}");
        hostip = hostip + getUrl[i];
      }
    }

    // log("for last ${hostip}");
    // HelperFunctions.savehostIP(hostip);
    // ConstantValues.userNamePM = await HelperFunctions.getUserName();
    Url.queryApi = "${getUrl.toString()}/api/";
    // Url.queryApi = "http://${getUrl.toString()}/api/";
  }
  validatelogin(BuildContext context)async{
if (mycontroller[3].text.toString().trim().isEmpty) {
      errorMsh = "Complete the setup..!!";
    }else{
     if (formkey[0].currentState!.validate()) {
      disableKeyBoard(context);
        isloading = true;
        await HelperFunctions.clearHost();
        String? Url = "";
          print("get Url Api call:" + mycontroller[3].text.toString());
        await GetURLApi.getData(mycontroller[3].text.toString().trim())
            .then((value) async {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            if (value.url1 != null) {
              Url = value.url1;
              log("url method::" + Url.toString());
              await HelperFunctions.saveHostSP(Url!.trim());
              await HelperFunctions.saveTenetIDSharedPreference(
                  mycontroller[3].text.toString().trim());
              setURL();
             
              errorMsh = "";
              erroMsgVisble = false;
              settingError = false;
               validateloginfinal(context);
              notifyListeners();
            } else {
              print("object1:" + value.exception.toString());
              erroMsgVisble = true;
              isloading = false;
              validateloginfinal(context);
              errorMsh = value.exception.toString();
            }
          }else if(value.stcode! >= 400 && value.stcode! <= 410){
   print("object1:" + value.exception.toString());
              erroMsgVisble = true;
              isloading = false;
              validateloginfinal(context);
              // errorMsh = value.exception.toString();
              notifyListeners();
          } else {
            if (value.exception == 'No route to host') {
          isloading = false;
          erroMsgVisble = true;
          errorMsh = 'Check your Internet Connection...!!';
        } else if (value.message =="Catch"){
           isloading = false;
          erroMsgVisble = true;
          errorMsh =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        }else{
           isloading = false;
          erroMsgVisble = true;
          errorMsh =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      
        }
            // print("object2:" + value.exception.toString());
            // erroMsgVisble = true;
            // isLoading = false;
            // errorMsh = value.exception.toString();
          }
        });
     }
    }
  }

  validateloginfinal(BuildContext context) async {
    String? getUrl = await HelperFunctions.getHostDSP();
         log("getUrl::"+getUrl.toString());
   if(getUrl ==null || getUrl == 'null' ||getUrl ==''){
     isloading = false;
          erroMsgVisble = true;
         errorMsh =
              'Invalid Customer Id..!!';  
              notifyListeners();

         }else {
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
        postLoginData.tenentID=mycontroller[3].text.toString().trim();
        postLoginData.deviceCode =
            await HelperFunctions.getDeviceIDSharedPreference();

        postLoginData.fcmToken =
            await HelperFunctions.getFCMTokenSharedPreference();

        postLoginData.username = mycontroller[0].text;
        postLoginData.password = mycontroller[1].text;
        String? model = await Config.getdeviceModel();
        String? brand = await Config.getdeviceBrand();
        postLoginData.devicename = '${brand} ${model}';
        ConstantValues.tenentID =
            await HelperFunctions.getTenetIDSharedPreference();

        await LoginAPi.getData(postLoginData).then((value) async {
        
            if (value.resCode! >= 200 && value.resCode! <= 200) {
              // if (value.loginstatus!.toLowerCase().contains('success') &&
              //     value.data != null) {
                isloading = false;
                erroMsgVisble = false;
                errorMsh = '';
                ConstantValues.userNamePM = mycontroller[0].text;
              ConstantValues.constantdevicecode=value.data!.devicecode;
                await HelperFunctions.saveUserName(mycontroller[0].text);

                await HelperFunctions.saveLogginUserCodeSharedPreference(
                    mycontroller[0].text);
                // await HelperFunctions.saveSapUrlSharedPreference(
                //     value.data!.endPointUrl);
                await HelperFunctions.saveTokenSharedPreference(value.token!);
                ConstantValues.token=value.token!;
                log("aaa::"+ConstantValues.token.toString());
                await HelperFunctions.saveTenetIDSharedPreference(
                    value.data!.tenantId);
                await HelperFunctions.saveUserIDSharedPreference(
                    value.data!.UserID);
                ConstantValues.    constantname=value.data!.urlColumn;
                ConstantValues.UserId = value.data!.UserID;
                ConstantValues.Usercode = value.data!.userCode;
                ConstantValues.Whsecode = value.data!.whsecode.toString();
                await HelperFunctions.saveUserLoggedInSharedPreference(true);
                await HelperFunctions.savePasswordSharedPreference(
                    mycontroller[1].text);

                log("message");

                await HelperFunctions.savedbUserName(value.data!.UserID);

                await HelperFunctions.saveUserType(value.data!.userType);
                await HelperFunctions.savewhseCode(value.data!.whsecode!);

                mycontroller[0].clear();
                mycontroller[1].clear();

                Get.offAllNamed(ConstantRoutes.dashboard);
              // } else if (value.loginstatus!.toLowerCase().contains("failed") &&
              //     value.data == null) {
              //   isloading = false;
              //   erroMsgVisble = true;
              //   errorMsh = value.loginMsg!;
              //   notifyListeners();
              // }
            } else if (value.resCode! >= 400 && value.resCode! <= 410) {
              erroMsgVisble = true;

              isloading = false;
              errorMsh = value.excep!;
              log("errorMsh::"+errorMsh.toString());
              notifyListeners();
            } else {
              if (value.excep == 'No route to host') {
                isloading = false;
                erroMsgVisble = true;
                errorMsh = 'Check your Internet Connection...!!';
              } else if (value.loginMsg == "Catch") {
                isloading = false;
                erroMsgVisble = true;
                errorMsh =
                    '${value.resCode!}..!!Network Issue..\nTry again Later..!!';
              } else {
                isloading = false;
                erroMsgVisble = true;
                errorMsh = '${value.resCode!}..!!${value.excep!}';
              }
              notifyListeners();
            }
       
        });
      }
    
  }
}
