import 'dart:developer';

import 'package:WareSmart/controller/BinContentController/BinContentcontroller.dart';
import 'package:WareSmart/controller/BintoBinController/BintoBinController.dart';
import 'package:WareSmart/controller/DelreturnController/DelreturnController.dart';
import 'package:WareSmart/controller/DespatchController/NewDespatchController.dart';
import 'package:WareSmart/controller/ItemSearchController/ItemSearchController.dart';
import 'package:WareSmart/controller/pickupcontroller/Pickupcontroller.dart';
import 'package:WareSmart/controller/putawayController/putawaycontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:WareSmart/controller/inwardController/inwardcontroller.dart';

class QRscanner extends StatefulWidget {
  const QRscanner({super.key});

  @override
  State<QRscanner> createState() => QRscannerState();
}

class QRscannerState extends State<QRscanner> {
  static bool inwardscan = false;
  static bool inwardbinscan = false;
  static bool inwardSerialscan = false;
  static bool putawayserial = false;
  static bool putawayBin = false;
  static bool outwardMain = false;
  static bool outwarserial1 = false;
  static bool despatchscan = false;
  static bool frombin = false;
  static bool tobin = false;
  static bool binserial = false;
  static bool bincontent = false;
  static bool itmeSEserial = false;
  static bool itmeSEitem = false;
  static bool itmeSEbin = false;
  static bool delpickslip = false;
  static bool delbarcode = false;

  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  List<Barcode> barcodes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      barcodes.clear();
    });
    log("barcodes:::" + barcodes.toString());
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      setState(() {
        if (inwardscan == true) {
          setState(() {
            inwardscan = false;
            log("hiiii");
          });
        } else if (inwardbinscan == true) {
          inwardbinscan = false;
        } else if (inwardSerialscan == true) {
          inwardSerialscan = false;
        } else if (putawayserial == true) {
          putawayserial = false;
        } else if (putawayBin == true) {
          putawayBin = false;
        } else if (outwardMain == true) {
          outwardMain = false;
        } else if (outwarserial1 == true) {
          outwarserial1 = false;
        } else if (despatchscan == true) {
          despatchscan = false;
        } else if (frombin == true) {
          frombin = false;
        } else if (tobin == true) {
          tobin = false;
        } else if (binserial == true) {
          binserial = false;
        } else if (bincontent == true) {
          bincontent = false;
        } else if (delpickslip == true) {
          delpickslip = false;
        } else if (itmeSEserial == true) {
          itmeSEserial = false;
        } else if (itmeSEitem == true) {
          itmeSEitem = false;
        } else if (itmeSEbin == true) {
          itmeSEbin = false;
        } else if (delbarcode == true) {
          delbarcode = false;
        }
      });

      Get.back();
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mobile Scanner"),
        ),
        body: MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            barcodes = capture.barcodes;
            for (var barcode in barcodes) {
              if (inwardscan == true) {
                // context.read<inwardcontroller>().scannedData='';
                context.read<inwardcontroller>().scannedData =
                    barcode.rawValue ?? '';
                Navigator.pop(context);

                inwardscan = false;
              } else if (inwardbinscan == true) {
                context.read<inwardcontroller>().binscannedData =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                inwardbinscan = false;
              } else if (inwardSerialscan == true) {
                context.read<inwardcontroller>().serialscannedData =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                inwardSerialscan = false;
              } else if (putawayserial == true) {
                context.read<putawaycontroller>().putawayserialscan =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                putawayserial = false;
              } else if (putawayBin == true) {
                context.read<putawaycontroller>().putawaybinscan =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                putawayBin = false;
              } else if (outwardMain == true) {
                context.read<PickupController>().scannedCode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                outwardMain = false;
              } else if (outwarserial1 == true) {
                context.read<PickupController>().SerialscannedCode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                outwarserial1 = false;
              } else if (despatchscan == true) {
                context.read<NewDespatchController>().scannedData =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                despatchscan = false;
              } else if (frombin == true) {
                context.read<BintoBinController>().frombincode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                frombin = false;
              } else if (tobin == true) {
                context.read<BintoBinController>().tobincode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                tobin = false;
              } else if (binserial == true) {
                context.read<BintoBinController>().binbarcode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                binserial = false;
              } else if (bincontent == true) {
                context.read<BinContentController>().ScannedCode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                bincontent = false;
              } else if (itmeSEserial == true) {
                context.read<ItemSearchController>().seialScannedCode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                itmeSEserial = false;
              } else if (itmeSEitem == true) {
                context.read<ItemSearchController>().itemScannedCode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                itmeSEitem = false;
              } else if (itmeSEbin == true) {
                context.read<ItemSearchController>().binScannedCode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                itmeSEbin = false;
              }else if (delpickslip == true) {
                context.read<DelreturnController>().Delscannedslip =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                delpickslip = false;
              }
              else if (delbarcode == true) {
                context.read<DelreturnController>().Delscannedbarcode =
                    barcode.rawValue ?? '';
                Navigator.pop(context);
                delbarcode = false;
              }
            }
          },
        ),
      ),
    );
  }
}
