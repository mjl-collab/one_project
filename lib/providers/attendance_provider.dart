import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_project/util/common/attendance_util.dart';
import 'package:one_project/services/attendance.service.dart';
import 'package:one_project/util/common/common_util.dart';
import 'package:one_project/util/common/notification_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:one_project/module/attendance_module.dart';

class AttendanceProvider with ChangeNotifier {
  Attendance? latestAttendance;
  bool isLoading = false;
  bool isLoadingSync = false;

  List<Attendance> _attendanceRequest = []; // list Attendance
  List<Attendance> _attendanceHistory = [];

  Attendance? _currentDayAttendance;

  List<Attendance> get attendanceRequest => _attendanceRequest;
  List<Attendance> get attendanceHistory => _attendanceHistory;

  Attendance? get currentDayAttendance => _currentDayAttendance;

  bool? get isCheckedIn => _currentDayAttendance?.isActive;

  void clearCurrentDay() {
    _currentDayAttendance = null;
    //notifyListeners();
  }

  Future<void> createCurrentDayAttendance() async {
    final now = DateTime.now();
    if (await Permission.locationWhenInUse.request().isGranted) {
      final results = await Future.wait<dynamic>(
          [AttendanceUtil.getCurrentCoords(), getImageFromCamera()]);

      final locationAndAddress = results[0];

      final image = await results[1];

      Attendance activeAttendance = Attendance(
        id: CommonUtil.generateId(),
        date: CommonUtil.convertDateDDMMYYYY(now),
        dayName: CommonUtil.getDayName(now),
        startTime: CommonUtil.getHHmmss(now),
        currentLocationAddressStart: locationAndAddress[1],
        currentLocationCoords: locationAndAddress[0],
        imgStart: image,
        isActive: true,
        isSynced: false,
      );

      _currentDayAttendance = activeAttendance;
      isLoading = true;
      notifyListeners();

      saveAttendance(activeAttendance);
      notifyListeners();
      showToast('Starting the time');

      //Post Attendance
    }
  }

  Future<void> endCurrentAttendance() async {
    final now = DateTime.now();
    if (await Permission.locationWhenInUse.request().isGranted) {
      final attendance = await AttendanceService.getActiveAttendance();

      if (attendance == null) return;
      final imgEnd = await getImageFromCamera();
      attendance.endTime = CommonUtil.getHHmmss(now);
      attendance.imgEnd = imgEnd;
      attendance.isActive = false;
      _currentDayAttendance = attendance;

      try {
        final result =
            await AttendanceService.postAttendanceRequest(attendance);
        if (result.statusCode == 200 || result.statusCode == 201) {
          attendance.isSynced = true;
        }
      } catch (e) {
        showToast('Post attendance failed');
      } finally {
        await saveAttendance(attendance);
        NotificationHandler.cancelRepeatNotification();
        notifyListeners();
        showToast('Ending the time');
      }
    }
  }

  Future<void> getTodayAttendance() async {
    _currentDayAttendance = await AttendanceService.getActiveAttendance();
    notifyListeners();
  }

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }

  Future<void> saveAttendance(Attendance newAttendance) async {
    AttendanceService.insertAttendance(newAttendance);
    notifyListeners();
  }

  getAttendanceRequest() async {
    _attendanceRequest = await AttendanceService.getAllAttendance() ?? [];
    notifyListeners();
  }

  getAttendanceHistory() async {
    _attendanceHistory = await AttendanceService.getAttendanceHistory() ?? [];
    notifyListeners();
  }

  Future<String?> getImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 200,
        maxWidth: 200,
        preferredCameraDevice: CameraDevice.rear);
    if (image == null) return null;
    final imageBytes = File(image.path).readAsBytesSync();
    String img64 = base64Encode(imageBytes);
    return img64;
  }

  void checkDate() {
    if (_currentDayAttendance == null) return;
    final now = DateTime.now();
    final startTime =
        CommonUtil.convertDDMMYYtoDate(_currentDayAttendance!.date);
    if (!CommonUtil.isSameDay(now, startTime)) {
      clearCurrentDay();
      getTodayAttendance();
      NotificationHandler.cancelRepeatNotification();
    }
  }

  void checkShowRepeatNotification(Timer timer) async {
    await getTodayAttendance();
    final now = DateTime.now();
    if (_currentDayAttendance != null &&
        _currentDayAttendance?.endTime == null &&
        now.isAfter(DateTime(
            now.year,
            now.month,
            now.day,
            NotificationHandler.dailyNotificationHour,
            NotificationHandler.dailyNotificationMinutes))) {
      NotificationHandler.showRepeatNofitication();
      timer.cancel();
    }
  }

  void sync() async {
    isLoadingSync = true;
    notifyListeners();

    final listAttendanceNotSynced =
        await AttendanceService.getAllAttendanceIsNotSynced();
    final listPostApi = <Future>[];

    for (var attendance in listAttendanceNotSynced) {
      listPostApi.add(AttendanceService.postAttendanceRequest(attendance));
    }

    try {
      await Future.wait(listPostApi);
      for (var attendance in listAttendanceNotSynced) {
        attendance.isSynced = true;
        await AttendanceService.updateAttendance(attendance);
      }

      await getAttendanceHistory();
      await getAttendanceRequest();

      showToast('Sync attendance completed');
    } on Exception catch (e) {
      showToast('Sync failed');

      throw Exception(e.toString());
    } finally {
      isLoadingSync = false;
      notifyListeners();
    }
  }

  //Detect the time_change_detector
}
