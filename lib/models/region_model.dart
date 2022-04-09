class RegionModel {


 late int modelState;
  late String message;
  Data? data;

   RegionModel.fromMap(Map<String, dynamic> json) {
    modelState= json["model-state"];
    message= json["message"];
    data= Data.fromMap(json["data"]);
  }


}

class Data {

  List<Region> regions=[];

   Data.fromMap(Map<String, dynamic> json) {
     regions= List<Region>.from(json["regions"].map((x) => Region.fromMap(x)));
   }


}

class Region {

   Region(this.id,this.name);
  int? id;
  String? name;

   Region.fromMap(Map<String, dynamic> json){
     id=json["id"];
     name= json["name"];
   }


}
