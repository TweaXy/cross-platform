import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  static Future<dynamic> get(String url) async {
    Response? response;
    try {
      response = await Dio().get(url);
    } on DioException catch (e) {
      log("API: " + e.response!.data['message']);
      return e.response!.data['message'];
    }
    log("API: " + response.toString());

    return response;
  }

  static Future<dynamic> post({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    // print(url);
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
      //  print("code=" + response.statusCode.toString());
    } on DioException catch (e) {
      return (e.response!.data['message']);
      // throw Exception(e.response!.statusMessage);
    }
    return response;
  }

  static Future<Response> delete({
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
      response = await Dio().delete(
        url,
        data: body,
      );
      //  print(response.statusCode);
    } on DioException catch (e) {
      //  print(e.response!.data['message']);
      throw Exception(e.response!.statusMessage);
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
