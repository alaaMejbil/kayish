class DistrictCityModel {

  late int modelState;
  late String message;
  Data? data;

   DistrictCityModel.fromMap(Map<String, dynamic> json){
     modelState= json["model-state"];
     message= json["message"];
     data= Data.fromMap(json["data"]);
  }




}

class Data {


  List<District> districts=[];

   Data.fromMap(Map<String, dynamic> json) {
     districts= List<District>.from(json["districts"].map((x) => District.fromMap(x)));
   }


}

class District {
  District({
    this.id,
    this.name,
});

  int? id;
  String? name;

   District.fromMap(Map<String, dynamic> json) {
    id= json["id"];
    name= json["name"];
  }


}
