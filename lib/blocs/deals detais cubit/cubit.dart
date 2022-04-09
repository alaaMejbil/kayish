import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/states.dart';

import 'package:kayish/models/all%20bids%20model.dart';
import 'package:kayish/models/deals_details_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';

class DealsDetailsCubit extends Cubit<DealsDetailsStates> {
  DealsDetailsCubit() : super(DealsDetailsInitialState());
  static DealsDetailsCubit get(context) => BlocProvider.of(context);
  int? highestPrice;
  int? openingPrice;
  int? bidCounter;
  int? tenderValue;
  // for page indicator index
  int activePage = 0;
  AllBidsModel? allBidsModel;
  List<AllBidsModel> all = [];
  ScrollController scrollController = ScrollController();

  TextEditingController bidValueController = TextEditingController();

  //increase bid value
  void increaseCounter() {
    bidCounter = bidCounter! + tenderValue!;
    bidValueController.text = '$bidCounter';
    emit(DealsDetailsIncreaseCounterState());
  }

  void decreaseCounter() {
    if (bidCounter! > tenderValue!) {
      bidCounter = bidCounter! - tenderValue!;
      emit(DealsDetailsIncreaseCounterState());
    }
  }

  //initial value of bid value and highest price
  void initialBidValue() {
    bidCounter = tenderValue;
    bidValueController.text = '$bidCounter';
    highestPrice = openingPrice;
  }

  Future<void> increaseHighestPrice() async {
    highestPrice = highestPrice! + bidCounter!;
    emit(DealsIncreaseHighestPrice());
  }

  DealsDetailsModel? dealsDetailsModel;
  Future<void> getAuctionDetails({required int auctionId}) async {
    DioHelper.getData(url: 'auctionDetails?auction_id=$auctionId', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }).then((value) {
      if (value.statusCode == 200) {
        dealsDetailsModel = DealsDetailsModel.fromMap(value.data);

        if (dealsDetailsModel!.modelState == 1) {
          print(dealsDetailsModel!.data!.auctionDetails!.status);
          tenderValue = dealsDetailsModel!.data!.auctionDetails!.tendersValue!;

          openingPrice = dealsDetailsModel!.data!.auctionDetails!.defaultPrice!;
          highestPrice = dealsDetailsModel!.data!.auctionDetails!.maximumPrice!;
          initialBidValue();
          getAllAuctionBids(auctionId);

          emit(DealsDetailsSuccessfulState());
        } else {
          emit(DealsDetailsErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(DealsDetailsErrorState());
    });
  }

// send bid to firebase
  void sendBid(
      {required String value, required int userId, required int auctionId}) {
    emit(SendAuctionLoadingState());
    AllBidsModel allBidsModel = AllBidsModel(
        bidValue: value,
        time: DateTime.now().toString(),
        userId: userId.toString());
    FirebaseFirestore.instance
        .collection('auction')
        .doc(auctionId.toString())
        .collection('bids')
        .add(allBidsModel.toMap())
        .then((value) {
      emit(SendSuccessfulState());
    }).catchError((onError) {
      print(onError);
      emit(SendErrorState());
    });
  }

  // git bids from firebase
  void getAllAuctionBids(int id) {
    FirebaseFirestore.instance
        .collection('auction')
        .doc(id.toString())
        .collection('bids')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      all = [];

      event.docs.forEach((element) {
        all.add(AllBidsModel.fromMap(element.data()));
        highestPrice = int.parse(all.first.bidValue!);
        print(highestPrice);
      });

      emit(GetSuccessfulState());
    });
  }

  void changePageIndicator(int value) {
    activePage = value;
    emit(ChangePageIndicator());
  }

  void sendBidToApi(int bidValue, int id) {
    emit(SendBidToApiLoadingState());
    DioHelper.postData(url: 'newTender', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
    }, data: {
      'auction_id': id,
      'tenders_value': bidValue
    }).then((value) {
      if (value.statusCode == 200) {
        emit(SendBidToApiSuccessfulState());
      }
    }).catchError((onError) {
      print(onError);
      emit(SendBidToApiErrorState());
    });
  }

  Future<List<DealsTenders>> getDealsTendersStream(int id) async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      await getAuctionDetails(auctionId: id);
      print('******************** Stream *************************');
      print(dealsDetailsModel!
          .data!.auctionDetails!.dealsTenders.first.createdAt);
      return dealsDetailsModel!.data!.auctionDetails!.dealsTenders;
    }
  }
}
