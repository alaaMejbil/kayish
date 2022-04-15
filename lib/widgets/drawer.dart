import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/modules/How_it_work.dart';
import 'package:kayish/modules/account_verfication_screen.dart';
import 'package:kayish/modules/account_verification_request_screen.dart';
import 'package:kayish/modules/contact_us.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/my_auction_screen.dart';
import 'package:kayish/modules/notification_screen.dart';
import 'package:kayish/modules/settings_screen.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../modules/account_verification_request_screen.dart';
import '../shared/component/navigate_functions.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizaton = AppLocalization.of(context);
    return Drawer(
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
            child: Center(
              child: Image(
                height: 120,
                width: 150,
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (CasheHelper.getData(key: token) != null) {
                if (HomeCubit.get(context).homeModel!.data!.userStatus == 1 ||
                    HomeCubit.get(context).homeModel!.data!.userStatus == '1') {
                  navigateTo(
                      context: context, nextScreen: AccountVerification());
                } else {
                  navigateAndFinish(
                      context: context,
                      nextScreen: AccountVerificationRequest());
                }
              } else {
                Alert(
                    context: context,
                    image: const Image(
                      height: 40,
                      width: 40,
                      image: AssetImage('icons/back_pop_up.png'),
                    ),
                    title: AppLocalization.of(context).translate(
                        'You must register and verify the account before adding any bid'),
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
                            AppLocalization.of(context).translate('Sign Up')!,
                            style: Styles.getBoldMainTextStyle(
                                color: Colors.white, fontSize: FontSize.s18),
                          ),
                        ),
                        onPressed: () {
                          navigateTo(
                              context: context, nextScreen: SignUpScreen());
                        },
                        radius: BorderRadius.circular(25),
                        height: 50,
                      ),
                      DialogButton(
                        child: Container(
                          child: Text(
                            AppLocalization.of(context).translate('Later')!,
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
                        border: Border.all(color: ColorManager.primary),
                      ),
                    ]).show();
              }
            },
            title: Text(
              localizaton.translate('Account Verification')!,
              style: Styles.getMidMainTextStyle(
                  color: Colors.black, fontSize: FontSize.s16),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Image(
                image: AssetImage('icons/verfied.png'),
                height: 20,
                width: 20,
              ),
            ),
            horizontalTitleGap: 0,
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text(
              localizaton.translate('My auctions')!,
              style: Styles.getMidMainTextStyle(
                  color: Colors.black, fontSize: FontSize.s16),
            ),
            leading: const Image(
              image: AssetImage('icons/mzadaty.png'),
              height: 20,
              width: 20,
            ),
            onTap: () {
              if (CasheHelper.getData(key: token) != null) {
                navigateTo(context: context, nextScreen: MyAuctionScreen());
              } else {
                Alert(
                    context: context,
                    image: const Image(
                      height: 40,
                      width: 40,
                      image: AssetImage('icons/back_pop_up.png'),
                    ),
                    title: AppLocalization.of(context).translate(
                        'You must register and verify the account before adding any bid'),
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
                            AppLocalization.of(context).translate('Sign Up')!,
                            style: Styles.getBoldMainTextStyle(
                                color: Colors.white, fontSize: FontSize.s18),
                          ),
                        ),
                        onPressed: () {
                          navigateTo(
                              context: context, nextScreen: SignUpScreen());
                        },
                        radius: BorderRadius.circular(25),
                        height: 50,
                      ),
                      DialogButton(
                        child: Container(
                          child: Text(
                            AppLocalization.of(context).translate('Later')!,
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
                        border: Border.all(color: ColorManager.primary),
                      ),
                    ]).show();
              }
            },
          ),
          ListTile(
              onTap: () {
                navigateTo(context: context, nextScreen: AboutAppScreen());
              },
              horizontalTitleGap: 0,
              title: Text(
                localizaton.translate('how do we work')!,
                style: Styles.getMidMainTextStyle(
                    color: Colors.black, fontSize: FontSize.s16),
              ),
              leading: const Image(
                image: AssetImage('icons/how to work.png'),
                height: 20,
                width: 20,
              )),
          ListTile(
              onTap: () {
                navigateTo(context: context, nextScreen: ContactUs());
              },
              horizontalTitleGap: 0,
              title: Text(
                localizaton.translate('Contact Us')!,
                style: Styles.getMidMainTextStyle(
                    color: Colors.black, fontSize: FontSize.s16),
              ),
              leading: const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Image(
                  image: AssetImage('icons/contacct us.png'),
                  height: 20,
                  width: 20,
                ),
              )),
          if (CasheHelper.getData(key: token) == null)
            ListTile(
              horizontalTitleGap: 0,
              title: Text(
                localizaton.translate('Sign Up')!,
                style: Styles.getMidMainTextStyle(
                    color: Colors.black, fontSize: FontSize.s16),
              ),
              leading: const Icon(
                Icons.app_registration,
                size: 20,
              ),
              onTap: () {
                navigateTo(context: context, nextScreen: SignUpScreen());
              },
            ),
        ],
      ),
    );
  }
}
