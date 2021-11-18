import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool initScheduled = false}) async {
    tz.initializeTimeZones();
    
    var androidInitializationSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitializationSettings = IOSInitializationSettings();
    var setting = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _notification.initialize(setting,
      onSelectNotification: (payload) {
        log(
          '============================== onSelectNotification: $payload',
        );
      }
    );
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    int id = 0,
    String? payload,}) async => _notification.show(id, title, body, await _notificationDetails(), payload: payload);

  static Future showScheduledNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    int id = 0,
    String? payload,}) async =>
    _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

  static Future cancelAllScheduledNotification() async => await _notification.cancelAll();

  static Future _notificationDetails() async {
    var androidNotificationDetail = AndroidNotificationDetails('channelId', 'channelName', channelDescription: 'channelDescription', importance: Importance.max);
    var iosNotificationDetail = IOSNotificationDetails();

    return NotificationDetails(android: androidNotificationDetail, iOS: iosNotificationDetail);
  }
}