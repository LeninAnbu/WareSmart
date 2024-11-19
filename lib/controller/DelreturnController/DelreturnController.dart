import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:WareSmart/Model/DelReturnMOdel/GetDispModel.dart';
import 'package:WareSmart/Model/DespatchModel/getQRModel.dart';
import 'package:WareSmart/Services/DelReturnApi/dispApi.dart';
import 'package:WareSmart/Services/DesptachApi/GetQRApi.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DelreturnController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());

  String Delscannedslip = '';
  String Delscannedbarcode = '';
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  init() {
    clearAll();
    // callgetdispApi();
  }

  clearAll() {
    qrloading = false;
    qrerror = '';
    iserror = '';checkvalue = false;
    isloading = false;
    DesQRlistsave.clear();
    filedata.clear();
    Displist .clear();
    filterDisplist.clear();
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    iscorrect=false;
    valuecancelStatus = null;
    notifyListeners();
  }

  List<DispList> Displist = [];
  List<DispList> filterDisplist = [];
  bool isloading = false;
  String? iserror = '';
  addDispdetails(List<DispList> Displist, DesQRheaderList DesQRlistsave) {
    log("DesQRlistsave.ItemDisposition::"+DesQRlistsave.ItemDisposition.toString());
    
    filterDisplist.clear();
      notifyListeners();
    for (int i = 0; i < Displist.length; i++) {
      log("DesQRlistsave.Displist::"+Displist[i].DispID.toString());
      if (Displist[i].DispID == DesQRlistsave.ItemDisposition) {
        filterDisplist.add(DispList(
            DispID: Displist[i].DispID, DispListVal: Displist[i].DispListVal));
          log("filterDisplist::"+filterDisplist.length.toString());
      }
      notifyListeners();
    }
      notifyListeners();
  }

  callgetdispApi(DesQRheaderList DesQRlistsave) async {
    Displist.clear();
    await GetDispApi.getdata().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.dispheader!.itemlist != null &&
            value.dispheader!.itemlist!.isNotEmpty) {
          Displist = value.dispheader!.itemlist!;
          addDispdetails(Displist, DesQRlistsave);

          isloading = false;

          iserror = '';

          log("pendinglist::" + Displist.length.toString());
          notifyListeners();
        } else if (value.dispheader!.itemlist == null ||
            value.dispheader!.itemlist!.isEmpty) {
          isloading = false;
          iserror = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        iserror = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isloading = false;
          iserror = "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          isloading = false;
          iserror = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
  }
