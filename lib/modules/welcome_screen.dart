import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kayish/blocs/app%20cubit/app_cubit.dart';
import 'package:kayish/blocs/app%20cubit/app_states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/login_screen.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/defualt_text.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CasheHelper.putData(key: 'screen name', value: 'welcome');
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('icons/lang.png'),
                      width: 25,
                    ),
                    const SizedBox(width: 16),
                    BlocConsumer<AppCubit, AppStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return FlutterSwitch(
                          height: 25,
                          width: 45,
                          toggleColor: Colors.grey[50]!,
                          activeColor: ColorManager.yellow,
                          onToggle: (value) {
                            AppCubit.get(context).changeLang(value);
                          },
                          value: CasheHelper.getData(key: 'isArabic') ?? true,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    if (CasheHelper.getData(key: 'isArabic') == false)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, top: 4),
                        child: Text(
                          'English',
                          style: Styles.getBoldMainTextStyle(
                              color: Colors.black, fontSize: FontSize.s18),
                        ),
                      ),
                    if (CasheHelper.getData(key: 'isArabic') == true ||
                        CasheHelper.getData(key: 'isArabic') == null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, top: 4),
                        child: Text(
                          'عربي',
                          style: Styles.getBoldMainTextStyle(
                              color: Colors.black, fontSize: FontSize.s18),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const Image(
                  height: 200,
                  width: double.infinity,
                  image: AssetImage('images/welcome.png'),
                ),
                const SizedBox(
                  height: 22,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: AppLocalization.of(context).translate('With'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).translate('Kish'),
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'GE',
                          fontWeight: FontWeight.w700,
                          color: ColorManager.primary),
                    ),
                    TextSpan(
                      text: AppLocalization.of(context)
                          .translate('You can now buy your property within'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).translate('45'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).translate('minutes'),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 100,
                ),
                DefaultButton(
                  onPressed: () {
                    CasheHelper.putData(key: 'first', value: true);
                    navigateAndFinish(
                        context: context, nextScreen: LoginScreen());
                  },
                  text: 'Sign Up',
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultButton(
                  onPressed: () {
                    CasheHelper.putData(key: 'first', value: true);
                    navigateAndFinish(
                        context: context, nextScreen: LayoutScreen());
                    HomeCubit.get(context).getHomeData(
                        realStateTypeId: 0,
                        districtId: 0,
                        regionId: 0,
                        cityId: 0);
                  },
                  text: 'Browse the app',
                  buttonColor: Colors.white,
                  textColor: ColorManager.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convert(String val) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const india = [
      '٠',
      '١',
      '٢',
      '٣',
      '٤',
      '٥',
      '٦',
      '٧',
      '٨',
      '٩',
    ];

    for (int i = 0; i < english.length; i++) {
      val = val.replaceAll(india[i], english[i]);
    }
    return val;
  }
}
