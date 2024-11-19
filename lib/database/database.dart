

// class DriftMaster extends Table {
 
//   IntColumn get IMid => integer().autoIncrement()();
//   IntColumn get docEntry => integer().named("DocEntry").nullable()();
//   TextColumn get binCode => text().named("BinCode").nullable()();
//   TextColumn get barCode => text().named("BarCode").nullable()();
//   TextColumn get whsCode => text().named("WhsCode").nullable()();
//   TextColumn get areaCode => text().named("AreaCode").nullable()();
//   TextColumn get zoneCode => text().named("ZoneCode").nullable()();
//   TextColumn get rackCode => text().named("RackCode").nullable()();
//   RealColumn get volume => text().named("Volume").nullable()();
//   RealColumn get capacity => integer().named("Capacity").nullable()();
//   TextColumn get capacityUoM => real().named("CapacityUoM").nullable()();
//   RealColumn get length => real().named("Length").nullable()();
//   RealColumn get width => real().named("Width").nullable()();
//   RealColumn get height => real().named("Height").nullable()();
//   IntColumn get CreatedBy => text().named("CreatedBy").nullable()();
//   TextColumn get createdOn => text().named("CreatedOn").nullable()();
//   IntColumn get updatedBy => text().named("UpdatedBy").nullable()();
//   TextColumn get updatedOn => text().named("UpdatedOn").nullable()();
//   TextColumn get status => text().named("Status").nullable()();
//   TextColumn get whsName => text().named("WhsName").nullable()();
//   TextColumn get traceid => text().named("traceid").nullable()();
  
  
  
//   @override String get tableName => 'driftbin_master';
// }

// @DriftDatabase(tables: [DriftBinMaster])
// class AppDatabase extends _$AppDatabase {
//    AppDatabase(QueryExecutor e) : super(e);

//   @override
//   int get schemaVersion => 1;
//   static AppDatabase? _instance;
//   static AppDatabase get instance {
//     if (_instance == null) {
//       throw Exception("AppDatabase not initialized. Call AppDatabase.initialize() first.");
//     }
//     return _instance!;
//   }
//     static Future<AppDatabase?> initialize() async {
//     if (_instance == null) {
//  final directory = await getApplicationDocumentsDirectory();
//     final path = join(directory.path, 'db.sqlite');

//     _instance = AppDatabase(NativeDatabase(File(path)));
//     }

   
//    return _instance;
//   }
// }