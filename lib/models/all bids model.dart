class AllBidsModel {
  String? bidValue;
  String? time;
  String? userId;
  AllBidsModel({
   required this.bidValue,
   required this.time,
    required this.userId
});

  AllBidsModel.fromMap(Map<String,dynamic>json){
      bidValue=json['bid_value'];
      userId=json['user_id'];
      time=json['time'];
  }

  Map<String,dynamic> toMap()=>{
    'bid_value':bidValue,
    'time':time,
    'user_id':userId
  };
}