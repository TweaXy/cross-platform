import 'dart:math';

import 'package:dio/dio.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/users.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginApi {
  final dio = Dio();

  LoginApi();
  Future<dynamic> postUser(Map<String, String> data) async {
    Response response =
        await dio.post('http://16.171.65.142:3000/api/v1/auth/login',
            data: data,
            options: Options(headers: {
              "Content-Type": "application/json",
            }));
    return response.data;
  }

  Future<dynamic> getEmailExist(Map<String, String> data) async {
    Response response =
        await dio.post('http://16.171.65.142:3000/api/v1/users/checkUUIDExists',
            data: data,
            options: Options(headers: {
              "Content-Type": "application/json",
            }));
    return response.data;
  }

  Future<dynamic> SignInWithGoogle() async {
    String googleSignInUrl = Uri.encodeFull(
        "http://ec2-16-171-65-142.eu-north-1.compute.amazonaws.com:3000/api/v1/auth/google/callback");

    // Launch the Google Sign-In URL in the default web browser or a WebView
    if (await canLaunch(googleSignInUrl)) {
      await launch(googleSignInUrl, forceWebView: true);
      Response response = await dio.get(
          "http://ec2-16-171-65-142.eu-north-1.compute.amazonaws.com:3000/api/v1/auth/google/callback");

      return response.data;
    } else {
      throw "Could not launch Google Sign-In URL";
    }
  }
}
