import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/services/tweets_services.dart';

void main() {
  String baseUrl = '${baseURL}';

  group('Test Get Tweets Home Api', () {
    test('Test1:  Get Tweets Home for invalid token', () async {
      expect(
          await Api.getwithToken(
              url: '${baseURL}home?/limit=5&offset=2', token: '5'),
          "token not valid");
    });
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
