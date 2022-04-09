class PolicyModel {


 late int modelState;
 late String message;
  Data? data;

   PolicyModel.fromMap(Map<String, dynamic> json) {
     modelState= json["model-state"];
     message= json["message"];
     data= Data.fromMap(json["data"]);
   }


}

class Data {


  String? policy;

   Data.fromMap(Map<String, dynamic> json) {
     policy= json["policy"];
   }


}
