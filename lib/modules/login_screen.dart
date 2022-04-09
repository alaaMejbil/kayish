import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kayish/blocs/sign%20in%20cubit/cubit.dart';
import 'package:kayish/blocs/sign%20in%20cubit/states.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/modules/terms_and_conditions.dart';
import 'package:kayish/modules/verefication_code_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/notifications/local_notification.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/default_form_field.dart';
import 'package:kayish/widgets/defualt_text.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CasheHelper.putData(key: 'screen name', value: 'login');

    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessfulState) {
            navigateTo(context: context, nextScreen: MobileVerification());
          } else if (state is CodeNotSentState) {
            Alert(
                context: context,
                type: AlertType.warning,
                image: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('icons/back_pop_up.png'),
                ),
                title:
                    '${AppLocalization.of(context).translate('Something wrong')}',
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
                      child: Text(
                        AppLocalization.of(context).translate('Back')!,
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
          } else if (state is LoginErrorDataInputState) {
            Alert(
                context: context,
                type: AlertType.warning,
                image: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('icons/back_pop_up.png'),
                ),
                title: '${SignInCubit.get(context).loginModel!.message}',
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
                      child: Text(
                        AppLocalization.of(context).translate('Back')!,
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
          } else if (state is LoginNumberNotExistDataInputState) {
            Alert(
                context: context,
                type: AlertType.error,
                image: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('icons/back_pop_up.png'),
                ),
                title: AppLocalization.of(context)
                    .translate('This number is not registered')!,
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
                      child: Text(
                        AppLocalization.of(context).translate('Back')!,
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
        builder: (context, state) {
          var cubit = SignInCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.lightGrey,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: []),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      height: 150,
                      width: 180,
                      image: AssetImage('images/logo.png'),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset.zero),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 30),
                            child: Form(
                              key: formKey2,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultText(
                                      myText: AppLocalization.of(context)
                                          .translate('Login'),
                                      style: Styles.getBoldMainTextStyle(
                                          color: Colors.black,
                                          fontSize: FontSize.s22),
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    DefaultFormField(
                                      astric: false,
                                      inputFormatter: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      inputType: TextInputType.number,
                                      hintText: '0x55555555',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalization.of(context)
                                              .translate(
                                                  'Please enter your mobile number');
                                        } else if (value.length < 10) {
                                          return AppLocalization.of(context)
                                              .translate(
                                                  'Please enter 10 numbers');
                                        }
                                        return null;
                                      },
                                      labelString: 'Mobile number',
                                      controller: cubit.phoneController,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    if (state is! LoginLoadingState)
                                      DefaultButton(
                                        onPressed: () {
                                          if (formKey2.currentState!
                                              .validate()) {
                                            cubit.checkPhone(
                                                phoneNumber:
                                                    cubit.phoneController.text);
                                          }
                                        },
                                        text: 'Login',
                                      ),
                                    if (state is LoginLoadingState)
                                      const CircularProgressIndicator(),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalization.of(context)
                                                .translate(
                                                    'You dont have an account')!,
                                            textAlign: TextAlign.center,
                                            style: Styles.getMidMainTextStyle(
                                                color: Colors.black,
                                                fontSize: FontSize.s14),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          TextButton(
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate('Sign Up')!,
                                              style:
                                                  Styles.getBoldMainTextStyle(
                                                      color:
                                                          ColorManager.primary,
                                                      fontSize: FontSize.s14),
                                            ),
                                            onPressed: () {
                                              navigateTo(
                                                  context: context,
                                                  nextScreen: SignUpScreen());
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
