import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

void main() {
  String userid = "eissqonj1eb4g2fgrbr3idsam";
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiZWlzc3FvbmoxZWI0ZzJmZ3JicjNpZHNhbVwiIiwiaWF0IjoxNzAzNjg3NzgxLCJleHAiOjE3MDYyNzk3ODF9.1n_frZ40vH0NxBwBWdAxcM26z-gNdN4XROoR9gkmJt0';
  group('Test Get Tweets Trend Api', () {
    group('Test Get Tweets Trend Api', () {
      test('Test1:  Get Tweets Trend for invalid token', () async {
        expect(
            await Api.getwithToken(
                url: '${baseURL}trends/hello?limit=5&offset=3', token: '-1'),
            "token not valid");
      });

      test('Test2:  Get Tweets Trend for valid token and userid', () async {
        expect(await postsInTrends('0', token), isA<List<Tweet>>());
      });
     
    });
  });
}

Future<List<Tweet>> postsInTrends(String offset, String token) async {
  Response res = await Api.getwithToken(
      url: '${baseURL}trends/adimpleo?limit=5&offset=$offset', token: token);

  List<Map<String, dynamic>> m = await mapToList(res);

  List<Tweet> t = initializeTweets(m);
  return t;
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
