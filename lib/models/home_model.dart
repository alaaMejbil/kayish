class HomeModel {
  late int modelState;
  late String message;
  Data? data;

  HomeModel.fromMap(Map<String, dynamic> json) {
    modelState = json['model-state'];
    message = json['message'];
    data = json['data'] != null ? Data.fromMap(json['data']) : Data.fromMap({});
  }
}

class Data {
  List<AuctionDetails> currentAuctions = [];
  List<AuctionDetails> nextAuctions = [];
  List<AuctionDetails> doneAuctions = [];
  // if user status 0 = not register
  //if user status 1 = not send data to verification
  // if user status 2 = send date to verification and waiting
  // if user register 3 = accept verification from user
  dynamic userStatus;

  Data.fromMap(Map<String, dynamic> json) {
    currentAuctions = List<AuctionDetails>.from(
        json["CurrentAuctions"].map((x) => AuctionDetails.fromMap(x)));
    nextAuctions = List<AuctionDetails>.from(
        json["nextAuctions"].map((x) => AuctionDetails.fromMap(x)));
    doneAuctions = List<AuctionDetails>.from(
        json["doneAuctions"].map((x) => AuctionDetails.fromMap(x)));
    userStatus = json['user_status'];
  }
}

class AuctionDetails {
  int? id;
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
  dynamic maximum;
  String? calTime;

  AuctionDetails.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    dealId = json["deal_id"];
    realestateTitle = json["realestate_title"];
    realestateType = json["realestate_type"];
    currentTender = json["current_tender"];
    realestateReigon = json["realestate_reigon"];
    realestateCity = json["realestate_city"];
    realestateSpace = json["realestate_space"];
    startDate = json["start_date"];
    startTime = json["start_date_time"];
    endTime = json["end_time"];
    followed = json['followed'];
    realestateImage = json["realestate_image"];
    maximum = json['maximum_price'];
    calTime = json['cal_time'];
  }
}
