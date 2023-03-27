import 'package:one_project/module/attendance_module.dart';
import 'package:sqflite/sql.dart';
import 'package:dio/dio.dart';

import '../util/local_db/localDb.dart';

class AttendanceService {
  AttendanceService._();

  static late final Dio dio;

  static void configDio() {
    dio = Dio()
      ..options.baseUrl = 'https://demo.ast.com.ph'
      ..options.headers = {'Content-Type': 'application/json'};
  }

  static insertAttendance(Attendance attendance) async {
    final db = await DBProvider.db.database;
    if (db == null) return;
    var res = await db.insert(
        DBProvider.attendanceTableName, attendance.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  // refactor so that it queries only attendance with no end time
  static Future<Attendance?> getActiveAttendance() async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    var res = await db.query(DBProvider.attendanceTableName,
        where: "isActive = ?", whereArgs: [true]);
    return res.isNotEmpty ? Attendance.fromJson(res.first) : null;
  }

  static Future<List<Attendance>?> getAttendanceHistory() async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    var res = await db.query(DBProvider.attendanceTableName,
        where: "isActive = ?", whereArgs: [false]);
    return res.isNotEmpty
        ? (res.map((e) => Attendance.fromJson(e)).toList()).reversed.toList()
        : [];
  }

  static Future<List<Attendance>?> getAllAttendance() async {
    final db = await DBProvider.db.database;
    if (db == null) return null;

    var res = await db.query(DBProvider.attendanceTableName);

    return res.isNotEmpty
        ? res.map((e) => Attendance.fromJson(e)).toList().reversed.toList()
        : [];
  }

  static Future<List<Attendance>> getAllAttendanceIsNotSynced() async {
    final db = await DBProvider.db.database;
    if (db == null) return [];
    var res = await db.query(DBProvider.attendanceTableName,
        where: "isSynced = ?", whereArgs: [0]);
    return res.map((e) => Attendance.fromJson(e)).toList();
  }

  // static Future<Response> postAttendanceRequest(Attendance attendance) {
  //   var formData = FormData.fromMap({
  //     'deviceId': '1',
  //     'deviceCode': 'afi_ast',
  //     'token':
  //         "\$2y\$10\$Gae33.BuN\/e1NLiYNw0.f.2g6Bi30Hkcas\/ra0n\/2gugauby6Pcd2",
  //     'accountId': '3',
  //     'type': 'Time-in - Time out',
  //     'date': '${attendance.date} ${attendance.startTime}',
  //     // 'startTime': attendance.startTime,
  //     // 'endTime': attendance.endTime,
  //     // 'currentLocationAddressStart': attendance.currentLocationAddressStart,
  //     // 'currentLocationAddressEnd': attendance.currentLocationAddressEnd,
  //   });
  //   return dio.post('/api/devices/attendance/store', data: formData);
  // }

  static Future<Response> postAttendanceRequest(Attendance attendance) {
    var formData = FormData.fromMap({
      'deviceId': '1',
      'deviceCode': 'afi_ast',
      'token':
          "\$2y\$10\$Gae33.BuN\/e1NLiYNw0.f.2g6Bi30Hkcas\/ra0n\/2gugauby6Pcd2",
      'accountId': 3,
      'time': '${attendance.date} ${attendance.startTime}',
      'endtime': attendance.endTime,
      'startAddress': attendance.currentLocationAddressStart,
      'endAddress': attendance.currentLocationAddressEnd,
    });
    return dio.post('/api/devices/attendance/store', data: formData);
  }

  static updateAttendance(Attendance attendance) async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    var res = await db.update(
        DBProvider.attendanceTableName, attendance.toJson(),
        where: "id = ?", whereArgs: [attendance.id]);
    return res;
  }

  static deleteAttendance(DateTime startDate, DateTime endDate) async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    final startTimestamp = startDate.millisecondsSinceEpoch;
    final endTimestamp = endDate.millisecondsSinceEpoch;
    await db.delete(
      DBProvider.attendanceTableName,
      where: "timestamp >= ? AND timestamp <= ? AND isSynced = ?",
      whereArgs: [startTimestamp, endTimestamp, 1],
    );
  }
  //pag sav

//new

  // static Future<List<Attendance>> getAllAttendanceIsNotSynced() async {
  //   final db = await DBProvider.db.database;
  //   if (db == null) return [];
  //   var res = await db.query(DBProvider.attendanceTableName,
  //       where: "isSynced = ?", whereArgs: [0]);
  //   return res.map((e) => Attendance.fromJson(e)).toList();
  // }

  // static Future<Response> postAttendanceRequest(Attendance attendance) {
  //   var formData = FormData.fromMap({
  //     'deviceId': '1',
  //     'deviceCode': 'afi_ast',
  //     'token':
  //         "\$2y\$10\$Gae33.BuN\/e1NLiYNw0.f.2g6Bi30Hkcas\/ra0n\/2gugauby6Pcd2",
  //     'accountId': 1,
  //     'time': '${attendance.date} ${attendance.startTime}',
  //     'img': attendance.imgStart
  //   });

  //   return dio.post('/api/devices/attendance/store', data: formData);
  // }
}
