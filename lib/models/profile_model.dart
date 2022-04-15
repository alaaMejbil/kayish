class ProfileModel {
  late int modelState;
  late String message;
  Data? data;

  ProfileModel.fromMap(Map<String, dynamic> json) {
    modelState = json["model-state"];
    message = json["message"];
    data = json['data'] != null ? Data.fromMap(json["data"]) : null;
  }
}

class Data {
  Profile? profile;

  Data.fromMap(Map<String, dynamic> json) {
    profile = Profile.fromMap(json["profile"]);
  }
}

class Profile {
  String? name;
  int? id;
  String? phone;
  String? email;
  String? age;
  dynamic status;

  Profile.fromMap(Map<String, dynamic> json) {
    name = json["name"] ?? 'empty';
    phone = json["phone"] ?? 'empty';
    email = json["email"] ?? 'empty';
    age = json["age"] ?? 'empty';
    status = json["status"];
    id = json['id'];
  }
}
