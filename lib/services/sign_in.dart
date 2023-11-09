import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/api.dart';

class SignInServices {
  SignInServices._();
  static SignInServices? _instance;
  static String email = '';
  // http://16.171.65.142:3000/api/v1/docs/
  static String token = ''; //code sent to email
  static String baseUrl = kIsWeb
      ? 'http://16.171.65.142:3000/api/v1'
      : 'http://192.168.1.47:3000/api/v1';
  // String baseUrl = 'http://localhost:3000/api/v1';
  static void setEmail({required String email}) {
    SignInServices.email = email;
  }

  static void setToken({required String token}) {
    SignInServices.token = token;
  }

  static dynamic forgetPassword() async {
    print(email);
    var res = await Api.post(
      body: {'UUID': email},
      url: '$baseUrl/auth/forgetPassword',
    );
    print('signin' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }

  static dynamic resetPassword(String password) async {
    var res = await Api.post(
      url: '$baseUrl/auth/resetPassword/$email/$token',
      body: {"password": password},
    );
    print('reset' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }
}
