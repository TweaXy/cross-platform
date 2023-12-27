import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class UpdateUsernameService {
  final Dio dio;
  UpdateUsernameService(this.dio);

  Future updateUsername(String? tokenSent, String newUsername) async {
    dynamic response;
    String? token;
    if (tokenSent != null) {
      token = tokenSent;
    } else {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        token = prefs.getString('token');
      } catch (e) {
        log(e.toString());
      }
    }
    try {
      response = await Api.patch(
        url: '${baseURL}users/updateUserName',
        token: token,
        body: {
          "username": newUsername,
        },
      );
      return response;
    } catch (e) {
      log(e.toString());
      //debug mode only
      throw Exception('update username error');
    }
  }
}
