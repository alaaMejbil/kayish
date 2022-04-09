import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kayish/blocs/done%20auction%20cubit/states.dart';
import 'package:kayish/models/done_auction_model.dart';
import 'package:kayish/models/on_going_auction_model.dart';
import 'package:kayish/models/upcoming_auction_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DoneAuctionCubit extends Cubit<DoneStates> {
  DoneAuctionCubit() : super(DoneInitialState());
  static DoneAuctionCubit get(context) => BlocProvider.of(context);
  RefreshController refreshController = RefreshController();
  DoneAuctionCubit? doneAuctionCubit;
  void resetCurrentPage() {
    currentPage = 1;
    emit(UpdateCurrent());
  }

  List<Datum> allData = [];
  int currentPage = 1;

  DoneAuctionModel? doneAuctionModel;
  Future<void> getDoneAuction({bool isRefresh = false}) async {
    DioHelper.getData(url: 'doneAuctions?page=$currentPage', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }).then((value) {
      if (value.statusCode == 200) {
        print(value);
        doneAuctionModel = DoneAuctionModel.fromMap(value.data);
        currentPage++;

        if (doneAuctionModel!.modelState == 1) {
          if (isRefresh) {
            allData = doneAuctionModel!.data!.nextAuctions!.data;
          } else {
            allData.addAll(doneAuctionModel!.data!.nextAuctions!.data);
          }

          emit(DoneSuccessfulState());
        } else {
          emit(DoneErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(DoneErrorState());
    });
  }
}
