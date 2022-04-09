import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kayish/blocs/app%20cubit/app_cubit.dart';
import 'package:kayish/blocs/app%20cubit/app_states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/policy%20cubit/cubit.dart';
import 'package:kayish/blocs/sign%20up%20cubit/cubit.dart';
import 'package:kayish/blocs/sign%20up%20cubit/states.dart';
import 'package:kayish/modules/login_screen.dart';
import 'package:kayish/modules/terms_and_conditions.dart';
import 'package:kayish/modules/verefication_code_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/default_form_field.dart';

import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/widgets/defualt_text.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CasheHelper.putData(key: 'screen name', value: 'sign up');
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessfulState) {
            navigateAndFinish(
                context: context, nextScreen: MobileVerification());
            PolicyCubit.get(context).getPolicy();
          } else if (state is SignUpNumberExistDataInputState) {
            Alert(
                context: context,
                type: AlertType.warning,
                image: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('icons/back_pop_up.png'),
                ),
                title: AppLocalization.of(context)
                    .translate('This number is already in use')!,
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
          } else if (state is SignUpNumberExistDataInputState) {
            Alert(
                context: context,
                type: AlertType.error,
                image: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('icons/back_pop_up.png'),
                ),
                title: SignUpCubit.get(context).signUpModel!.message,
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
          var cubit = SignUpCubit.get(context);

          return Scaffold(
            backgroundColor: ColorManager.lightGrey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: (Offset.zero),
                                  spreadRadius: 1,
                                  blurRadius: 5),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 16),
                            child: Form(
                              key: formKey1,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultText(
                                      myText: AppLocalization.of(context)
                                          .translate('Sign Up'),
                                      style: Styles.getBoldMainTextStyle(
                                          color: Colors.black,
                                          fontSize: FontSize.s22),
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    DefaultFormField(
                                      controller: cubit.emailController,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp("[ا-ى]")),
                                      ],
                                      astric: false,
                                      inputType: TextInputType.emailAddress,
                                      hintText: 'Please enter your email',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalization.of(context)
                                              .translate(
                                                  'Please enter your email');
                                        } else if (!EmailValidator.validate(
                                            value)) {
                                          return AppLocalization.of(context)
                                              .translate(
                                                  'Please enter the email correct format');
                                        }
                                        return null;
                                      },
                                      labelString: 'Email address',
                                    ),
                                    const SizedBox(
                                      height: 16,
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
                                    if (state is! SignUpLoadingState)
                                      DefaultButton(
                                        onPressed: () {
                                          if (formKey1.currentState!
                                              .validate()) {
                                            CasheHelper.putData(
                                                key: 'email',
                                                value:
                                                    cubit.emailController.text);

                                            cubit.checkPhone(
                                                phoneNumber:
                                                    cubit.phoneController.text);
                                          }
                                        },
                                        text: 'Register',
                                      ),
                                    if (state is SignUpLoadingState)
                                      const CircularProgressIndicator(),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalization.of(context)
                                                .translate(
                                                    'Do you have an account')!,
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
                                                  .translate('Sign in')!,
                                              style:
                                                  Styles.getBoldMainTextStyle(
                                                      color:
                                                          ColorManager.primary,
                                                      fontSize: FontSize.s14),
                                            ),
                                            onPressed: () {
                                              navigateTo(
                                                  context: context,
                                                  nextScreen: LoginScreen());
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