bool iscorrect=false;
  afterserialScanned(String code, BuildContext context) {
    if(DesQRlistsave.isEmpty){
showdialogtoast(context,"QR not valid..!!");
notifyListeners();
    }else{
if (code.toLowerCase() == DesQRlistsave[0].SerialBatch!.toLowerCase()) {
      log("hiiii");
      mycontroller[1].text = code;
      iscorrect=true;
      focus2.unfocus();
      notifyListeners();
    } else {
      showdialogtoast(
          context, "Entered Barcode is not match with scanned item..!!");

      notifyListeners();
    }
    }
    
  }

  showtoastInw(String message) {
    Fluttertoast.cancel();

    notifyListeners();

    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 0,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  bool qrloading = false;
  String qrerror = '';
  List<DesQRheaderList> DesQRlistsave = [];
  String? dispcode='';
  String? Dispname='';
  selectCustomerTag(String selected, String refercode,) {
   
    Dispname = selected;
    dispcode = refercode;
   
    
    notifyListeners();
  }
  afterQRScanned(String code, BuildContext context) async {
    iscorrect=false;
    mycontroller[1].clear();
// DesQRlistsave.clear();
    qrloading = true;
    qrerror = '';
    notifyListeners();
    await GetDespatchQRApi.getdata(code).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.desQRheader!.itemlist != null &&
            value.desQRheader!.itemlist!.isNotEmpty) {
          if (value.desQRheader!.itemlist![0].isDelivered != 1 ||
              (value.desQRheader!.itemlist![0].SerialBatch == null ||
                  value.desQRheader!.itemlist![0].SerialBatch == "")) {
            showdialogtoast(context, "Dispatch not processed..!!");
            mycontroller[0].clear();
            focus1.requestFocus();
          } else {
            DesQRlistsave = value.desQRheader!.itemlist!;
            callgetdispApi(DesQRlistsave[0]);
            focus1.unfocus();
            focus2.requestFocus();
          }

          qrloading = false;
          qrerror = '';

          log("pendinglist::" + DesQRlistsave.length.toString());
          notifyListeners();
        } else if (value.desQRheader!.itemlist == null ||
            value.desQRheader!.itemlist!.isEmpty) {
                showdialogtoast(context, "No data Found...!!");
                mycontroller[0].clear();
          qrloading = false;
          qrerror = "No data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        qrloading = false;
        qrerror = "${value.message}..${value.exception}..!!";
        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          qrloading = false;
          qrerror = "'${value.stcode!}..!!Network Issue..\nTry again Later..!!";
          notifyListeners();
        } else {
          qrloading = false;
          qrerror = "${value.stcode}..${value.exception}..!!";
          notifyListeners();
        }
      }
    });
  }

  showdialogtoast(BuildContext context, String? message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final theme = Theme.of(context);
          return StatefulBuilder(builder: (context, setst) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            )),
                        width: Screens.width(context),
                        height: Screens.padingHeight(context) * 0.05,
                        alignment: Alignment.center,
                        child: Text(
                          "Alert",
                          style: theme.textTheme.bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child: Text(
                              "$message",
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),

                            ElevatedButton(
                                onPressed: () {
                                  setst(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("ok"))
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  String? expiryDate = '';
  void showexpDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      expiryDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[3].text = chooseddate;
      notifyListeners();
    });
  }

  bool checkvalue = false;
  String? valuecancelStatus;
  FilePickerResult? result;
  //  filesz = [];
  List<File> files = [];
  List<FilesData> filedata = [];
  List<String> filelink = [];
  List<String> fileException = [];
  bool? fileValidation = false;
  Future imagetoBinary(ImageSource source) async {
    List<File> filesz = [];
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // files.add(File(image.path));
    // filedata.clear();
    if (filedata.isEmpty) {
      filedata.clear();
      filesz.clear();
    }
    filesz.add(File(image.path));
    notifyListeners();

    // if (files.length <= 1) {
    for (int i = 0; i < filesz.length; i++) {
      files.add(filesz[i]);
      List<int> intdata = filesz[i].readAsBytesSync();
      String fileName = filesz[i].path.split('/').last;
      String fileBytes = base64Encode(intdata);
      String tempPath = '';
      if (Platform.isAndroid) {
        tempPath = (await getExternalStorageDirectory())!.path;
      } else if (Platform.isIOS) {
        tempPath = (await getApplicationDocumentsDirectory())!.path;
      }

      String fullPath = '$tempPath/$fileName';
      await filesz[i].copy(fullPath);
      File(fullPath).writeAsBytesSync(intdata);
      // final result =
      //     await ImageGallerySaver.saveFile(fullPath, isReturnPathOfIOS: true);

      if (Platform.isAndroid) {
        filedata
            .add(FilesData(fileBytes: base64Encode(intdata), fileName: fullPath
                // files[i].path.split('/').last
                ));
      } else {
        filedata.add(
            FilesData(fileBytes: base64Encode(intdata), fileName: image.path
                // files[i].path.split('/').last
                ));
      }

      notifyListeners();
    }

    // } else {
    //   // showtoast();
    //   notifyListeners();
    // }
    log("camera fileslength" + files.length.toString());
    // showtoast();

    notifyListeners();
  }

  selectattachment() async {
    List<File> filesz = [];
    log(files.length.toString());

    result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    notifyListeners();

    if (result != null) {
      if (filedata.isEmpty) {
        files.clear();
        filesz.clear();
        filedata.clear();
        notifyListeners();
      }

      filesz = result!.paths.map((path) => File(path!)).toList();
      log("filesz::" + filesz.length.toString());
      // if (filesz.length != 0) {
      log("filedata::" + filedata.length.toString());
      int remainingSlots = 2 - files.length;
      log("remainingSlots::" + remainingSlots.toString());
      // if (filesz.length <= remainingSlots) {
      for (int i = 0; i < filesz.length; i++) {
        // createAString();

        // showtoast();
        files.add(filesz[i]);
        // log("Files Lenght :::::" + files.length.toString());
        List<int> intdata = filesz[i].readAsBytesSync();
        filedata.add(FilesData(
            fileBytes: base64Encode(intdata), fileName: filesz[i].path));
        notifyListeners();

        // return null;
      }
      // } else {
      //   // showtoast();
      //   notifyListeners();
      // }
      // }
      notifyListeners();
    }
    notifyListeners();
  }
}

class FilesData {
  String fileBytes;
  String fileName;
  // String filepath;

  FilesData({
    required this.fileBytes,
    required this.fileName,
  });
}

class dummydata {
  String? code;
  String? name;
  dummydata({required this.code, required this.name});
}
