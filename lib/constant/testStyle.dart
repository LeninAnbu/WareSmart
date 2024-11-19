import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'colors.dart';

class TextStyles{
  // static TextStyle txtCard = GoogleFonts.poppins(
  //       color:PrimaryColorLight.furney,
  //       fontSize: Screens.width(context)* 0.018,
  //       fontWeight: FontWeight.w500,
  //     );

  static TextStyle headline(BuildContext context) {
    return  GoogleFonts.poppins(
        color:PrimaryColor.black,
        fontSize: Screens.width(context)* 0.05,
      );
  }

  static TextStyle headline2(BuildContext context) {
    return  GoogleFonts.poppins(
        color:PrimaryColor.black,
        fontSize: Screens.width(context)* 0.04,
      );
  }

   static TextStyle headlineGrey(BuildContext context) {
    return  GoogleFonts.poppins(
        color:PrimaryColor.grey,
        fontSize: Screens.width(context)* 0.05,
      );
  }

    static TextStyle Underline(BuildContext context) {
    return  GoogleFonts.poppins(
        color:PrimaryColor.appColor,
        fontSize: Screens.width(context)* 0.05,
        decoration: TextDecoration.underline,
      );
  }

  static TextStyle Underline2(BuildContext context) {
    return  GoogleFonts.poppins(
        color:PrimaryColor.appColor,
        fontSize: Screens.width(context)* 0.048,
        decoration: TextDecoration.underline,
      );
  }

  static TextStyle bodytext1(BuildContext context) {
    return  GoogleFonts.poppins(
       color:PrimaryColor.grey,
        fontSize: Screens.width(context)*0.042
      );
  }
  static TextStyle bodytext2(BuildContext context) {
    return  GoogleFonts.poppins(
       color:PrimaryColor.black,
        fontSize: Screens.width(context)*0.033
      );
  }

  static TextStyle bodytext3(BuildContext context) {
    return  GoogleFonts.poppins(
       color:PrimaryColor.black,
        fontSize: Screens.width(context)*0.035
      );
  }

  static TextStyle btnText(BuildContext context) {
    return  GoogleFonts.poppins(
       color:PrimaryColor.white,
        fontSize: Screens.width(context)*0.04,
        
      );
  }
}