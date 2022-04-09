class SignUpModel{
  late int status;
  late String message;
  List<dynamic> data=[];
  SignUpModel.fromMap(Map<String,dynamic>json){
    status=json['model-state'];
    message=json['message'];
    data=json['data'] ?? [];
  }

}
