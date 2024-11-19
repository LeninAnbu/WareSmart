

class postdesptachreq{
  String? docdate;
  String? whscode;
  String? routecode;
  String? vehno;
  String? drivername;
  String? drivercontact;
  List<Desplines>? desplines;
  postdesptachreq({
    required this.desplines,
    required this.docdate,
    required this.drivercontact,
    required this.drivername,
    required this.routecode,
    required this.vehno,
    required this.whscode


  });
  Map<String, dynamic> tojson(){
     Map<String, dynamic> map ={
 "docdate": docdate,
    "whscode": whscode,
    "routecode": routecode,
    "vehno": vehno,
    "drivername": drivername,
    "drivercontact": drivercontact,
    "desplines":desplines!.map((e) => e.tojson2()).toList()
     };
     return map;
  }

}
class Desplines{
  String? qrcode;
  Desplines({
    required this.qrcode
  });
  Map<String, dynamic> tojson2(){
     Map<String, dynamic> map ={
      "qrcode":qrcode,
     };
     return map;
  }
}