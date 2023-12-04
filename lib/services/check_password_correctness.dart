import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';

class CheckPassword {
  final Dio dio;
  final String baseUrl = 'http://16.171.65.142:3000/api/v1/';

  CheckPassword(this.dio);

  Future checkPasswordCorrectness(String password) async {
    dynamic response;
    String? token;
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');

    try {
      response = await Api.post(
        url: '${baseUrl}users/checkPassword',
        token: token,
        body: {"password": password},
      );
      log(response.toString());
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(response.toString());
        log("Service:$e");
      } //debug mode only
      return response;
    }
  }
}