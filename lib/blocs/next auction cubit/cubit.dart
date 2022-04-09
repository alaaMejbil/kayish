import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/next%20auction%20cubit/states.dart';

import 'package:kayish/models/on_going_auction_model.dart';
import 'package:kayish/models/upcoming_auction_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OnGoingAuctionCubit extends Cubit<OnGoingStates>{
  OnGoingAuctionCubit() : super(OnGoingInitialState());
  static OnGoingAuctionCubit get(context)=>BlocProvider.of(context);
  RefreshController refreshController=RefreshController();
  bool isLoading=false;
  void resetCurrentPage(){
    currentPage=1;
    emit(UpdateCurrentPage());
  }

  List<Datum> allData=[];
  int currentPage=1;
  Map<int,bool> currentFollowedList={};

  OnGoingAuctionModel? onGoingAuctionModel;

  Future<void> getOnGoingAuction({bool isRefresh=false})async{
    DioHelper.getData(
        url: 'currentAuctions?page=$currentPage',
        headers: {
          'lang':CasheHelper.getData(key: 'isArabic')==false?'en':'ar',
          'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
        }

    ).then((value) {
      if(value.statusCode==200){
        print(value);
        onGoingAuctionModel=OnGoingAuctionModel.fromMap(value.data);
        currentPage++;

        if(onGoingAuctionModel!.modelState==1){

          if(isRefresh){
            currentFollowedList={};
            allData=onGoingAuctionModel!.data!.nextAuctions!.data;
            for(var element in onGoingAuctionModel!.data!.nextAuctions!.data){
              currentFollowedList.addAll({element.id!:element.followed!});
            }

          }
          else{
            allData.addAll(onGoingAuctionModel!.data!.nextAuctions!.data);
            for(var element in onGoingAuctionModel!.data!.nextAuctions!.data){
              currentFollowedList.addAll({element.id!:element.followed!});
            }
          }

          emit(OnGoingSuccessfulState());
        }
        else{
          emit(OnGoingErrorDataInputState());
        }
      }

    }).catchError((onError){
      print(onError);
      emit(OnGoingErrorState());
    });
  }


  void addFollow(int auctionId){
    emit(FollowLoadingState());
    DioHelper.postData(
        url: 'followAuction',
        headers: {
          'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
          'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
        },
        data: {
          'auction_id':auctionId
        }
    ).then((value) {
      if(value.statusCode==200){
        print('esraa');
        emit(FollowSuccessfulState());
      }
      else{
        currentFollowedList[auctionId]=!currentFollowedList[auctionId]!;
        emit(FollowErrorDataInputState());
      }
    }).catchError((onError){
      print(onError);
      currentFollowedList[auctionId]=!currentFollowedList[auctionId]!;
      emit(FollowErrorState());
    });
  }

}

