import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/home%20cubit/states.dart';
import 'package:kayish/blocs/layout%20cubit/layout_cubit.dart';
import 'package:kayish/blocs/layout%20cubit/layout_states.dart';
import 'package:kayish/modules/account_verification_request_screen.dart';
import 'package:kayish/modules/notification_settings.dart';
import 'package:kayish/modules/result_of_transaction.dart';
import 'package:kayish/modules/settings_screen.dart';
import 'package:kayish/modules/sort_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/notifications/local_notification.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/active_bottom_button.dart';
import 'package:kayish/widgets/drawer.dart';

import 'aboutUs_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'package:overlay_support/overlay_support.dart';

class LayoutScreen extends StatelessWidget {
  int? pageNumber;
  LayoutScreen({this.pageNumber});

  @override
  Widget build(BuildContext context) {
    //********************** onMessage ******************************
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      switch (message.data['state']) {
        case '2':
          navigateTo(
              context: context,
              nextScreen: ResultOfTransactionScreen(
                state: 2,
              ));
          break;
        case '-2':
          navigateTo(
              context: context,
              nextScreen: ResultOfTransactionScreen(
                state: -2,
              ));
          break;
        case '1':
          HomeCubit.get(context)
              .getHomeData(
                  cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0)
              .then((value) {
            navigateAndFinish(
                context: context, nextScreen: AccountVerificationRequest());
          });

          break;
        case '-1':
          HomeCubit.get(context)
              .getHomeData(
                  cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0)
              .then((value) {
            navigateAndFinish(
                context: context, nextScreen: AccountVerificationRequest());
          });

          break;
        case '3':
          MainLayoutCubit.get(context).increaseCount();
      }
    });

    //********************** onMessageOpenedApp ******************************
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      switch (message.data['state']) {
        case '2':
          navigateTo(
              context: context,
              nextScreen: ResultOfTransactionScreen(
                state: 2,
              ));
          break;
        case '-2':
          navigateTo(
              context: context,
              nextScreen: ResultOfTransactionScreen(
                state: -2,
              ));
          break;
        case '1':
          HomeCubit.get(context)
              .getHomeData(
                  cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0)
              .then((value) {
            navigateTo(
                context: context, nextScreen: AccountVerificationRequest());
          });
          break;
        case '-1':
          HomeCubit.get(context)
              .getHomeData(
                  cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0)
              .then((value) {
            navigateAndFinish(
                context: context, nextScreen: AccountVerificationRequest());
          });
          break;
        case '3':
          navigateAndFinish(
              context: context,
              nextScreen: LayoutScreen(
                pageNumber: 2,
              ));
      }
    });
    CasheHelper.putData(key: 'screen name', value: 'null');
    var cubit = MainLayoutCubit.get(context);
    var width = MediaQuery.of(context).size.width;
    if (pageNumber == 1) {
      cubit.currentIndex = 0;
    }
    if (pageNumber == 2) {
      cubit.currentIndex = 1;
    }
    if (pageNumber == 3) {
      cubit.currentIndex = 2;
    }
    if (pageNumber == 4) {
      cubit.currentIndex = 3;
    }
    GlobalKey<ScaffoldState> layoutKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<MainLayoutCubit, MainLayoutStates>(
      listener: (context, state) {
        if (state is CheckInternetConnectedState) {
          HomeCubit.get(context).getHomeData(
              cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0);
        }
      },
      builder: (context, state) {
        return Scaffold(
            key: layoutKey,
            appBar: AppBar(
              leadingWidth: 80,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: ColorManager.primary),
              title: Text(
                titles(context)[cubit.currentIndex],
                style: appBarTitle,
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  layoutKey.currentState!.openDrawer();
                },
              ),
              actions: [
                actions(context)[cubit.currentIndex],
              ],
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
            ),
            body: screens()[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset.fromDirection(1)),
              ]),
              child: BottomAppBar(
                notchMargin: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                        minWidth: width * .2,
                        child: cubit.currentIndex == 0
                            ? ActiveButton(
                                icon: 'icons/home.png', label: 'Main')
                            : const Image(
                                image: AssetImage('icons/home.png'),
                                color: ColorManager.primary,
                                height: 20,
                                width: 20,
                              ),
                        onPressed: () {
                          HomeCubit.get(context)
                              .getHomeData(
                            cityId: 0,
                            regionId: 0,
                            districtId: 0,
                            realStateTypeId: 0,
                          )
                              .then((value) async {
                            cubit.changeCurrentIndex(0);
                            print(
                                'my token is ${CasheHelper.getData(key: token)}');
                          });
                        }),
                    MaterialButton(
                        minWidth: width * .18,
                        child: cubit.currentIndex == 1
                            ? ActiveButton(
                                icon: 'icons/notification.png',
                                label: 'Notifications')
                            : Stack(
                                children: [
                                  const Image(
                                    image: AssetImage('icons/notification.png'),
                                    color: ColorManager.primary,
                                    height: 20,
                                    width: 20,
                                  ),
                                  if (cubit.notificationCount != 0)
                                    CircleAvatar(
                                      radius: 6,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        cubit.notificationCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                        onPressed: () {
                          cubit.changeCurrentIndex(1);
                          cubit.resetNotificationCount();
                        }),
                    MaterialButton(
                        minWidth: width * .18,
                        child: cubit.currentIndex == 2
                            ? ActiveButton(
                                icon: 'icons/settings.png', label: 'Settings')
                            : const Image(
                                image: AssetImage('icons/settings.png'),
                                color: ColorManager.primary,
                                height: 20,
                                width: 20,
                              ),
                        onPressed: () {
                          cubit.changeCurrentIndex(2);
                        }),
                    MaterialButton(
                        minWidth: width * .18,
                        child: cubit.currentIndex == 3
                            ? FittedBox(
                                child: ActiveButton(
                                    icon: 'icons/about_us.png',
                                    label: 'About us'),
                              )
                            : const Image(
                                image: AssetImage('icons/about_us.png'),
                                color: ColorManager.primary,
                                height: 18,
                                width: 18,
                              ),
                        onPressed: () {
                          cubit.changeCurrentIndex(3);
                        }),
                  ],
                ),
              ),
            ),
            drawer: MyDrawer());
      },
    );
  }

  //layout titles
  List<String> titles(context) {
    var localization = AppLocalization.of(context);
    List<String> titles = [
      localization.translate('Main')!,
      localization.translate('Notifications')!,
      localization.translate('Settings')!,
      localization.translate('About us')!
    ];
    return titles;
  }

  //layout screens
  List<Widget> screens() {
    List<Widget> screens = [
      HomeScreen(),
      NotificationScreen(),
      SettingsScreen(),
      AboutUsScreen()
    ];
    return screens;
  }

  //layout actions
  List<Widget> actions(context) {
    List<Widget> actions = [
      Padding(
        padding: const EdgeInsetsDirectional.only(end: 16),
        child: IconButton(
          icon: const Image(
            image: AssetImage('icons/sort.png'),
            width: 20,
            height: 20,
          ),
          onPressed: () {
            navigateTo(context: context, nextScreen: SortScreen());
          },
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(end: 16),
        child: IconButton(
          icon: const Image(
            image: AssetImage('icons/notification_settings.png'),
            width: 20,
            height: 20,
          ),
          onPressed: () {
            navigateTo(context: context, nextScreen: NotificationSettingS());
          },
        ),
      ),
      Container(),
      Container(),
    ];
    return actions;
  }
}
