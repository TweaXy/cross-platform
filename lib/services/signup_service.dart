import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';

class SignupService {
  final Dio dio;
  final String baseUrl = kIsWeb
      ? 'http://localhost:3000/api/v1'
      : 'http://16.171.65.142:3000/api/v1/';

  SignupService(this.dio);

  Future createAccount() async {
    //TODO: Handle diffrent errors msgs
    Response response;
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
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('oops something went wrong');
    }
  }
}
