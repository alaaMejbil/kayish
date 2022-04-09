class HowItWorkModel {


  late int modelState;
  late String message;
  Data? data;

  HowItWorkModel.fromMap(Map<String, dynamic> json){
    modelState= json["model-state"];
    message= json["message"];
    data= Data.fromMap(json["data"]);
  }


}

class Data {


  String? about;
  String? video;

  Data.fromMap(Map<String, dynamic> json) {
    about= json["howitwork"];
    video= json["video"];
  }
}
