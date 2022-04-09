class CityModel {


  late int modelState;
  late String message;
  Data? data;

   CityModel.fromMap(Map<String, dynamic> json) {
     modelState= json["model-state"];
     message= json["message"];
     data= Data.fromMap(json["data"]);
   }


}

class Data {


  List<City> cities=[];

   Data.fromMap(Map<String, dynamic> json) {
     cities= List<City>.from(json["cities"].map((x) => City.fromMap(x)));
   }


}

class City {

  int? id;
  String? name;
  City({
    required this.name,
    required this.id
});

   City.fromMap(Map<String, dynamic> json) {
     id= json["id"];
     name= json["name"];
   }


}
