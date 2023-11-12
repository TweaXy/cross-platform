import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/services/signup_service.dart';

Future<String?> emailValidation({required String? inputValue}) async {
  //initial validation function
  if (inputValue == null || inputValue.isEmpty) {
    return "Email is required";
  }
  if (!inputValue.contains('@') || inputValue.length < 4) {
    return "Email is invalid";
  }
  try {
    dynamic response = await SignupService(Dio()).emailUniqueness(inputValue);
    if (response is String) {
      return response;
    }
    return null;
  } catch (e) {
    log(e.toString());
    return "Email Uniqueness Api error ";
  }
}

Future<String?> emailExists({required String? inputValue}) async {
  if (inputValue == null || inputValue.isEmpty) {
    return "Email is required";
  }
  if (!inputValue.contains('@') || inputValue.length < 4) {
    return "Email is invalid";
  }
  try {
    String response = await SignInServices.forgetPassword();
    return response;
  } catch (e) {
    log(e.toString());
    return "Email Exists Api error";
  }
}

String? passwordValidation({required String? inputValue}) {
  //initial validation function
  if (inputValue == null || inputValue.isEmpty) {
    return "Password is required";
  }
  if (inputValue.length < 8) {
    return "Password must be at least 8 characters";
  }
  if (!(inputValue.contains(RegExp(r'[a-z]')))) {
    return 'Password should contain at least one small letter';
  }

  if (!(inputValue.contains(RegExp(r'[A-Z]')))) {
    return 'Password should contain at least one capital letter';
  }

  if (!(inputValue.contains(RegExp(r'[0-9]')))) {
    return 'Password should contain a number';
  }

  if (!(inputValue.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))) {
    return 'Password should contain at least one special character';
  }

  return null;
}

String? nameValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return "Name is required";
  }
  return null;
}

Future<String?> codeValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.isEmpty) {
    return "Code is required";
  }
  if (inputValue.length < 8) {
    return "Code must be exactly 8 characters";
  }
  return null;
}

Future<String?> usernameValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.isEmpty) {
    return "Username is required";
  }
  if (inputValue.length < 4) {
    return "Username must be at least 4 characters";
  }
  try {
    dynamic response =
        await SignupService(Dio()).usernameUniqueness(inputValue);
    if (response is String) {
      return response;
    }
    return null;
  } catch (e) {
    log(e.toString());
    return "Username Uniqueness Api error ";
  }
}
