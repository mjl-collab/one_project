import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHandler {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const int repeatNotiId = 2;
  static const dailyNotificationHour = 4;
  static const dailyNotificationMinutes = 30;

  static Future<void> setUpNotification() async {
    tz.initializeTimeZones();
    final localTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimeZone));
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    if (await Permission.notification.request().isGranted) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      const initializationSettingsDarwin = DarwinInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsDarwin);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
  }

  static void showNotificationDaily() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'daily scheduled notification title',
      'daily scheduled notification body',
      _nextInstanceOf425PM(),
      const NotificationDetails(
        android: AndroidNotificationDetails('attendance_management_channel_id',
            'attendance_management_channel_name',
            channelDescription: 'attendance_management_channel_description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOf425PM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, dailyNotificationHour, dailyNotificationMinutes);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> showRepeatNofitication() async {
    var id = repeatNotiId;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('attendance_management hourly channel id',
            'attendance_management hourly channel name',
            channelDescription: 'attendance_management hourly description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        'repeating hourly title',
        'repeating hourly body',
        RepeatInterval.everyMinute,
        notificationDetails,
        androidAllowWhileIdle: true);
  }

  static void cancelRepeatNotification() {
    flutterLocalNotificationsPlugin.cancel(repeatNotiId);
  }
}
