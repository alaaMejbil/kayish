class MyAuctionModel {


 late int modelState;
 late String message;
  Data? data;

   MyAuctionModel.fromMap(Map<String, dynamic> json) {
     modelState= json["model-state"];
     message= json["message"];
     data=json['data']!=null? Data.fromMap(json["data"]):null;
  }


}

class Data {


  List<MyAuction> myAuctions=[];

   Data.fromMap(Map<String, dynamic> json){
    myAuctions= List<MyAuction>.from(json["myAuctions"].map((x) => MyAuction.fromMap(x)));
  }


}

class MyAuction {


  int? id;
  String? dealId;
  String? realestateTitle;
  String? realestateType;
  int? currentTender;
  String? realestateReigon;
  String? realestateCity;
  String? realestateSpace;
  DateTime? startDate;
  int? startTime;
  int? startDateTime;
  String? endTime;
  String? realestateImage;

   MyAuction.fromMap(Map<String, dynamic> json){
     id= json["id"];
     dealId= json["deal_id"];
     realestateTitle= json["realestate_title"];
     realestateType=json["realestate_type"];
     currentTender= json["current_tender"];
     realestateReigon=json["realestate_reigon"];
     realestateCity=json["realestate_city"];
     realestateSpace=json["realestate_space"];
     startDate= json["start_date"];
     startTime= json["start_time"];
     startDateTime= json["start_date_time"];
     endTime= json["end_time"];
     realestateImage= json["realestate_image"];
   }


}


