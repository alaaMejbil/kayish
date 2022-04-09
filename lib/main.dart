import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kayish/shared/component/date_functions.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/local/secure_helper.dart';

import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/shared/notifications/local_notification.dart';
import 'package:kayish/shared/notifications/sound_controller.dart';
import 'package:kayish/utils/utils.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'blocs/bloc observer/bloc_observer.dart';
import 'modules/app.dart';
import 'package:rxdart/rxdart.dart';

void listenNotifications() =>
    NotificationApi.onNotifications.stream.listen(onClickedNotification);

void onClickedNotification(String? payload) {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcmToken: $fcmToken');
  await CasheHelper.init();
  //NotificationApi.init();
  //listenNotifications();
  Bloc.observer = MyBlocObserver();
  DioHelper.init('https://icrcompany.net/keyesh/public/api/');
  await SecureHelper.getInstance();
  FirebaseMessaging.onMessage.listen((event) {
    print('******************* onMessage Notification **********************');
    // Fluttertoast.showToast(
    //   msg: event.notification!.body.toString(),
    // );
    showSimpleNotification(
      Text(
        event.notification!.title.toString(),
      ),
      leading: Image.asset(
        'images/appLogo.png',
        width: 30,
      ),
      subtitle: Text(event.notification!.body.toString()),
      slideDismiss: true,
      duration: const Duration(seconds: 2),
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      background: Colors.white,
    );
    SoundController.playSound();
    // Get.snackbar(
    //   event.notification!.title.toString(),
    //   event.notification!.body.toString(),
    //   onTap: (e) {
    //     Get.to(() => const OrderScreen());
    //   },
    //   duration: const Duration(
    //     seconds: 5,
    //   ),
    //   colorText: SchedulerBinding.instance!.window.platformBrightness ==
    //           Brightness.dark
    //       ? Colors.white
    //       : Colors.black,
    //   backgroundColor: SchedulerBinding.instance!.window.platformBrightness ==
    //           Brightness.dark
    //       ? Colors.black
    //       : Colors.white,
    // );
  });

// onMessageOpenedApp
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //Get.to(()=> const OrderScreen());
  });

  // onBackgroundMessage
  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    await Firebase.initializeApp();
    //  Get.snackbar(message.notification!.title!, message.notification!.body!);
  });
  print(
      "time now is : ${DateTime.fromMillisecondsSinceEpoch(1648228454554 - 1000000).difference(DateTime.now()).inMinutes > 0 ? DateTime.fromMillisecondsSinceEpoch(1648228454554 - 1000000).difference(DateTime.now()).inMinutes : "Finished !"} Min");

  runApp(App());
}
