import 'package:kayish/models/upcoming_auction_model.dart';

class OnGoingAuctionModel {


  late int modelState;
  late String message;
  Data? data;

  OnGoingAuctionModel.fromMap(Map<String, dynamic> json) {

    modelState= json["model-state"];
    message= json["message"];
    data= Data.fromMap(json["data"]);

  }

}

class Data {
  NextAuctions? nextAuctions;
  Data.fromMap(Map<String, dynamic> json){
    nextAuctions= NextAuctions.fromMap(json["CurrentAuctions"]);
  }


}

