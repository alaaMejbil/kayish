class RealStateModel {
  int? modelState;
  String? message;
  Data? data;



  RealStateModel.fromMap(Map<String, dynamic> json) {
    modelState = json['model-state'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromMap(json['data']) : null;
  }


}

class Data {
  List<RealEstateType> realEstateType=[];



  Data.fromMap(Map<String, dynamic> json) {
    if (json['real_estate_type'] != null) {

      json['real_estate_type'].forEach((v) {
        realEstateType.add(RealEstateType.fromMap(v));
      });
    }
  }


}

class RealEstateType {
  int? id;
  String? name;



  RealEstateType.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}
