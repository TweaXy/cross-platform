import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class CheckPassword {
  final Dio dio;

  CheckPassword(this.dio);

  Future checkPasswordCorrectness(String password) async {
    dynamic response;
    String? token;
      try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.post(
        url: '${baseURL}users/checkPassword',
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
