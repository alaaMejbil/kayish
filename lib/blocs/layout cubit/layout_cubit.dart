import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

import 'layout_states.dart';

class MainLayoutCubit extends Cubit<MainLayoutStates> {
  MainLayoutCubit() : super(InitialMainLayoutState());

  static MainLayoutCubit get(context) => BlocProvider.of(context);

  int notificationCount = 0;
  int currentIndex = 0;
  bool? hasNetwork = false;

  // change bottom bar current index
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomBarState());
  }

  void increaseCount() {
    notificationCount++;
    emit(IncreaseNotificationCountLayoutState());
  }

  void resetNotificationCount() {
    notificationCount = 0;
    emit(ResetNotificationCountLayoutState());
  }

  void checkInternetConnection() {
    InternetConnectionChecker().hasConnection.then((value) {
      if (value == true) {
        showSimpleNotification(const Text('connected'),
            background: Colors.green,
            duration: const Duration(seconds: 3),
            leading: const Icon(
              Icons.check,
              color: Colors.white,
            ));
      } else {
        showSimpleNotification(const Text(' not connected'),
            background: Colors.red,
            duration: const Duration(seconds: 3),
            leading: const Icon(
              Icons.error,
              color: Colors.white,
            ));
      }
    });
  }

  void listenOnNetwork() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      print('===>>>>===>>>>$event');

      if (event == InternetConnectionStatus.disconnected) {
        showSimpleNotification(
          const Text('no internet connection'),
          background: Colors.red,
        );
        emit(CheckInternetConnectedState());
      }
    });
  }
}
