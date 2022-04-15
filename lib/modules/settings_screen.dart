import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/logout%20cubit/cubit.dart';
import 'package:kayish/blocs/logout%20cubit/states.dart';
import 'package:kayish/modules/lang_settings.dart';
import 'package:kayish/modules/login_screen.dart';
import 'package:kayish/modules/profile__screen.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/local/secure_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/build_list_tile.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'notification_settings.dart';

class SettingsScreen extends StatelessWidget {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.unlocked,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: BlocConsumer<LogoutCubit, LogoutStates>(
        listener: (context, state) {
          if (state is LogoutSuccessfulState) {
            Alert(
                context: context,
                image: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('icons/back_pop_up.png'),
                ),
                title: AppLocalization.of(context)
                    .translate('Signed out successfully'),
                style: AlertStyle(
                  buttonsDirection: ButtonsDirection.column,
                  alertBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  titleStyle: Styles.getMidMainTextStyle(
                      color: Colors.grey.shade600, fontSize: FontSize.s16),
                ),
                buttons: [
                  DialogButton(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ColorManager.primary),
                      child: Text(
                        AppLocalization.of(context).translate('Done')!,
                        style: Styles.getBoldMainTextStyle(
                            color: Colors.white, fontSize: FontSize.s18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    radius: BorderRadius.circular(25),
                    height: 50,
                  ),
                ]).show();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.lightGrey,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        BuildListTile(
                          icon: Icons.person_outline,
                          title: 'Profile',
                          onTap: () {
                            if (CasheHelper.getData(key: token) != null) {
                              navigateTo(
                                  context: context,
                                  nextScreen: ProfileScreen());
                            } else {
                              Alert(
                                  context: context,
                                  image: const Image(
                                    height: 40,
                                    width: 40,
                                    image: AssetImage('icons/back_pop_up.png'),
                                  ),
                                  title: AppLocalization.of(context)
                                      .translate('You must Register first'),
                                  style: AlertStyle(
                                    buttonsDirection: ButtonsDirection.column,
                                    alertBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    titleStyle: Styles.getMidMainTextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: FontSize.s16),
                                  ),
                                  buttons: [
                                    DialogButton(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: ColorManager.primary),
                                        child: Text(
                                          AppLocalization.of(context)
                                              .translate('Sign Up')!,
                                          style: Styles.getBoldMainTextStyle(
                                              color: Colors.white,
                                              fontSize: FontSize.s18),
                                        ),
                                      ),
                                      onPressed: () {
                                        navigateTo(
                                            context: context,
                                            nextScreen: SignUpScreen());
                                      },
                                      radius: BorderRadius.circular(25),
                                      height: 50,
                                    ),
                                    DialogButton(
                                      child: Container(
                                        child: Text(
                                          AppLocalization.of(context)
                                              .translate('Later')!,
                                          style: Styles.getBoldMainTextStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s18),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      radius: BorderRadius.circular(25),
                                      height: 50,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorManager.primary),
                                    ),
                                  ]).show();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 2,
                            color: Colors.grey[300],
                          ),
                        ),
                        BuildListTile(
                          icon: Icons.language_outlined,
                          title: 'Language Setting',
                          onTap: () {
                            navigateTo(
                                context: context, nextScreen: LangSettings());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 2,
                            color: Colors.grey[300],
                          ),
                        ),
                        BuildListTile(
                          icon: Icons.notifications_none,
                          title: 'Notification Settings',
                          onTap: () {
                            navigateTo(
                                context: context,
                                nextScreen: NotificationSettingS());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                if (CasheHelper.getData(key: token) != null)
                  if (state is! LogoutLoadingStateState)
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: DefaultButton(
                        text: 'Logout',
                        width: double.infinity,
                        textColor: Colors.white,
                        buttonColor: ColorManager.primary,
                        onPressed: () {
                          HomeCubit.get(context).getHomeData(
                              cityId: 0,
                              regionId: 0,
                              districtId: 0,
                              realStateTypeId: 0);
                          LogoutCubit.get(context).logout();
                        },
                      ),
                    ),
                if (CasheHelper.getData(key: token) != null)
                  if (state is LogoutLoadingStateState)
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
