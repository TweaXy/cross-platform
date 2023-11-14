import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/login_api.dart';

void main() {
  group('Test Login Api', () {
    test('Test1:Login for Existing username&password Test', () async {
      Map<String, dynamic> result = await LoginApi().postUser(
          {"UUID": "kaokabkareem@gmail.com", 'password': '123456789_Kk'});
      expect(result['status'], "success");
    });
    runTests();
    test('Test 2: Login for password wrong', () async {
      await expectLater(
        () async {
          await LoginApi().postUser(
              {"UUID": "kaokabkareem@gmail.com", 'password': '12345678899_Kk'});
        },
        throwsA(
          isA<DioError>().having(
            (error) => error.response?.data['message'],
            'message',
            contains('wrong password'),
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
