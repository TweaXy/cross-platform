import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/login_api.dart';

void main() {
  group('Test Login Api', () {
    test('Test1:Login for Existing email Test', () async {
      Map<String, dynamic> result =
          await LoginApi().getEmailExist({"UUID": "kaokabkareem@gmail.com"});
      expect(result['status'], "success");
    });
    runTests();
    test('Test 2: Login for Non-Existing Email', () async {
      await expectLater(
        () async {
          await LoginApi().getEmailExist({"UUID": "kaokabkfdwareem@gmail.com"});
        },
        throwsA(
          isA<DioError>().having(
            (error) => error.response?.data['message'],
            'message',
            contains('no user found'),
          ),
        ),
      );
    });
    print('\n');
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
