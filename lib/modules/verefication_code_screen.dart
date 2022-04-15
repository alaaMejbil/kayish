import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kayish/blocs/code%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/code%20verification%20cubit/states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/blocs/sign%20in%20cubit/cubit.dart';
import 'package:kayish/blocs/sign%20in%20cubit/states.dart';
import 'package:kayish/modules/home_screen.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/terms_and_conditions.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/date_functions.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';

import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/default_form_field.dart';

import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/widgets/defualt_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../blocs/sign up cubit/cubit.dart';
import 'login_screen.dart';

class MobileVerification extends StatelessWidget {
  Widget build(BuildContext context) {
    // CountdownTimerController timerController = CountdownTimerController(
    //   endTime: DateTime.now().millisecondsSinceEpoch + (30 * 1000),
    // );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var localization = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => VerificationCodeCubit()..initialTimer(),
      child: BlocConsumer<VerificationCodeCubit, VerificationCodeStates>(
        listener: (context, state) {
          if (state is VerificationCodeSuccessfulState) {
            navigateAndFinish(
                context: context,
                nextScreen: LayoutScreen(
                  pageNumber: 1,
                ));
            HomeCubit.get(context).getHomeData(
                cityId: 0, regionId: 0, districtId: 0, realStateTypeId: 0);
          } else if (state is VerificationCodeErrorState) {
            Fluttertoast.showToast(
                msg: AppLocalization.of(context).translate('Invalid code')!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = VerificationCodeCubit.get(context);
          var cubit2 = SignUpCubit();

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        height: 150,
                        width: 150,
                        image: AssetImage(
                          'images/ver_icon.png',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DefaultText(
                        myText: localization.translate('Verification code')!,
                        style: Styles.getBoldMainTextStyle(
                            color: Colors.black, fontSize: FontSize.s22),
                        alignment: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DefaultText(
                        myText: localization.translate(
                            'We will send you a verification code to the phone number you entered')!,
                        style: Styles.getMidMainTextStyle(
                            color: Colors.black, fontSize: FontSize.s16),
                        alignment: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: PinCodeTextField(
                          autoDisposeControllers: false,
                          focusNode: FocusNode(
                            canRequestFocus: true,
                          ),
                          enablePinAutofill: false,
                          controller: cubit.pinController,
                          cursorHeight: 20,
                          cursorColor: Colors.white,
                          enableActiveFill: true,
                          autoDismissKeyboard: true,
                          appContext: context,
                          length: 6,
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.light,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          pinTheme: PinTheme.defaults(
                              selectedColor: Colors.grey,
                              inactiveColor: ColorManager.primary,
                              activeColor: Colors.grey,
                              activeFillColor: ColorManager.primary,
                              selectedFillColor: ColorManager.primary,
                              inactiveFillColor: ColorManager.primary,
                              fieldOuterPadding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 45,
                              fieldWidth: 40,
                              shape: PinCodeFieldShape.box),
                          mainAxisAlignment: MainAxisAlignment.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalization.of(context)
                                  .translate('Please enter your pin code');
                            }
                            return null;
                          },
                          onCompleted: (value) {
                            cubit.insureCodeVerification(
                              phoneNumber:
                                  CasheHelper.getData(key: 'phoneNumber'),
                              smsCode: value,
                              verificationId:
                                  CasheHelper.getData(key: 'verificationToken'),
                            );
                            // save this account in DB
                            cubit2.signUp(
                                phoneNumber:
                                    CasheHelper.getData(key: 'phoneNumber'),
                                emailAddress:
                                    CasheHelper.getData(key: 'email'));
                          },
                        ),
                      ),
                      if (state is TimeFinishedState)
                        BlocProvider(
                          create: (context) => SignInCubit(),
                          child: BlocConsumer<SignInCubit, LoginStates>(
                            listener: (context, state) {
                              if (state is LoginSuccessfulState) {
                                navigateAndFinish(
                                    context: context,
                                    nextScreen: MobileVerification());
                              }
                            },
                            builder: (context, state) {
                              if (state is! LoginLoadingState) {
                                return TextButton(
                                  child: DefaultText(
                                    myText: AppLocalization.of(context)
                                        .translate('Resend verification code'),
                                    style: const TextStyle(
                                      color: ColorManager.primary,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    SignInCubit.get(context)
                                        .sendCodeVerification(
                                            mobileNumber: CasheHelper.getData(
                                                key: 'phoneNumber'));
                                  },
                                );
                              } else {
                                return MyCircularPrograssIndicator();
                              }
                            },
                          ),
                        ),
                      if (state is VerificationCodeInitialState ||
                          state is VerificationCodeErrorState)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(
                              myText: AppLocalization.of(context)
                                  .translate('Resend verification code'),
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CountdownTimer(
                              controller: cubit.timerController,
                              onEnd: () {
                                print('ali');
                              },
                              widgetBuilder:
                                  (context, CurrentRemainingTime? time) {
                                if (time == null) {
                                  return const Text('00,00');
                                }
                                return Text(
                                  '${time.min ?? '00'} :${time.sec! >= 10 ? time.sec : '0${time.sec!}'}',
                                  textDirection: TextDirection.ltr,
                                );
                              },
                            ),
                          ],
                        ),
                      if (state is VerificationCodeLoadingState)
                        const SizedBox(
                          height: 30,
                        ),
                      if (state is VerificationCodeLoadingState)
                        const CircularProgressIndicator(),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
