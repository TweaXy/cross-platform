import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/models/user_signup.dart';
import 'package:tweaxy/services/signup_service.dart';

void main() {
  SignupService service = SignupService(Dio());
  group('Test Signup Api', () {
    test('Test1: Check Email Uniqueness For New Email Test', () async {
      expect(await service.emailUniqueness("yara.hisham.yh@gmail.com"), null);
    });
    log('\n');

    test('Test2: Check Email Uniqueness For Existing Email Test', () async {
      expect(await service.emailUniqueness("yarrahishamm61@gmail.com"),
          "Email has been used before");
    });
    log('\n');

    test('Test3: Check Email Uniqueness For Invalid Email Test', () async {
      expect(await service.emailUniqueness("yarrahishamm61gmail.com"),
          "must have email format"); //TODO
    });
    test('Test4: Send Email Verification Code For New Email Test', () async {
      UserSignup.setEmail = "yara.hisham.yh@gmail.com";

      expect(await service.sendEmailCodeVerification(), null);
    });
    log('\n');

    test('Test5: Too Much Requests Test', () async {
      expect(await service.sendEmailCodeVerification(),
          "More than one request in less than 30 seconds");
    });
    log('\n');

    test('Test6: Send Email Verification Code For Existing Email Test',
        () async {
      UserSignup.setEmail = "yarrahishamm61@gmail.com";
      expect(await service.sendEmailCodeVerification(),
          "Email is already exists and verified");
    });
    log('\n');

    test('Test7: Send Email Verification Code For Invalid Email Test',
        () async {
      UserSignup.setEmail = "yarrahishamm61gmail.com";
      expect(
          await service.sendEmailCodeVerification(), "must have email format");
    });
    log('\n');
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
