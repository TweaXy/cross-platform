import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user_signup.dart';

class SignupService {
  final Dio dio;
  final String baseUrl = 'https://tweaxybackend.mywire.org/api/v1/';

  SignupService(this.dio);

  Future createAccount() async {
    //TODO: Handle diffrent errors msgs
    dynamic response;
    try {
      response = await Api.post(
        url: '${baseUrl}auth/signup',
        token: UserSignup.emailVerificationToken,
        body: {
          "email": UserSignup.email,
          "name": UserSignup.name,
          "birthdayDate": UserSignup.birthdayDate,
          "password": UserSignup.password,
          "emailVerificationToken": UserSignup.emailVerificationToken,
        },
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", response.data['data']['user']['id'].toString());
      prefs.setString("token", response.data['data']['token'].toString());

      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('oops something went wrong');
    }
  }

  Future emailUniqueness(String email) async {
    dynamic response;
    try {
      response = await Api.post(
        url: '${baseUrl}users/checkEmailUniqueness',
        token: UserSignup.emailVerificationToken,
        body: {"email": email},
      );
      log(response.toString());
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(response.toString());
        log("Service:$e");
      } //debug mode only
      return response;
      // throw Exception('Email Uniqueness Api error ');
    }
  }

  Future usernameUniqueness(String username) async {
    dynamic response;
    try {
      response = await Api.post(
        url: '${baseUrl}users/checkUsernameUniqueness',
        token: UserSignup.emailVerificationToken,
        body: {"username": username},
      );
      log(response.toString());
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(response.toString());
        log("Service:$e");
      } //debug mode only
      return response;
      // throw Exception('Email Uniqueness Api error ');
    }
  }

  Future<dynamic> sendEmailCodeVerification() async {
    dynamic response;
    try {
      response = await Api.post(
        url: '${baseUrl}auth/sendEmailVerification',
        token: UserSignup.emailVerificationToken,
        body: {"email": UserSignup.email},
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('varification code error ');
    }
  }

  Future checkEmailCodeVerification({required String code}) async {
    dynamic response;
    try {
      response = await Api.get(
        '${baseUrl}auth/checkEmailVerification/${UserSignup.email}/$code',
      );
      log("response $response");

      return response;
    } catch (e) {
      log(e.toString());
      log("response $response");
      return response;
    }
  }

  Future<dynamic> authentication() async {
    dynamic response;
    try {
      response = await Api.post(
        url: '${baseUrl}auth/captcha',
        token: UserSignup.emailVerificationToken,
        body: {},
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('Capthca authentication error');
    }
  }

  Future updateAvater() async {
    dynamic response;
    String? token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
    } catch (e) {
      log(e.toString());
    }
    try {
      final bytes = await UserSignup.profilePicture.readAsBytes();
      FormData formData = FormData.fromMap({
        "avatar": MultipartFile.fromBytes(
          bytes.toList(),
          filename: 'avatar.png',
        ),
      });
      response = await Api.patch(
        url: '${baseUrl}users',
        token: token,
        body: formData,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('Capthca authentication error');
    }
  }

  Future updateUsername(String newUsername) async {
    dynamic response;
    String? token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.patch(
        url: '${baseUrl}users/updateUserName',
        token: token,
        body: {
          "username": newUsername,
        },
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('Capthca authentication error');
    }
  }
}
