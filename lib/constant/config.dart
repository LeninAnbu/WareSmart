
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class Config{
 
   static Future<String?> getdeviceBrand() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'

      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.name; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.brand; // unique ID on Android
    }
    return null;
  }

  static Future<String?> getdeviceModel() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'

      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.model; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model; // unique ID on Android
    }
    return null;
  }
   static Future<String?> getdeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'

      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }
  Map<String, dynamic> parseJwt(String token) {
    log("String token::" + token.toString());

    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = decodeBase64(parts[1]);
    // log("payload"+payload.toString());
    final payloadMap = json.decode(payload);
    log("payloadMap" + payloadMap.toString());
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }
String decodeBase64(String str) {
    //'-', '+' 62nd char of encoding,  '_', '/' 63rd char of encoding
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      // Pad with trailing '='
      case 0: // No pad chars in this case
        break;
      case 2: // Two pad chars
        output += '==';
        break;
      case 3: // One pad char
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  
String alignDate1(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var date1 = inputFormat.parse(date);
    // log("------------------------------------------------------------------------------------------------");
    var dates = DateTime.parse(date1.toString());
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year.toString().padLeft(4, '0')}";
    // return date1.toString();
  }
 static String alignexpiry(String date) {
    String originalDate = "$date";
    var parsedDate = DateFormat("dd-MM-yyyy").parse(originalDate);
    // log("------------------------------------------------------------------------------------------------");
    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(parsedDate);
    return formattedDate;
    // return date1.toString();
  }
  String alignmeetingdate333(String date1) {
    String dateT = date1.replaceAll("T", " ");
    // log("DATATTA" + dateT.toString());
    final timestamp = DateTime.parse('$date1');

    // Define the desired date and time format
    final formattedDateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(timestamp);
    // log("DATE::" + formattedDateTime);
    return formattedDateTime;
  }
  static String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    print("date: " + currentDateTime.toString());
    return currentDateTime.trim();
  }
}