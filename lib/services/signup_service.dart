import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';

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
        token: User.emailVerificationToken,
        body: {
          "email": User.email,
          "username": User.username,
          "name": User.name,
          "birthdayDate": User.birthdayDate,
          "password": User.password,
          "emailVerificationToken": User.emailVerificationToken,
          "avatar": User.profilePicture
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
        token: User.emailVerificationToken,
        body: {"email": email},
      );
      log(response.toString());
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(response.toString());
        log("Service:" + e.toString());
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
        token: User.emailVerificationToken,
        body: {"username": username},
      );
      log(response.toString());
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(response.toString());
        log("Service:" + e.toString());
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
        token: User.emailVerificationToken,
        body: {"email": User.email},
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
        '${baseUrl}auth/checkEmailVerification/${User.email}/$code',
      );
      log("response " + response.toString());

      return response;
    } catch (e) {
      log(e.toString());
      log("response " + response.toString());
      return response;
    }
  }
}
