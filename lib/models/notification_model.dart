class NotificationModel {


 late int modelState;
 late String message;
  Data? data;

   NotificationModel.fromMap(Map<String, dynamic> json) {
     modelState= json["model-state"];
     message= json["message"];
     data=json['data']!=null? Data.fromMap(json["data"]):Data.fromMap({});
   }


}

class Data {


  List<NotificationsDetails> postponed=[];
  List<NotificationsDetails> done=[];

   Data.fromMap(Map<String, dynamic> json) {
     postponed= List<NotificationsDetails>.from(json["postponed"].map((x) =>NotificationsDetails.fromMap(x) ));
     done= List<NotificationsDetails>.from(json["done"].map((x) => NotificationsDetails.fromMap(x)));
   }


}

class NotificationsDetails{

  String? title;
  int? auctionId;
  int? date;

  NotificationsDetails.fromMap(Map<String,dynamic>json){

    title=json['text'];
    auctionId=json['auction_id'];
    date=json['created_at'];

  }
}
