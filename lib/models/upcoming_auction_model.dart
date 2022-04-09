class InComingAuctionModel {
  late int modelState;
  late String message;
  Data? data;

  InComingAuctionModel.fromMap(Map<String, dynamic> json) {
    modelState = json["model-state"];
    message = json["message"];
    data = Data.fromMap(json["data"]);
  }
}

class Data {
  NextAuctions? nextAuctions;

  Data.fromMap(Map<String, dynamic> json) {
    nextAuctions = NextAuctions.fromMap(json["nextAuctions"]);
  }
}

class NextAuctions {
  num? currentPage;
  List<Datum> data = [];
  int? total;

  NextAuctions.fromMap(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    data = List<Datum>.from(json["data"].map((x) => Datum.fromMap(x)));
    total = json["total"];
  }
}

class Datum {
  int? id;
  int? maximum;
  String? dealId;
  String? realestateTitle;
  String? realestateType;
  int? currentTender;
  String? realestateReigon;
  String? realestateCity;
  String? realestateSpace;
  int? startDate;
  int? startTime;
  int? endTime;
  bool? followed;
  String? realestateImage;

  Datum.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    dealId = json["deal_id"];
    realestateTitle = json["realestate_title"];
    realestateType = json["realestate_type"];
    currentTender = json["current_tender"];
    realestateReigon = json["realestate_reigon"];
    realestateCity = json["realestate_city"];
    realestateSpace = json["realestate_space"];
    startDate = json["start_date"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    followed = json['followed'];
    realestateImage = json["realestate_image"];
    maximum = json['maximum_price'];
  }
}
