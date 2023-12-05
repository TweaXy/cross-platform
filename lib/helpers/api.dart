import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  static Future<dynamic> get(String url) async {
    Response? response;
    try {
      response = await Dio().get(
        url,
      );
    } on DioException catch (e) {
      log("API: " + e.response!.data['message']);
      return e.response!.data['message'];
    }
    log("API: $response");

    return response;
  }

  static Future<dynamic> getwithToken({
    required String url,
    @required String? token,
  }) async {
    Response? response;
    try {
      Map<String, dynamic> headers = {};
      if (token != null) {
        headers.addAll({
          'Authorization': 'Bearer $token',
          // 'Content-Type': 'application/json;charset=UTF-8'
        });
      }
      response = await Dio().get(url, options: Options(headers: headers));
    } on DioException catch (e) {
      log("API: " + e.response!.data['message']);
      return e.response!.data['message'];
    }
    // log("API: $response");

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
        options: Options(headers: headers),
      );
      log(response.toString());
      //  print("code=" + response.statusCode.toString());
    } on DioException catch (e) {
      log(response.toString());
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
        options: Options(headers: headers),
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
    } on DioException catch (e) {
      print(e.response!.data['message']);
      throw Exception(e.response!.statusMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
    return response;
  }

  static Future patch({
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
      response = await Dio()
          .patch(url, data: body, options: Options(headers: headers));
      print(response.statusCode);
    } on DioException catch (e) {
      print(e.response!.data['message']);
      return (e.response!.data['message']);
    }
    return response;
  }
}
