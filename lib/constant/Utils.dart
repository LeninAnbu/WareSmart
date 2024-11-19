



// import 'package:flutter/material.dart';

// class Utils {
//    static String versionNumber = "1.0.7";
//   static String appDateOfLatestReleaseBM = '28/04/2023'; //temenos 

//   static String? slpName;
//   static String? slpCode;

//   static void showTopSnackBar(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Check Internet Connectivity"),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarValidation(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Check Your Credential !!.."),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarEmptyField(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Field Is Empty !!.."),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarFailure(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Error!!.."),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarNoData(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("No Data!!.."),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarSuccess(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Success!!.."),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarfullamount(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Warning!!.."),
//           subtitle: Text(message), background: color);

//   static void showTopSnackBarWarning(
//           BuildContext context, String message, Color color) =>
//       showSimpleNotification(Text("Warning!!.."),
//           subtitle: Text(message), background: color);

//   static TextStyle txtHeading = TextStyle(
//       fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

//   static TextStyle txtContent = TextStyle(
//       fontSize: 15.0,
//       // fontWeight: FontWeight.bold,
//       color: Colors.black);

//   static TextStyle txtCard = TextStyle(
//       fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);

//   static TextStyle txtCardHead = TextStyle(
//       fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);

//   static TextStyle txtCardCtnt = TextStyle(
//     fontSize: 15.0,
//   );

//   static TextStyle dashBoardtxtContent =
//       TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);

//   static Color leadbookTxtFld = Colors.green;
//   static Color leadbookChkBox = Colors.green;
//   static Color leadbookChkBoxAct = Colors.green;
//   static Color leadbookRdioBtn = Colors.green;
//   static Color greenAccent = Colors.greenAccent;
//   static Color pink = Colors.pink;
//   static Color blue = Colors.blue;
//   static Color grey = Colors.grey;
//   static Color? drawerHeadercolor = Colors.greenAccent[400];
//   static Color? drawerSelectedColor = Colors.greenAccent[100];
//   static Color btnColor = Colors.green;
//  playSound(String sound){
//    AudioPlayer audio =  AudioPlayer();
//     audio.setAsset("assets/$sound.mp3");
//     audio.play();
// }


// showSuccessNoti(BuildContext context,String title,String msg){
//    AudioPlayer audio =  AudioPlayer();
//   audio.setAsset("assets/sound.mp3");
//     audio.play();
//   Get.defaultDialog(
//     title : title,
//     radius: 10,
//     titleStyle: TextStyle(color: Colors.green),
//     content: Container(
//       width: Screens.width(context),
//      // height: Screens.heigt(context)*0.5,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//            Container(
//             width: Screens.width(context)*0.2,
//             height: Screens.heigt(context)*0.1,
//             child: Lottie.asset('assets/57767-done.json')),
//           SizedBox(height: Screens.heigt(context)*0.01,),
//           Text("$msg"),
//         ],
//       ),
//     )
//   ).then((value) {
//       Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => ScanQR()));
//   });
    
// }


// showErrorNoti(BuildContext context,String title,String msg){
//    AudioPlayer audio =  AudioPlayer();
//    audio.setAsset("assets/error.mp3");
//     audio.play();
//   Get.defaultDialog(
//     title : title,
//     radius: 10,
//     titleStyle: TextStyle(color: Colors.red),
//     content: Container(
//       width: Screens.width(context),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//            Container(
//             width: Screens.width(context)*0.2,
//             height: Screens.heigt(context)*0.1,
//             child: Lottie.asset('assets/76705-error-animation.json')),
//           SizedBox(height: Screens.heigt(context)*0.01,),
//           Text("$msg"),
//         ],
//       ),
//     )
//   );
   
// }
// }