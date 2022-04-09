import 'package:flutter/material.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/modules/Institution_account_screen.dart';
import 'package:kayish/modules/aboutUs_screen.dart';
import 'package:kayish/modules/account_verfication_screen.dart';
import 'package:kayish/modules/account_verification_request_screen.dart';
import 'package:kayish/modules/finished_deals.dart';
import 'package:kayish/modules/finished_deals_details.dart';
import 'package:kayish/modules/incoming_deals.dart';

import 'package:kayish/modules/individual_account.dart';
import 'package:kayish/modules/lang_settings.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/login_screen.dart';
import 'package:kayish/modules/my_auction_screen.dart';
import 'package:kayish/modules/notification_settings.dart';
import 'package:kayish/modules/deals_details_screen.dart';
import 'package:kayish/modules/on_going_deals_screen.dart';
import 'package:kayish/modules/profile__screen.dart';
import 'package:kayish/modules/result_of_transaction.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/modules/terms_and_conditions.dart';
import 'package:kayish/modules/welcome_screen.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';

// name of screens
String? screenName;

void navigateTo({
  required context,
  required nextScreen,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );

void navigateAndFinish({
  required context,
  required nextScreen,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false,
    );

void navigateAndBackHome({
  required context,
  required nextScreen,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => true,
    );

void navigateToLast(context) {
  if (CasheHelper.getData(key: 'screen name') == 'sign up') {
    navigateAndFinish(context: context, nextScreen: SignUpScreen());
  } else if (CasheHelper.getData(key: 'screen name') ==
      'terms and conditions') {
    navigateAndFinish(context: context, nextScreen: TermsAndConditionsScreen());
  } else if (CasheHelper.getData(key: 'screen name') == 'welcome') {
    navigateAndFinish(context: context, nextScreen: WelcomeScreen());
  } else if (CasheHelper.getData(key: 'screen name') == 'login') {
    navigateAndFinish(context: context, nextScreen: LoginScreen());
  } else {
    navigateAndFinish(context: context, nextScreen: LayoutScreen());
    HomeCubit.get(context)
        .getHomeData(cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0);
  }
}
