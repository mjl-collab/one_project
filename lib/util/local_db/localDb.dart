import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  static String attendanceTableName = 'Attendance';

  Future<Database?> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}Attendance_management1.db";
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        createTables(db);
      },
    );
  }

  void createTables(Database db) async {
    await db.execute("CREATE TABLE $attendanceTableName ("
        "id TEXT PRIMARY KEY,"
        "date TEXT,"
        "dayName TEXT,"
        "startTime TEXT,"
        "imgStart TEXT,"
        "endTime TEXT,"
        "imgEnd TEXT,"
        "currentLocationAddressStart TEXT,"
        "currentLocationCoords TEXT,"
        "currentLocationAddressEnd TEXT,"
        "currentLocationCoordsEnd TEXT,"
        "isActive INTEGER,"
        "isSynced INTEGER"
        ")");
  }
}
