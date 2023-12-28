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
      final response =
          await service.emailUniqueness("yara.hisham.yh@gmail.com");
      expect(response.data['status'] == 'success', true);
    });
    log('\n');

    test('Test2: Check Email Uniqueness For Existing Email Test', () async {
      expect(await service.emailUniqueness("Pete@gmail.com"),
          "email already exists");
    });
    log('\n');

    test('Test3: Check Email Uniqueness For Invalid Email Test', () async {
      expect(await service.emailUniqueness("yarrahishamm61gmail.com"),
          "must have email format"); //TODO
    });
    test('Test4: Send Email Verification Code For New Email Test', () async {
      UserSignup.setEmail = "yara.hisham.yh@gmail.com";
      final response = await service.sendEmailCodeVerification();
      expect(response.data['status'] == 'success', true);
    });
    log('\n');

    test('Test5: Too Much Requests Test', () async {
      UserSignup.setEmail = "yara.hisham.yh@gmail.com";

      expect(await service.sendEmailCodeVerification(),
          "More than one request in less than 30 seconds");
    });
    log('\n');

    test('Test6: Send Email Verification Code For Existing Email Test',
        () async {
      UserSignup.setEmail = "Pete@gmail.com";
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
  test(
      'Test8: Create Account with invalid password Test (no lower case letter)',
      () async {
    UserSignup.setEmail = "yara.hisham.yh@gmail.com";
    UserSignup.setName = "Yara";
    UserSignup.setBirthdayDate = "10-10-2001";
    UserSignup.setPassword = "12345668T@";
    UserSignup.setEmailVerificationToken = "74b9adc4";
    expect(await service.createAccount(),
        'password must contain at least 1 lower case letter');
  });
  test(
      'Test9: Create Account with invalid password Test (no upper case letter)',
      () async {
    UserSignup.setEmail = "yara.hisham.yh@gmail.com";
    UserSignup.setName = "Yara";
    UserSignup.setBirthdayDate = "10-10-2001";
    UserSignup.setPassword = "12345668t@";
    UserSignup.setEmailVerificationToken = "74b9adc4";
    expect(await service.createAccount(),
        'password must contain at least 1 upper case letter');
  });
  test(
      'Test10: Create Account with invalid password Test (no special character)',
      () async {
    UserSignup.setEmail = "yara.hisham.yh@gmail.com";
    UserSignup.setName = "Yara";
    UserSignup.setBirthdayDate = "10-10-2001";
    UserSignup.setPassword = "12345668tT";
    UserSignup.setEmailVerificationToken = "74b9adc4";
    expect(await service.createAccount(),
        'password must contain at least 1 special character');
  });
  test('Test11: Create Account with invalid verfication code', () async {
    UserSignup.setEmail = "yara.hisham.yh@gmail.com";
    UserSignup.setName = "Yara";
    UserSignup.setBirthdayDate = "10-10-2001";
    UserSignup.setPassword = "12345668tT@";
    UserSignup.setEmailVerificationToken = "74b9c4";
    expect(await service.createAccount(),
        'email verification code must be 8 characters');
  });

  test('Test12: Create Account with random verfication code', () async {
    UserSignup.setEmail = "yara.hisham.yh@gmail.com";
    UserSignup.setName = "Yara";
    UserSignup.setBirthdayDate = "10-10-2001";
    UserSignup.setPassword = "12345668tT@";
    UserSignup.setEmailVerificationToken = "18js924d";
    expect(await service.createAccount(), 'Email Verification Code is invalid');
  });

  test('Test12: Create Account Test', () async {
    UserSignup.setEmail = "yara.hisham.yh@gmail.com";
    UserSignup.setName = "yara";
    UserSignup.setBirthdayDate = "10-10-2001";
    UserSignup.setPassword = "12345678tT@";
    UserSignup.setEmailVerificationToken = "7ec54399";
    final response = await service.createAccount();
    expect(response.data['status'] == 'success', true);
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
