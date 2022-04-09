import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kayish/blocs/code%20verification%20cubit/states.dart';
import 'package:kayish/blocs/sign%20up%20cubit/states.dart';
import 'package:kayish/models/signUp_model.dart';
import 'package:kayish/models/verification_code_model.dart';
import 'package:kayish/modules/home_screen.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';

import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:timer_count_down/timer_controller.dart';

class VerificationCodeCubit extends Cubit<VerificationCodeStates> {
  VerificationCodeCubit() : super(VerificationCodeInitialState());
  TextEditingController pinController = TextEditingController();

  CountdownTimerController? timerController;

  static VerificationCodeCubit get(context) => BlocProvider.of(context);
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.unlocked,
    ),
  );

  VerificationCodeModel? verificationCodeModel;

  CountdownTimerController initialTimer() {
    timerController = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + (31 * 1000),
        onEnd: () {
          timeFinished();
        });
    return timerController!;
  }

  // to verify code
  void signIn({required String phoneNumber}) async {
    DioHelper.postData(url: 'signIn', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? "en" : "ar"
    }, data: {
      'phone': phoneNumber,
    }).then((value) {
      verificationCodeModel = VerificationCodeModel.fromMap(value.data);

      CasheHelper.putData(
          key: token, value: verificationCodeModel!.data!.userInfo!.token);
      print(verificationCodeModel!.data!.userInfo!.token);
      postFcmToken();
      emit(VerificationCodeSuccessfulState());
    }).catchError((onError) {
      print(onError);
    });
  }

  // time counter
  void timeFinished() {
    emit(TimeFinishedState());
  }

  void postFcmToken() {
    emit(PostFcmTokenLoadingState());
    DioHelper.postData(
        url: 'fcmToken',
        headers: {'Authorization': 'bearer ${CasheHelper.getData(key: token)}'},
        data: {'fcmToken': fcmToken}).then((value) {
      print(value.data['message']);
      if (value.data['model-state'] == 1) emit(PostFcmTokenSuccessfulState());
    }).catchError((onError) {
      emit(PostFcmTokenErrorState());
    });
  }

  void insureCodeVerification(
      {required String verificationId,
      required String smsCode,
      required String phoneNumber}) {
    emit(VerificationCodeLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      signIn(phoneNumber: phoneNumber);
      postFcmToken();
      emit(VerificationCodeSuccessfulState());
    }).catchError((onError) {
      emit(VerificationCodeErrorState());
    });
  }
}
