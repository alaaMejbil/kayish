import 'package:kayish/models/upcoming_auction_model.dart';

import 'on_going_auction_model.dart';

class DoneAuctionModel {


  late int modelState;
  late String message;
  Data? data;

  DoneAuctionModel.fromMap(Map<String, dynamic> json) {

    modelState= json["model-state"];
    message= json["message"];
    data= Data.fromMap(json["data"]);

  }

}

class Data {


  NextAuctions? nextAuctions;

  Data.fromMap(Map<String, dynamic> json) {
    nextAuctions= NextAuctions.fromMap(json["doneAuctions"]);
  }


}

