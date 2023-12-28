import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class UpdateEmail {
  final Dio dio;

  UpdateEmail(this.dio);
  Future<dynamic> sendEmailCodeVerification(String email) async {
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
        url: '${baseURL}auth/sendEmailVerification',
        token:token,
        body: {"email": email},
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('varification code error ');
    }
  }

  Future changeEmail(String code, String email) async {
    dynamic response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }

    try {
      response = await Api.patch(
        url: '${baseURL}users/email',
        token: token,
        body: {"token": code, "email": email},
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
