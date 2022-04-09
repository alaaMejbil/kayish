class LogoutModel{
  late int status;
  late bool message;
  LogoutModel.fromMap(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}