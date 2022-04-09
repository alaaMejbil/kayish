import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/my%20auction%20cubit/states.dart';
import 'package:kayish/models/my_auction_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';

class MyAuctionCubit extends Cubit<MyAuctionStates> {
  MyAuctionCubit() : super(MyAuctionInitialState());

  static MyAuctionCubit get(context) => BlocProvider.of(context);
  MyAuctionModel? myAuctionModel;

  void getMyAuction() {
    DioHelper.getData(url: 'myAuctions', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }).then((value) {
      if (value.statusCode == 200) {
        myAuctionModel = MyAuctionModel.fromMap(value.data);
        if (myAuctionModel!.modelState == 1) {
          emit(MyAuctionSuccessfulState());
        } else {
          emit(MyAuctionErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(MyAuctionErrorState());
    });
  }
}
