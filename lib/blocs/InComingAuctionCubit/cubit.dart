import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/InComingAuctionCubit/states.dart';
import 'package:kayish/models/upcoming_auction_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InComingAuctionCubit extends Cubit<InComingAuctionStates> {
  InComingAuctionCubit() : super(InComingAuctionInitialState());
  static InComingAuctionCubit get(context) => BlocProvider.of(context);
  RefreshController refreshController = RefreshController();
  bool isLoading = false;
  void resetCurrentPage() {
    currentPage = 1;
    emit(UpdateCurrent());
  }

  List<Datum> allData = [];
  Map<int, bool> nextFollowedList = {};
  int currentPage = 1;

  InComingAuctionModel? inComingAuctionModel;
  Future<void> getIncomingAuction({bool isRefresh = false}) async {
    DioHelper.getData(url: 'postponedAuctions?page=$currentPage', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }).then((value) {
      if (value.statusCode == 200) {
        print(value);
        inComingAuctionModel = InComingAuctionModel.fromMap(value.data);
        currentPage++;

        if (inComingAuctionModel!.modelState == 1) {
          print(
              'api list${inComingAuctionModel!.data!.nextAuctions!.data.length}');
          if (isRefresh) {
            nextFollowedList = {};
            allData = inComingAuctionModel!.data!.nextAuctions!.data;
            for (var element
                in inComingAuctionModel!.data!.nextAuctions!.data) {
              nextFollowedList.addAll({element.id!: element.followed!});
            }
          } else {
            allData.addAll(inComingAuctionModel!.data!.nextAuctions!.data);
            for (var element
                in inComingAuctionModel!.data!.nextAuctions!.data) {
              nextFollowedList.addAll({element.id!: element.followed!});
            }
          }

          emit(InComingAuctionSuccessfulState());
        } else {
          emit(InComingAuctionErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(InComingAuctionErrorState());
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
        print(value.data);
        print('esraa 2');
        print('status is : ${value.data['data'][0]}');
        if (value.data['data'][0] == "subscripe") {
          await FirebaseMessaging.instance
              .subscribeToTopic(auctionId.toString());
        } else {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic(auctionId.toString());
        }
        emit(FollowSuccessfulState());
      } else {
        nextFollowedList[auctionId] = !nextFollowedList[auctionId]!;
        emit(FollowErrorDataInputState());
      }
    }).catchError((onError) {
      print(onError);
      nextFollowedList[auctionId] = !nextFollowedList[auctionId]!;
      emit(FollowErrorState());
    });
  }
}
