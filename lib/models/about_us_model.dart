class AboutUsModel {


 late int modelState;
  late String message;
  Data? data;

  AboutUsModel.fromMap(Map<String, dynamic> json){
    modelState= json["model-state"];
    message= json["message"];
    data= Data.fromMap(json["data"]);
  }


}

class Data {


  String? about;
  String? video;

   Data.fromMap(Map<String, dynamic> json) {
    about= json["about"];
    video= json["video"];
  }
}
