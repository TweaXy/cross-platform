import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class UpdatePasswordService {
  final Dio dio;
  UpdatePasswordService(this.dio);
  Future updatePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    dynamic response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }
    final data = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword
    };
    try {
      response = await Api.patch(
          url: '${baseURL}users/password', body: data, token: token);
    } catch (e) {
      log(e.toString());
    }

    return response;
  }
}
