import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/shared/errors/update_username_errors.dart';
import 'package:tweaxy/shared/errors/validation_errors.dart';

Future<String?> emailValidation({required String? inputValue}) async {
  //initial validation function
  if (inputValue == null || inputValue.trim().isEmpty) {
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
  if (inputValue == null || inputValue.trim().isEmpty) {
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
  if (inputValue == null || inputValue.trim().isEmpty) {
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
  if (inputValue == null || inputValue.trim().isEmpty) {
    return ValidationErrors.emptyNameError;
  }
  if (inputValue.length < 3) {
    return ValidationErrors.nameLengthError;
  }
  return null;
}

Future<String?> codeValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.trim().isEmpty) {
    return ValidationErrors.emptyCodeError;
  }
  if (inputValue.length < 8) {
    return ValidationErrors.codeLengthError;
  }
  return null;
}

Future<String?> usernameValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.trim().isEmpty) {
    return ValidationErrors.emptyUsernameError;
  }
  if (inputValue.length < 5) {
    return ValidationErrors.usernameLengthError;
  }
  if (inputValue.contains(' ')) {
    return ValidationErrors.usernameSpaceError;
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

Future<String?> updateUsernameValidation({required String? inputValue}) async {
  if (inputValue == null || inputValue.trim().length < 5) {
    return UpdateUsernameErrors.usernameMinLengthError;
  }

  if (inputValue.contains(' ') ||
      inputValue.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return UpdateUsernameErrors.spaceError;
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
