import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static int counter = 0;
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> showNotification({
    String? state,
    String? title,
    String? body,
    String? payload,
  }) async {
    await notifications.show(counter, title, body, await notificationsDetails(),
        payload: payload);
    counter++;
  }

  static NotificationDetails notificationsDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel description',
          playSound: true,
          ongoing: true,
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init() async {
    final android = AndroidInitializationSettings('@mipmap/kaysh');
    final Ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: Ios);

    await notifications.initialize(settings,
        onSelectNotification: (String? payload) async {
      onNotifications.add(payload);
      print(payload);
      //  return payload;
    });

    // const InitializationSettings initializationSettings =
    //     InitializationSettings(
    //         android: AndroidInitializationSettings('@mipmap/kaysh'));
    //
    // notificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: (String? payload) async {
    //   if (payload != null) {}
    // });
  }
}
