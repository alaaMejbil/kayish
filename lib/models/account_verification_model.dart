class AccountVerificationModel {


  late int modelState;
 late  String message;
  List<dynamic> data=[];

   AccountVerificationModel.fromMap(Map<String, dynamic> json) {
     modelState= json["model-state"];
     message= json["message"];
     data= json['data']!=null?List<dynamic>.from(json["data"].map((x) => x)):[];
   }


}
