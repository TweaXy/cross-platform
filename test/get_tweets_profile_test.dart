import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

void main() {
  String baseUrl = 'https://tweaxybackend.mywire.org/api/v1';
  String userid = "gz8kvi9ki9eaud3b1m46woduh";
  group('Test Get Tweets Profile Api', () {
    test('Test1:  Get Tweets Profile for invalid user id', () async {
      expect(
          await Api.getwithToken(
              url: '${baseURL}users/-1/tweets?limit=5&offset=2', token: '5'),
          "no user found ");
    });
    // test('Test2:  Get Tweets Profile for valid user id and invalid token',
    //     () async {
    //   expect(
    //       await Api.getwithToken(
    //           url: '$baseUrl/users/$userid/tweets?limit=5&offset=2',
    //           token: '---0'),
    //       "no user found");
    // });
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
