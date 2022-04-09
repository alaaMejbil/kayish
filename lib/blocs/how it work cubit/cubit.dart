import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/how%20it%20work%20cubit/states.dart';
import 'package:kayish/models/how_it_work_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HowItWorkCubit extends Cubit<HowItWorkStates>{
  HowItWorkCubit() : super(HowItWorkInitialState());
  static HowItWorkCubit get(context) => BlocProvider.of(context);

  HowItWorkModel? howItWorkModel;
  void getHowItWorkInfo(){
    DioHelper.getData(
        url: 'howItWork',
        headers: {'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'}
    ).then((value) {

      if(value.statusCode==200){
        howItWorkModel=HowItWorkModel.fromMap(value.data);

        if(howItWorkModel!.modelState==1){

          emit(HowItWorkSuccessfulState());
        }
        else{
          emit(HowItWorkErrorState());
        }
      }

    }).catchError((onError){
      print(onError);
      emit(HowItWorkErrorState());
    });
  }

  void myWebViewInit(){
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}