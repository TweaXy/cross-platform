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
  group('Test Get Tweets Home Api', () {
    group('Test Get Tweets Home Api', () {
      test('Test1:  Get Tweets Profile for invalid token', () async {
        expect(
            await Api.getwithToken(
                url: '${baseURL}home?/limit=10&offset=3', token: '-1'),
            "token not valid");
      });

      test('Test2:  Get Tweets Home for valid token and userid', () async {
        expect(await postsInHome('0', token), isA<List<Tweet>>());
      });
    });
  });
}

Future<List<Tweet>> postsInHome(String offset, String token) async {
  Response res = await Api.getwithToken(
      url: '${baseURL}home?/limit=10&offset=$offset', token: token);

  List<Map<String, dynamic>> m = await mapToList(res);

  List<Tweet> t = initializeTweets(m);
  return t;
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
