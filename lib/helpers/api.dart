import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  static Future<dynamic> get(String url) async {
    Response response;
    try {
      response = await Dio().get(url);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'There\'s an error status code = ${response.statusCode} \nThe message is ${response.statusMessage}');
      }
    } on Exception catch (e) {
      return (e.toString());
    }
  }

  static Future<dynamic> post({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Response? response;
    try {
      Map<String, dynamic> headers = {};
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      response = await Dio().post(
        url,
        data: body,
      );
      print("code=" + response.statusCode.toString());
    } on DioException catch (e) {
      return (e.response!.data['message']);
      // throw Exception(e.response!.statusMessage);
    }
    return response;
  }

  static Future<Response> put({
    required String url,
    required String id,
    @required dynamic body,
    @required String? token,
  }) async {
    Response response;
    try {
      Map<String, dynamic> headers = {};
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      response = await Dio().put(
        url + id,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
    return response;
  }
}
