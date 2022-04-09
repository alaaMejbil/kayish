import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kayish/blocs/app%20cubit/app_states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:overlay_support/overlay_support.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeLang(bool change) {
    CasheHelper.putData(key: 'isArabic', value: change);
    emit(ChangeLang());
  }
}
