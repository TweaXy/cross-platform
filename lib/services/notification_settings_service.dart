import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class NotificationSettingsService {
  final Dio dio;
  NotificationSettingsService(this.dio);

  Future<String> notificatioCheckState(String deviceToken) async {
    Response response;
    String returnvalue = "";
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
        url: '${baseURL}notification/satatus',
        token: token,
        body: {"token": deviceToken, "type": "android"},
      );
      if (response.statusCode == 200) {
        if (response.data["data"] == "status:enabled") {
          returnvalue = "true";
        } else {
          returnvalue = "false";
        }
      } else {
        returnvalue = "";
      }
      return returnvalue;
    } catch (e) {
      log(e.toString());
      throw Exception('notification State error');
    }
  }

  Future<String> notificatioDisable(String deviceToken) async {
    Response response;
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
      String ret = "fail";
      if (response.statusCode == 200) {
        ret = "sucess";
      }
      return ret;
    } catch (e) {
      log(e.toString());
      throw Exception('notification disable error');
    }
  }

  Future<String> notificatioEnable(String deviceToken) async {
    Response response;
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
      String ret = "fail";
      if (response.statusCode == 200) {
        ret = "sucess";
      }
      return ret;
    } catch (e) {
      log(e.toString());
      throw Exception('notification enable error');
    }
  }
}
