import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/sign%20in%20cubit/states.dart';

import 'package:kayish/models/signIn_model.dart';
import 'package:kayish/shared/component/alert.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timer_count_down/timer_controller.dart';

class SignInCubit extends Cubit<LoginStates> {
  SignInCubit() : super(LoginInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);
  // controller of phone text field in login screen
  TextEditingController phoneController = TextEditingController();

  LoginModel? loginModel;

  void checkPhone({required String phoneNumber}) {
    emit(LoginLoadingState());
    DioHelper.getData(
      url: 'checkPhone?phone=$phoneNumber',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
        'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
      },
    ).then((value) {
      if (value.statusCode == 200) {
        loginModel = LoginModel.fromMap(value.data);

        if (loginModel!.status == 1) {
          CasheHelper.putData(key: 'phoneNumber', value: phoneNumber);
          FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+966$phoneNumber}',
            timeout: const Duration(seconds: 30),
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {
              emit(CodeNotSentState());
            },
            codeSent: (String verificationId, int? resendToken) async {
              CasheHelper.putData(
                  key: 'verificationToken', value: verificationId);
              CasheHelper.putData(key: 'phoneNumber', value: phoneNumber);
              phoneController.text = '';
              print('code sent');

              emit(LoginSuccessfulState());
              phoneController.text = '';
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        } else if (loginModel!.status == 2) {
          emit(LoginNumberNotExistDataInputState());
        } else {
          emit(LoginErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(LoginErrorState());
    });
  }

  void sendCodeVerification({required String mobileNumber}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+966$mobileNumber}',
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          emit(CodeNotSentState());
        },
        codeSent: (String verificationId, int? resendToken) async {
          CasheHelper.putData(key: 'verificationToken', value: verificationId);
          CasheHelper.putData(key: 'phoneNumber', value: mobileNumber);
          phoneController.text = '';
          print('code sent');

          emit(LoginSuccessfulState());
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
}
