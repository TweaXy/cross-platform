import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class LOGOUT {
  final Dio dio;

  LOGOUT(this.dio);
  Future<dynamic> logOutDevice() async {
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
        url: '${baseURL}auth/logout',
        token: token,
        body: {"token": token, "type": "android"},
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('logout error ');
    }
  }
}
