import 'package:kayish/models/signUp_model.dart';

class LoginModel{
  late int status;
  late String message;
  List<dynamic>data=[];
  LoginModel.fromMap(Map<String,dynamic>json){
    status=json['model-state'];
    message=json['message'];
    data=json['data'] ?? [];
  }

}
