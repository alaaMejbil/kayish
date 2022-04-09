class DealsDetailsModel {
  late int modelState;
  late String message;
  Data? data;

  DealsDetailsModel.fromMap(Map<String, dynamic> json) {
    modelState = json["model-state"];
    message = json["message"];
    data = json['data'] != null ? Data.fromMap(json["data"]) : Data.fromMap({});
  }
}

class Data {
  AuctionDetails? auctionDetails;

  Data.fromMap(Map<String, dynamic> json) {
    auctionDetails = AuctionDetails.fromMap(json["auctionDetails"]);
  }
}

class AuctionDetails {
  int? id;
  String? address;
  String? age;
  String? dealId;
  String? realestateTitle;
  String? realestateDescription;
  List<RealestateProperty> realestateProperties = [];
  String? realestateType;
  String? realestateReigon;
  String? realestateCity;
  String? realestateSpace;
  String? latitude;
  String? longitude;
  List<RealestateImage> realestateImages = [];
  List<DealsTenders> dealsTenders = [];
  // List<dynamic> dealsTenders = [];

  //STATUS ==1 CURRENT,==2 POSTPONED,==3 FINISHED
  int? status;
  int? defaultPrice;
  int? maximumPrice;
  int? tendersValue;
  int? desireValue;
  int? currentTender;
  int? startDate;
  int? startTime;
  int? endTime;

  AuctionDetails.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    address = json['address'];
    dealId = json["deal_id"];
    realestateTitle = json["realestate_title"];
    realestateDescription = json["realestate_description"];
    realestateProperties = List<RealestateProperty>.from(
        json["realestate_properties"]
            .map((x) => RealestateProperty.fromMap(x)));
    dealsTenders = List<DealsTenders>.from(
        json["deals_tenders"].map((x) => DealsTenders.fromMap(x)));
    realestateType = json["realestate_type"];
    realestateReigon = json["realestate_reigon"];
    realestateCity = json["realestate_city"];
    realestateSpace = json["realestate_space"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    realestateImages = List<RealestateImage>.from(
        json["realestate_images"].map((x) => RealestateImage.fromMap(x)));
    status = json["status"];
    defaultPrice = json["default_price"];
    maximumPrice = json["maximum_price"];
    tendersValue = json["tenders_value"];
    desireValue = json["desire_value"];
    currentTender = json["current_tender"];
    startDate = json["start_date"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    age = json['age'];
  }
}

class RealestateImage {
  int? id;
  String? image;

  RealestateImage.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
      };
}

class RealestateProperty {
  String? name;
  String? value;

  RealestateProperty.fromMap(Map<String, dynamic> json) {
    name = json["name"];
    value = json["value"];
  }
}

class DealsTenders {
  String? name;
  dynamic? value;
  String? createdAt;

  DealsTenders.fromMap(Map<String, dynamic> json) {
    name = json["name"];
    value = json["tenders_value"];
    createdAt = json['created_at'];
  }
}
