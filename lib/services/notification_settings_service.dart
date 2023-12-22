import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class NotificationSettingsService {
  final Dio dio;
  NotificationSettingsService(this.dio);

  Future<dynamic> notificatioCheckState(String deviceToken) async {
    Response response;
    dynamic returnvalue;
    String? token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
    } catch (e) {
      log(e.toString());
    }
    print(token);
    try {
      response = await Api.post(
        url: '${baseURL}notification/status',
        token: token,
        body: {"token": deviceToken, "type": "android"},
      );
      if (response.statusCode == 200) {
        if (response.data["data"]["status"] == "enabled") {
          returnvalue = "true";
        } else if (response.data["data"]["status"] == "disabled") {
          returnvalue = "false";
        }
      } else {
        returnvalue = response;
      }
      return returnvalue;
    } catch (e) {
      log(e.toString());
      throw Exception('notification State error');
    }
  }

  Future<dynamic> notificatioDisable(String deviceToken) async {
    dynamic response;
    String? token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.delete(
        url: '${baseURL}notification/deviceTokenAndorid',
        token: token,
        body: {"token": deviceToken},
      );

      return response;
    } catch (e) {
      log(e.toString());
      throw Exception('notification disable error');
    }
  }

  Future<dynamic> notificatioEnable(String deviceToken) async {
    dynamic response;
    String? token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.post(
        url: '${baseURL}notification/deviceTokenAndorid',
        token: token,
        body: {"token": deviceToken},
      );
      return response;
    } catch (e) {
      log(e.toString());
      throw Exception('notification enable error');
    }
  }
}
