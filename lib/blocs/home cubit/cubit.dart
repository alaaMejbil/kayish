import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kayish/blocs/home%20cubit/states.dart';
import 'package:kayish/models/home_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  bool isLoading = false;

  RefreshController? refreshController1 = RefreshController();
  Map<int, bool> followedList = {};
  /*
  followedList = {1 , true
                  2 , false,
                  3 , false,
                  4 , true
                  .
                  .
                  .
                  .
                  }
  * */
  Future<void> getHomeData(
      {int? cityId,
      int? regionId,
      int? districtId,
      int? realStateTypeId,
      String? age}) async {
    changeLoadingState(true);
    DioHelper.getData(
      url:
          'home?city_id=$cityId&district_id=$districtId&realestate_type_id=$realStateTypeId&realestate_status&region_id=$regionId&age=$age',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
        'Authorization': 'Bearer ${CasheHelper.getData(key: token)}'
      },
    ).then((value) {
      if (value.statusCode == 200) {
        changeLoadingState(false);
        print(value);
        homeModel = HomeModel.fromMap(value.data);
        if (homeModel!.modelState == 1) {
          followedList = {};
          print('=====> user status  ${homeModel!.data!.userStatus!}');
          for (var element in homeModel!.data!.currentAuctions) {
            followedList.addAll({element.id!: element.followed!});
          }
          for (var element in homeModel!.data!.nextAuctions) {
            followedList.addAll({element.id!: element.followed!});
          }
          CasheHelper.putData(
              key: isNotRegister, value: (homeModel!.data!.userStatus == 0));
          CasheHelper.putData(
              key: isLogin, value: (homeModel!.data!.userStatus == 1));
          CasheHelper.putData(
              key: isNotVerified, value: (homeModel!.data!.userStatus == 2));
          CasheHelper.putData(
              key: isVerified, value: (homeModel!.data!.userStatus == 3));
          emit(HomeSuccessfulState());
        } else {
          changeLoadingState(false);
          emit(HomeErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      changeLoadingState(false);
      emit(HomeErrorState());
    });
  }

  void addFollow(int auctionId) {
    emit(FollowLoadingState());
    DioHelper.postData(url: 'followAuction', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }, data: {
      'auction_id': auctionId
    }).then((value) async {
      if (value.statusCode == 200) {
        print('auctionId : $auctionId');
        print('Response is : ${value.data}');
        emit(FollowSuccessfulState());
        print('esraa');
        print('status is : ${value.data['data'][0]}');
        if (value.data['data'][0] == "subscripe") {
          await FirebaseMessaging.instance
              .subscribeToTopic(auctionId.toString());
        } else {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic(auctionId.toString());
        }
      } else {
        followedList[auctionId] = !followedList[auctionId]!;
        emit(FollowErrorDataInputState());
      }
    }).catchError((onError) {
      print(onError);
      followedList[auctionId] = !followedList[auctionId]!;
      emit(FollowErrorState());
    });
  }

  void changeLoadingState(bool value) {
    isLoading = value;
    emit(ChangeLoading());
  }
}
