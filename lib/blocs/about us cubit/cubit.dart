import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/about%20us%20cubit/states.dart';
import 'package:kayish/models/about_us_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsCubit extends Cubit<AboutUsStates> {
  AboutUsCubit() : super(AboutUsInitialState());
  static AboutUsCubit get(context) => BlocProvider.of(context);

  AboutUsModel? aboutUsModel;

  void getAboutUsInfo() {
    DioHelper.getData(url: 'aboutapp', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }).then((value) {
      if (value.statusCode == 200) {
        aboutUsModel = AboutUsModel.fromMap(value.data);
        if (aboutUsModel!.modelState == 1) {
          emit(AboutUsSuccessfulState());
        } else {
          emit(AboutUsErrorState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(AboutUsErrorState());
    });
  }

  void myWebViewInit() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}
