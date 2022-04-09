import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/sign%20up%20cubit/states.dart';
import 'package:kayish/models/signUp_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  SignUpModel? signUpModel;

  Future<void> signUp(
      {required String emailAddress, required String phoneNumber}) async {
    emit(SignUpLoadingState());
    DioHelper.postData(
      url: 'signUp',
      data: {'email': emailAddress, "phone": phoneNumber},
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
      },
    ).then((value) {
      signUpModel = SignUpModel.fromMap(value.data);

      if (signUpModel!.status == 2) {
        CasheHelper.putData(key: 'phoneNumber', value: phoneNumber);

        phoneController.text = '';
        emailController.text = '';
        emit(SignUpSuccessfulState());
      } else {
        emit(SignUpErrorDataInputState());
      }
    }).catchError((onError) {
      print(onError);
      emit(SignUpErrorState());
    });
  }

  void checkPhone({required String phoneNumber}) {
    emit(SignUpLoadingState());
    DioHelper.getData(
      url: 'checkPhone?phone=$phoneNumber',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
        'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
      },
    ).then((value) {
      if (value.statusCode == 200) {
        signUpModel = SignUpModel.fromMap(value.data);
        if (signUpModel!.status == 2) {
          CasheHelper.putData(key: 'phoneNumber', value: phoneNumber);
          FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+966$phoneNumber',
            timeout: const Duration(seconds: 30),
            verificationCompleted: (PhoneAuthCredential credential) {
              emit(SignUpSuccessfulState());
            },
            verificationFailed: (FirebaseAuthException e) {
              emit(CodeNotSentState());
            },
            codeSent: (String verificationId, int? resendToken) async {
              CasheHelper.putData(
                  key: 'verificationToken', value: verificationId);

              CasheHelper.putData(key: 'phoneNumber', value: phoneNumber);
              phoneController.text = '';
              emailController.text = '';
              print('code sent');

              emit(SignUpSuccessfulState());
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        } else if (signUpModel!.status == 1) {
          emit(SignUpNumberExistDataInputState());
        } else {
          emit(SignUpErrorDataInputState());
          print(signUpModel!.message.toString());
          print(signUpModel!.data.toString());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(SignUpErrorState());
    });
  }
}
