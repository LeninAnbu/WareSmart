

class Binreqpost{
  int? docentry;
  String? docdate;
  String? whscode;
  String? itemcode;
  String? itemname;
  String? serialbatch;
  String? frombin;
  String? tobin;
  String? quantity;
  String? devicecode;
  Binreqpost({
    required this.devicecode,
    required this.docdate,
    required this.docentry,
    required this.frombin,
    required this.itemcode,
    required this.itemname,
    required this.quantity,
    required this.serialbatch,
    required this.tobin,
    required this.whscode,

  });

   Map<String, dynamic> tojson(){
     Map<String, dynamic> map ={
      "docentry": docentry,
    "docdate": "$docdate",
    "whscode": "$whscode",
    "itemcode": "$itemcode",
    "itemname": "$itemname",
    "serialbatch": "$serialbatch",
    "frombin": "$frombin",
    "tobin": "$tobin",
    "quantity": "$quantity",
    "devicecode": "$devicecode"
     };
     return map;
   }
}