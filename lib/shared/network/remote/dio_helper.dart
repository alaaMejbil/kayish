import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;
  static void init(baseUrl) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData(
      {@required Map<String, dynamic>? headers,
      @required url,
      Map<String, dynamic>? data}) {
    dio!.options.headers = headers;

    return dio!.post(
      url,
      options: Options(receiveTimeout: 500, sendTimeout: 500),
      data: data,
    );
  }

  static Future<Response> getData(
      {Map<String, dynamic>? headers,
      @required url,
      Map<String, dynamic>? query}) async {
    dio!.options.headers = headers;

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> putData(
      {Map<String, dynamic>? headers,
      @required url,
      Map<String, dynamic>? query}) async {
    dio!.options.headers = headers;

    return await dio!.put(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> deleteData(
      {Map<String, dynamic>? headers,
      @required url,
      Map<String, dynamic>? query}) async {
    dio!.options.headers = headers;

    return await dio!.delete(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postFormData(
      {@required Map<String, dynamic>? headers,
      @required url,
      FormData? data}) {
    dio!.options.headers = headers;

    return dio!.post(
      url,
      data: data,
    );
  }
}
