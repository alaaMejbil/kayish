import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/notification%20cubit/states.dart';
import 'package:kayish/models/notification_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';

class NotificationsCubit extends Cubit<NotificationsStates>{
  NotificationsCubit() : super(NotificationsInitialState());
  static NotificationsCubit get(context) => BlocProvider.of(context);
  NotificationModel? notificationModel;
  void getNotifications(){
    DioHelper.getData(
      url: 'myNotification',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
        'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
      },
    ).then((value) {

      if (value.statusCode==200) {
        notificationModel=NotificationModel.fromMap(value.data);
        emit(NotificationsSuccessfulState());
      }
        else{
          emit(NotificationsErrorDataInputState());
        }


    }).catchError((onError){
      print(onError);
      emit(NotificationsErrorState());
    });
  }
}