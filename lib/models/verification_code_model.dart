class VerificationCodeModel{
  late int status;
  late String message;
  VerificationCodeDetails? data;
  VerificationCodeModel.fromMap(Map<String,dynamic>json){
    status=json['model-state'];
    message=json['message'];
    data=json['data']!=null?VerificationCodeDetails.fromMap(json['data']):VerificationCodeDetails.fromMap({});
  }

}
class VerificationCodeDetails{
  UserInfo? userInfo;
  VerificationCodeDetails.fromMap(Map<String,dynamic>json){
    if(json['user_info']!=null){
      userInfo=UserInfo.fromMap(json['user_info']);
    }
  else{
    userInfo=UserInfo.fromMap({});
    }

  }
}

class UserInfo{
  String? name;
  String? phone;
  String? email;
  String? age;
  String? token;
  UserInfo.fromMap(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    age=json['age'];
    token=json['token'];
  }
}