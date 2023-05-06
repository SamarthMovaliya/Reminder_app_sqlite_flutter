import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  NotificationHelper._();

  static final NotificationHelper notificationHelper = NotificationHelper._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // TODO :initlialize

  void NotificationInitialize() {
    //
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    //
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestSoundPermission: true,
            defaultPresentAlert: true,
            defaultPresentBadge: true,
            requestBadgePermission: true,
            defaultPresentSound: true);

    //
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      print('----------------');
      print('${details.payload}');
      print('----------------');
    });
  }

// TODO :Simple

  SimpleNotification() async {
    //
    print('hello');
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('1', 'dummy Simple Notification');
    //
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    //
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    //
    await flutterLocalNotificationsPlugin.show(234, 'Simple Notification',
        'This is Simple Notification', notificationDetails,
        payload: 'This Is Simple Notification');
    print('hello');
  }

  // TODO: ScheduledNotification
  ScheduledNotification() async {
    //
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('1', 'dummy Simple Notification');
    //
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    //
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    //
    //  await flutterLocalNotificationsPlugin.zonedSchedule();
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String description,
    required String scheduleTime,
  }) async {
    DateTime d = DateTime.parse(scheduleTime) as DateTime;
    tz.Location location = tz.local;
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      tz.TZDateTime.from(d, tz.local),
      const NotificationDetails(
        // Android details
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: "ashwin",
            importance: Importance.max,
            priority: Priority.max),
        // iOS details
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation
              .absoluteTime, //To show notification even when the app is closed
    );
  }
}
