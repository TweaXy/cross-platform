import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user_signup.dart';

class SignupService {
  final Dio dio;
  final String baseUrl = 'http://16.171.65.142:3000/api/v1/';

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
          "username": UserSignup.username,
          "name": UserSignup.name,
          "birthdayDate": UserSignup.birthdayDate,
          "password": UserSignup.password,
          "emailVerificationToken": UserSignup.emailVerificationToken,
          "avatar": UserSignup.profilePicture
        },
      );

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
}
