

   
   
   const String tablebatch = "wmsputbatch";

class Columnsbatch{
 static const String docEntry = "DocEntry";
 static const String docNum = "DocNum";
 static const String item_LineNum = "Item_LineNum";
 static const String serialBatch_LineNum = "SerialBatch_LineNum";
 static const String autoID = "AutoID";
 static const String supplierCode = "SupplierCode";
 static const String supplierName = "SupplierName";
 static const String whsCode = "WhsCode";
 static const String itemCode = "ItemCode";
 static const String itemName = "ItemName";
 static const String unit_Quantity = "Unit_Quantity";
 static const String serialBatchCode = "SerialBatchCode";
 static const String serialBatchQty = "SerialBatchQty";
 static const String putaway_Qty = "Putaway_Qty";
 static const String open_Putaway = "Open_Putaway";
 static const String manageBy = "ManageBy";
 static const String isselected = "Isselected";
 static const String isdone = "Isdone";
 static const String localbincode = "Localbincode";
 static const String docDate = "DocDate";
 static const String pref_Bin = "Pref_Bin";
 static const String binCode = "BinCode";
 static const String binQty = "BinQty";
 static const String tagText = "TagText";
 static const String inwardType = "InwardType";


}

class BatchDBlist{
  int? ID;
  int? DocEntry;
 int? DocNum;
 int? Item_LineNum;
 int? SerialBatch_LineNum;
 int? AutoID;
 String? InwardType;
 String? SupplierCode;
 String? SupplierName;
 String? WhsCode;
 String? ItemCode;
 String? ItemName;
 double? Unit_Quantity;
 String? SerialBatchCode;
double? SerialBatchQty;
double? Putaway_Qty;
double? Open_Putaway;
String? ManageBy;
bool? isselected;
bool? isdone;
String? localbincode;
String? DocDate;
String? Pref_Bin;
String? BinCode;
double? BinQty;
String? TagText;
BatchDBlist({
   this.ID,
required this.BinCode,
  required this.BinQty,
  required this.TagText,
  required this.Pref_Bin,
  required this.DocDate,
  required this.Item_LineNum,
  required this.SerialBatch_LineNum,
  required this.isselected,
  required this.isdone,
  required this.AutoID,
  required this.DocEntry,
  required this.DocNum,
  required this.InwardType,
  required this.ItemCode,
  required this.ItemName,
  required this.ManageBy,
  required this.Open_Putaway,
  required this.Putaway_Qty,
  required this.SerialBatchCode,
  required this.SerialBatchQty,
  required this.SupplierCode,
  required this.SupplierName,
  required this.Unit_Quantity,
  required this.WhsCode,
  required this.localbincode
});
Map<String , Object?> toMap()=>{
  Columnsbatch.docEntry:DocEntry,
  Columnsbatch.docNum:DocNum,
  Columnsbatch.item_LineNum:Item_LineNum,
  Columnsbatch.serialBatch_LineNum:SerialBatch_LineNum,
  Columnsbatch.autoID:AutoID,
  Columnsbatch.inwardType:InwardType,
  Columnsbatch.supplierCode:SupplierCode,
  Columnsbatch.supplierName:SupplierName,
  Columnsbatch.manageBy:ManageBy,
  Columnsbatch.whsCode:WhsCode,
  Columnsbatch.itemCode:ItemCode,
  Columnsbatch.itemName:ItemName,
  Columnsbatch.unit_Quantity:Unit_Quantity,
  Columnsbatch.serialBatchCode:SerialBatchCode,
  Columnsbatch.serialBatchQty:SerialBatchQty,
  Columnsbatch.putaway_Qty:Putaway_Qty,
  Columnsbatch.open_Putaway:Open_Putaway,
  Columnsbatch.isselected:isselected,
  Columnsbatch.isdone:isdone,
  Columnsbatch.localbincode:localbincode,
  Columnsbatch.docDate:DocDate,
  Columnsbatch.pref_Bin:Pref_Bin,
  Columnsbatch.binCode:BinCode,
  Columnsbatch.binQty:BinQty,
  Columnsbatch.tagText:TagText,
 
};


}