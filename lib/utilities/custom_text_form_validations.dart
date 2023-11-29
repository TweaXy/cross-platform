import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/shared/errors/validation_errors.dart';

Future<String?> emailValidation({required String? inputValue}) async {
  //initial validation function
  if (inputValue == null || inputValue.isEmpty) {
    return ValidationErrors.emptyEmailError;
  }
  if (!inputValue.contains('@') || inputValue.length < 4) {
    return ValidationErrors.invalidEmailError;
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
    return ValidationErrors.emptyEmailError;
  }
  if (!inputValue.contains('@') || inputValue.length < 4) {
    return ValidationErrors.invalidEmailError;
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
    return ValidationErrors.emptyPasswordError;
  }
  if (inputValue.length < 8) {
    return ValidationErrors.passwordLengthError;
  }
  if (!(inputValue.contains(RegExp(r'[a-z]')))) {
    return ValidationErrors.passwordSmallLetterError;
  }

  if (!(inputValue.contains(RegExp(r'[A-Z]')))) {
    return ValidationErrors.passwordCapitalLetterError;
  }

  if (!(inputValue.contains(RegExp(r'[0-9]')))) {
    return ValidationErrors.passwordNumberError;
  }

  if (!(inputValue.contains(RegExp(r'[!@#$%^&*(),.?_":{}|<>]')))) {
    return ValidationErrors.passwordSpecialCharacterError;
  }

  return null;
}

String? nameValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return ValidationErrors.emptyNameError;
  }
  return null;
}

Future<String?> codeValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.isEmpty) {
    return ValidationErrors.emptyCodeError;
  }
  if (inputValue.length < 8) {
    return ValidationErrors.codeLengthError;
  }
  return null;
}

Future<String?> usernameValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.isEmpty) {
    return ValidationErrors.emptyUsernameError;
  }
  if (inputValue.length < 4) {
    return ValidationErrors.usernameLengthError;
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
