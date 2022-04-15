import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kayish/blocs/code%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/home%20cubit/states.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/modules/deals_details_screen.dart';
import 'package:kayish/modules/finished_deals.dart';
import 'package:kayish/modules/notification_screen.dart';
import 'package:kayish/modules/on_going_deals_screen.dart';
import 'package:kayish/modules/result_of_transaction.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/alert.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/date_functions.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/local/secure_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/alert_button.dart';

import 'package:kayish/widgets/circular_prograss_indicator.dart';

import 'package:kayish/widgets/enable_button.dart';
import 'package:kayish/widgets/head_item.dart';
import 'package:kayish/widgets/unit_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:transparent_image/transparent_image.dart';

import 'account_verfication_screen.dart';
import 'account_verification_request_screen.dart';
import 'incoming_deals.dart';

import 'layout_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessfulState) {
          ProfileCubit.get(context).getProfile();
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => !cubit.isLoading,
            widgetBuilder: (context) => cubit.homeModel != null
                ? Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 16, bottom: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: height * .30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: const Image(
                                  image: AssetImage('images/main_image.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: HeadItem(
                              head: 'Ongoing Deals',
                              onTab: () {
                                if (CasheHelper.getData(key: isNotRegister) ==
                                    true) {
                                  Alert(
                                      context: context,
                                      image: const Image(
                                        height: 40,
                                        width: 40,
                                        image:
                                            AssetImage('icons/back_pop_up.png'),
                                      ),
                                      title: AppLocalization.of(context).translate(
                                          'You must register and verify the account before adding any bid'),
                                      style: AlertStyle(
                                        buttonsDirection:
                                            ButtonsDirection.column,
                                        alertBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              style:
                                                  Styles.getBoldMainTextStyle(
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
                                              style:
                                                  Styles.getBoldMainTextStyle(
                                                      color:
                                                          ColorManager.primary,
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
                                } else {
                                  navigateTo(
                                      context: context,
                                      nextScreen: OnGoingDealsScreen());
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (cubit.homeModel!.data!.currentAuctions.isNotEmpty)
                            Container(
                              height: 448,
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 16, end: 4),
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cubit.homeModel!.data!
                                        .currentAuctions.length,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        if (CasheHelper.getData(
                                                key: isNotRegister) ==
                                            true) {
                                          Alert(
                                              context: context,
                                              image: const Image(
                                                height: 40,
                                                width: 40,
                                                image: AssetImage(
                                                    'icons/back_pop_up.png'),
                                              ),
                                              title: AppLocalization.of(context)
                                                  .translate(
                                                      'You must register and verify the account before adding any bid'),
                                              style: AlertStyle(
                                                buttonsDirection:
                                                    ButtonsDirection.column,
                                                alertBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                titleStyle:
                                                    Styles.getMidMainTextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontSize: FontSize.s16),
                                              ),
                                              buttons: [
                                                DialogButton(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: ColorManager
                                                            .primary),
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Sign Up')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    navigateTo(
                                                        context: context,
                                                        nextScreen:
                                                            SignUpScreen());
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                ),
                                                DialogButton(
                                                  child: Container(
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate('Later')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  ColorManager
                                                                      .primary,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          ColorManager.primary),
                                                ),
                                              ]).show();
                                        } else if (CasheHelper.getData(
                                                key: isLogin) ==
                                            true) {
                                          Alert(
                                              context: context,
                                              image: const Image(
                                                height: 40,
                                                width: 40,
                                                image: AssetImage(
                                                    'icons/back_pop_up.png'),
                                              ),
                                              title: AppLocalization.of(context)
                                                  .translate(
                                                      'You must verify the account before adding any bid'),
                                              style: AlertStyle(
                                                buttonsDirection:
                                                    ButtonsDirection.column,
                                                alertBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                titleStyle:
                                                    Styles.getMidMainTextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontSize: FontSize.s16),
                                              ),
                                              buttons: [
                                                DialogButton(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: ColorManager
                                                            .primary),
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Account Verification')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    navigateTo(
                                                        context: context,
                                                        nextScreen:
                                                            AccountVerification());
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                ),
                                                DialogButton(
                                                  child: Container(
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate('Later')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  ColorManager
                                                                      .primary,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          ColorManager.primary),
                                                ),
                                              ]).show();
                                        } else if (CasheHelper.getData(
                                                key: isNotVerified) ==
                                            true) {
                                          Alert(
                                              context: context,
                                              image: const Image(
                                                height: 40,
                                                width: 40,
                                                image: AssetImage(
                                                    'icons/back_pop_up.png'),
                                              ),
                                              title: AppLocalization.of(context)
                                                  .translate(
                                                      'You must verify the account before adding any bid'),
                                              style: AlertStyle(
                                                buttonsDirection:
                                                    ButtonsDirection.column,
                                                alertBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                titleStyle:
                                                    Styles.getMidMainTextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontSize: FontSize.s16),
                                              ),
                                              buttons: [
                                                DialogButton(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: ColorManager
                                                            .primary),
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Account Verification')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    navigateTo(
                                                        context: context,
                                                        nextScreen:
                                                            AccountVerification());
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                ),
                                                DialogButton(
                                                  child: Container(
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate('Later')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  ColorManager
                                                                      .primary,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          ColorManager.primary),
                                                ),
                                              ]).show();
                                        } else {
                                          // if Auctions Not Finish
                                          if (cubit
                                                          .homeModel!
                                                          .data!
                                                          .currentAuctions[
                                                              index]
                                                          .endTime! *
                                                      1000 -
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch >
                                              0) {
                                            navigateTo(
                                                context: context,
                                                nextScreen: DealsDetailsScreen(
                                                    auctionId: cubit
                                                        .homeModel!
                                                        .data!
                                                        .currentAuctions[index]
                                                        .id!));
                                          } else {
                                            // if Auctions Not Finish
                                            navigateTo(
                                                context: context,
                                                nextScreen:
                                                    ResultOfTransactionScreen());
                                          }
                                        }
                                      },
                                      child: UnitItem(
                                        onFollowTab: () {
                                          if (!CasheHelper.getData(
                                              key: isVerified)) {
                                            MyAlert.myAlert(
                                                context: context,
                                                title:
                                                    'Please register and verify your account before proceeding with any auction',
                                                assetImage:
                                                    'icons/back_pop_up.png',
                                                buttons: [
                                                  DialogButton(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: ColorManager
                                                              .primary),
                                                      child: Text(
                                                        AppLocalization.of(
                                                                context)
                                                            .translate(CasheHelper
                                                                        .getData(
                                                                            key:
                                                                                isLogin) ||
                                                                    CasheHelper
                                                                        .getData(
                                                                            key:
                                                                                isNotVerified)
                                                                ? 'Account Verification'
                                                                : 'Sign Up')!,
                                                        style: Styles
                                                            .getBoldMainTextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    FontSize
                                                                        .s18),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      if (CasheHelper.getData(
                                                              key: isLogin) ||
                                                          CasheHelper.getData(
                                                              key:
                                                                  isNotVerified)) {
                                                        if (CasheHelper.getData(
                                                            key: isLogin)) {
                                                          navigateTo(
                                                              context: context,
                                                              nextScreen:
                                                                  AccountVerification());
                                                        } else if (CasheHelper
                                                            .getData(
                                                                key:
                                                                    isNotVerified)) {
                                                          navigateAndFinish(
                                                              context: context,
                                                              nextScreen:
                                                                  AccountVerificationRequest());
                                                        } else {
                                                          print('verifid');
                                                        }
                                                      } else if (CasheHelper
                                                          .getData(
                                                              key:
                                                                  isNotRegister)) {
                                                        navigateTo(
                                                            context: context,
                                                            nextScreen:
                                                                SignUpScreen());
                                                      } else {
                                                        print('verified');
                                                      }
                                                    },
                                                    radius:
                                                        BorderRadius.circular(
                                                            25),
                                                    height: 50,
                                                  ),
                                                  DialogButton(
                                                    child: Container(
                                                      child: Text(
                                                        AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'Later')!,
                                                        style: Styles
                                                            .getBoldMainTextStyle(
                                                                color:
                                                                    ColorManager
                                                                        .primary,
                                                                fontSize:
                                                                    FontSize
                                                                        .s18),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    radius:
                                                        BorderRadius.circular(
                                                            25),
                                                    height: 50,
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorManager
                                                            .primary),
                                                  ),
                                                ]);
                                          } else {
                                            // toggle follow in this item
                                            cubit.followedList[cubit
                                                    .homeModel!
                                                    .data!
                                                    .currentAuctions[index]
                                                    .id!] =
                                                !cubit.followedList[cubit
                                                    .homeModel!
                                                    .data!
                                                    .currentAuctions[index]
                                                    .id!]!;

                                            cubit.addFollow(cubit.homeModel!
                                                .data!.nextAuctions[index].id!);
                                          }
                                        },
                                        screenType: 1,
                                        inComing: true,
                                        auctionId: cubit.homeModel!.data!
                                            .currentAuctions[index].id,
                                        width: width * .75,
                                        image: cubit
                                            .homeModel!
                                            .data!
                                            .currentAuctions[index]
                                            .realestateImage,
                                        follow:
                                            true, // show follow button ? yes
                                        followState: cubit.homeModel!.data!
                                            .currentAuctions[index].followed!,
                                        title: cubit
                                            .homeModel!
                                            .data!
                                            .currentAuctions[index]
                                            .realestateTitle,
                                        auctionsNumber: cubit.homeModel!.data!
                                            .currentAuctions[index].dealId
                                            .toString(),
                                        isFinished: true, // ??
                                        live: true,
                                        fromTime: false, //??
                                        time: '12:5', // ??
                                        distance: cubit
                                            .homeModel!
                                            .data!
                                            .currentAuctions[index]
                                            .realestateSpace
                                            .toString(),
                                        location:
                                            '${cubit.homeModel!.data!.currentAuctions[index].realestateCity}-${cubit.homeModel!.data!.currentAuctions[index].realestateReigon}',
                                        price: '2532422',
                                        status: AppLocalization.of(context)
                                            .translate('Running now'),
                                        unitType: cubit
                                            .homeModel!
                                            .data!
                                            .currentAuctions[index]
                                            .realestateType,
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 16,
                                    ),
                                  )),
                            ),
                          if (cubit.homeModel!.data!.currentAuctions.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorManager.primary),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                    child: Text(AppLocalization.of(context)
                                        .translate('No auctions')!)),
                              ),
                            ),
                          /*
                          *
                          *
                          *
                          *
                          *
                          ***** 'Upcoming Deals' ******
                          *
                          *
                          *
                          *
                          *
                          */
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: HeadItem(
                              head: 'Upcoming Deals',
                              onTab: () {
                                if (CasheHelper.getData(key: isNotRegister) ==
                                    true) {
                                  Alert(
                                      context: context,
                                      image: const Image(
                                        height: 40,
                                        width: 40,
                                        image:
                                            AssetImage('icons/back_pop_up.png'),
                                      ),
                                      title: AppLocalization.of(context).translate(
                                          'You must register and verify the account before adding any bid'),
                                      style: AlertStyle(
                                        buttonsDirection:
                                            ButtonsDirection.column,
                                        alertBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              style:
                                                  Styles.getBoldMainTextStyle(
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
                                              style:
                                                  Styles.getBoldMainTextStyle(
                                                      color:
                                                          ColorManager.primary,
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
                                } else {
                                  navigateTo(
                                      context: context,
                                      nextScreen: UpComingDealsScreen());
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (cubit.homeModel!.data!.nextAuctions.isNotEmpty)
                            Container(
                              height: 448,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 16, end: 4),
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      if (CasheHelper.getData(
                                              key: isNotRegister) ==
                                          true) {
                                        Alert(
                                            context: context,
                                            image: const Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'icons/back_pop_up.png'),
                                            ),
                                            title: AppLocalization.of(context)
                                                .translate(
                                                    'You must register and verify the account before adding any bid'),
                                            style: AlertStyle(
                                              buttonsDirection:
                                                  ButtonsDirection.column,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              titleStyle:
                                                  Styles.getMidMainTextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: FontSize.s16),
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          ColorManager.primary),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Sign Up')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  navigateTo(
                                                      context: context,
                                                      nextScreen:
                                                          SignUpScreen());
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                              ),
                                              DialogButton(
                                                child: Container(
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Later')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorManager.primary),
                                              ),
                                            ]).show();
                                      } else if (CasheHelper.getData(
                                              key: isLogin) ==
                                          true) {
                                        Alert(
                                            context: context,
                                            image: const Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'icons/back_pop_up.png'),
                                            ),
                                            title: AppLocalization.of(context)
                                                .translate(
                                                    'You must verify the account before adding any bid'),
                                            style: AlertStyle(
                                              buttonsDirection:
                                                  ButtonsDirection.column,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              titleStyle:
                                                  Styles.getMidMainTextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: FontSize.s16),
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          ColorManager.primary),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate(
                                                            'Account Verification')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  navigateTo(
                                                      context: context,
                                                      nextScreen:
                                                          AccountVerification());
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                              ),
                                              DialogButton(
                                                child: Container(
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Later')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorManager.primary),
                                              ),
                                            ]).show();
                                      } else if (CasheHelper.getData(
                                              key: isNotVerified) ==
                                          true) {
                                        Alert(
                                            context: context,
                                            image: const Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'icons/back_pop_up.png'),
                                            ),
                                            title: AppLocalization.of(context)
                                                .translate(
                                                    'You must verify the account before adding any bid'),
                                            style: AlertStyle(
                                              buttonsDirection:
                                                  ButtonsDirection.column,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              titleStyle:
                                                  Styles.getMidMainTextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: FontSize.s16),
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          ColorManager.primary),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate(
                                                            'Account Verification')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  navigateTo(
                                                      context: context,
                                                      nextScreen:
                                                          AccountVerification());
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                              ),
                                              DialogButton(
                                                child: Container(
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Later')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorManager.primary),
                                              ),
                                            ]).show();
                                      } else {
                                        navigateTo(
                                          context: context,
                                          nextScreen: DealsDetailsScreen(
                                              auctionId: cubit.homeModel!.data!
                                                  .nextAuctions[index].id!),
                                        );
                                      }
                                    },
                                    child: UnitItem(
                                      onFollowTab: () {
                                        print(
                                            '!CasheHelper.getData(key: isVerified) ====>${!CasheHelper.getData(key: isVerified)}');
                                        if (!CasheHelper.getData(
                                            key: isVerified)) {
                                          MyAlert.myAlert(
                                              context: context,
                                              title:
                                                  'Please register and verify your account before proceeding with any auction',
                                              assetImage:
                                                  'icons/back_pop_up.png',
                                              buttons: [
                                                DialogButton(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: ColorManager
                                                            .primary),
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate(CasheHelper
                                                                      .getData(
                                                                          key:
                                                                              isLogin) ||
                                                                  CasheHelper
                                                                      .getData(
                                                                          key:
                                                                              isNotVerified)
                                                              ? 'Account Verification'
                                                              : 'Sign Up')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    if (CasheHelper.getData(
                                                            key: isLogin) ||
                                                        CasheHelper.getData(
                                                            key:
                                                                isNotVerified)) {
                                                      if (CasheHelper.getData(
                                                          key: isLogin)) {
                                                        navigateTo(
                                                            context: context,
                                                            nextScreen:
                                                                AccountVerification());
                                                      } else if (CasheHelper
                                                          .getData(
                                                              key:
                                                                  isNotVerified)) {
                                                        navigateAndFinish(
                                                            context: context,
                                                            nextScreen:
                                                                AccountVerificationRequest());
                                                      } else {
                                                        print('verifid');
                                                      }
                                                    } else if (CasheHelper
                                                        .getData(
                                                            key:
                                                                isNotRegister)) {
                                                      navigateTo(
                                                          context: context,
                                                          nextScreen:
                                                              SignUpScreen());
                                                    } else {
                                                      print('verified');
                                                    }
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                ),
                                                DialogButton(
                                                  child: Container(
                                                    child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .translate('Later')!,
                                                      style: Styles
                                                          .getBoldMainTextStyle(
                                                              color:
                                                                  ColorManager
                                                                      .primary,
                                                              fontSize:
                                                                  FontSize.s18),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  height: 50,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          ColorManager.primary),
                                                ),
                                              ]);
                                        } else {
                                          // toggle follow in this item
                                          cubit.followedList[cubit
                                                  .homeModel!
                                                  .data!
                                                  .nextAuctions[index]
                                                  .id!] =
                                              !cubit.followedList[cubit
                                                  .homeModel!
                                                  .data!
                                                  .nextAuctions[index]
                                                  .id!]!;
                                          cubit.addFollow(cubit.homeModel!.data!
                                              .nextAuctions[index].id!);
                                        }
                                      },
                                      screenType: 1,
                                      inComing: true,
                                      auctionId: cubit.homeModel!.data!
                                          .nextAuctions[index].id,
                                      width: width * .75,
                                      image: cubit.homeModel!.data!
                                          .nextAuctions[index].realestateImage,
                                      borderColor: ColorManager.primary,
                                      statusColor: ColorManager.primary,
                                      follow: true,
                                      followState: cubit.homeModel!.data!
                                          .nextAuctions[index].followed,
                                      title: cubit.homeModel!.data!
                                          .nextAuctions[index].realestateTitle,
                                      auctionsNumber: cubit.homeModel!.data!
                                          .nextAuctions[index].dealId
                                          .toString(),
                                      isFinished: true,
                                      time: '12:5',
                                      distance: cubit.homeModel!.data!
                                          .nextAuctions[index].realestateSpace
                                          .toString(),
                                      location:
                                          '${cubit.homeModel!.data!.nextAuctions[index].realestateCity} - ${cubit.homeModel!.data!.nextAuctions[index].realestateReigon}',
                                      price: '2532422',
                                      // status: nextAuctionLeftTime(
                                      //     context: context,
                                      //     adTime: cubit.homeModel!.data!
                                      //         .nextAuctions[index].startTime!),
                                      // status: AppLocalization.of(context)
                                      //     .translate('start soon')!,
                                      status: cubit.homeModel!.data!
                                          .nextAuctions[index].calTime
                                          .toString(),
                                      unitType: cubit.homeModel!.data!
                                          .nextAuctions[index].realestateType,
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 16,
                                  ),
                                  itemCount: cubit
                                      .homeModel!.data!.nextAuctions.length,
                                ),
                              ),
                            ),
                          if (cubit.homeModel!.data!.nextAuctions.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorManager.primary),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                    child: Text(AppLocalization.of(context)
                                        .translate('No auctions')!)),
                              ),
                            ),
                          /*
                          *
                          *
                          *
                          *
                          *
                          *
                          * * * *  'Finished deals'
                          *
                          *
                          *
                          *
                          *
                          *
                          * */
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: HeadItem(
                              head: 'Finished deals',
                              onTab: () {
                                if (CasheHelper.getData(key: isNotRegister) ==
                                    true) {
                                  Alert(
                                      context: context,
                                      image: const Image(
                                        height: 40,
                                        width: 40,
                                        image:
                                            AssetImage('icons/back_pop_up.png'),
                                      ),
                                      title: AppLocalization.of(context).translate(
                                          'You must register and verify the account before adding any bid'),
                                      style: AlertStyle(
                                        buttonsDirection:
                                            ButtonsDirection.column,
                                        alertBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              style:
                                                  Styles.getBoldMainTextStyle(
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
                                              style:
                                                  Styles.getBoldMainTextStyle(
                                                      color:
                                                          ColorManager.primary,
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
                                } else {
                                  navigateTo(
                                      context: context,
                                      nextScreen: FinishedDealsScreen());
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (cubit.homeModel!.data!.doneAuctions.isNotEmpty)
                            Container(
                              height: 438,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 16, end: 4),
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      print(CasheHelper.getData(
                                          key: isNotRegister));
                                      if (CasheHelper.getData(
                                              key: isNotRegister) ==
                                          true) {
                                        Alert(
                                            context: context,
                                            image: const Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'icons/back_pop_up.png'),
                                            ),
                                            title: AppLocalization.of(context)
                                                .translate(
                                                    'You must register and verify the account before adding any bid'),
                                            style: AlertStyle(
                                              buttonsDirection:
                                                  ButtonsDirection.column,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              titleStyle:
                                                  Styles.getMidMainTextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: FontSize.s16),
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          ColorManager.primary),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Sign Up')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  navigateTo(
                                                      context: context,
                                                      nextScreen:
                                                          SignUpScreen());
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                              ),
                                              DialogButton(
                                                child: Container(
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Later')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorManager.primary),
                                              ),
                                            ]).show();
                                      } else if (CasheHelper.getData(
                                              key: isLogin) ==
                                          true) {
                                        Alert(
                                            context: context,
                                            image: const Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'icons/back_pop_up.png'),
                                            ),
                                            title: AppLocalization.of(context)
                                                .translate(
                                                    'You must verify the account before adding any bid'),
                                            style: AlertStyle(
                                              buttonsDirection:
                                                  ButtonsDirection.column,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              titleStyle:
                                                  Styles.getMidMainTextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: FontSize.s16),
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          ColorManager.primary),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate(
                                                            'Account Verification')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  navigateTo(
                                                      context: context,
                                                      nextScreen:
                                                          AccountVerification());
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                              ),
                                              DialogButton(
                                                child: Container(
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Later')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorManager.primary),
                                              ),
                                            ]).show();
                                      } else if (CasheHelper.getData(
                                              key: isNotVerified) ==
                                          true) {
                                        Alert(
                                            context: context,
                                            image: const Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'icons/back_pop_up.png'),
                                            ),
                                            title: AppLocalization.of(context)
                                                .translate(
                                                    'You must verify the account before adding any bid'),
                                            style: AlertStyle(
                                              buttonsDirection:
                                                  ButtonsDirection.column,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              titleStyle:
                                                  Styles.getMidMainTextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: FontSize.s16),
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          ColorManager.primary),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate(
                                                            'Account Verification')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  navigateTo(
                                                      context: context,
                                                      nextScreen:
                                                          AccountVerification());
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                              ),
                                              DialogButton(
                                                child: Container(
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate('Later')!,
                                                    style: Styles
                                                        .getBoldMainTextStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize:
                                                                FontSize.s18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                radius:
                                                    BorderRadius.circular(25),
                                                height: 50,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorManager.primary),
                                              ),
                                            ]).show();
                                      } else {
                                        navigateTo(
                                            context: context,
                                            nextScreen: DealsDetailsScreen(
                                                auctionId: cubit
                                                    .homeModel!
                                                    .data!
                                                    .doneAuctions[index]
                                                    .id!));
                                      }
                                    },
                                    child: UnitItem(
                                      screenType: 1,
                                      auctionId: cubit.homeModel!.data!
                                          .doneAuctions[index].id,
                                      image: cubit.homeModel!.data!
                                          .doneAuctions[index].realestateImage,
                                      width: width * .75,
                                      borderColor: Colors.grey.shade600,
                                      statusColor: Colors.grey.shade600,
                                      follow: false, //??
                                      title: cubit.homeModel!.data!
                                          .doneAuctions[index].realestateTitle,
                                      auctionsNumber: cubit.homeModel!.data!
                                          .doneAuctions[index].dealId
                                          .toString(),
                                      isFinished: true,
                                      time: '12:5',
                                      fromTime: false,
                                      distance: cubit.homeModel!.data!
                                          .doneAuctions[index].realestateSpace
                                          .toString(),
                                      location:
                                          '${cubit.homeModel!.data!.doneAuctions[index].realestateCity}-${cubit.homeModel!.data!.doneAuctions[index].realestateReigon}',
                                      price: cubit.homeModel!.data!
                                          .doneAuctions[index].maximum
                                          .toString(),
                                      status: AppLocalization.of(context)
                                          .translate('Finished'),
                                      unitType: cubit.homeModel!.data!
                                          .doneAuctions[index].realestateType,
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 16,
                                  ),
                                  itemCount: cubit
                                      .homeModel!.data!.doneAuctions.length,
                                ),
                              ),
                            ),
                          if (cubit.homeModel!.data!.doneAuctions.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorManager.primary),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                    child: Text(AppLocalization.of(context)
                                        .translate('No auctions')!)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      AppLocalization.of(context).translate('No content')!,
                      style: Styles.getBoldMainTextStyle(
                          color: Colors.black, fontSize: FontSize.s20),
                    ),
                  ),
            fallbackBuilder: (context) =>
                Center(child: MyCircularPrograssIndicator()),
          ),
        );
      },
    );
  }
}
