import 'package:kayish/shared/network/remote/dio_helper.dart';

class DioGet {
  static dynamic dioGet(headers,url,var model){
    DioHelper.getData(headers: headers, url: url)
        .then((value) {
          if(value.statusCode==200){
            return value;
          }
          else {
            throw{'error message'};
          }

    }).catchError((onError){

    });
  }
}