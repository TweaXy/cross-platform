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
  String tweetId = 'b94430alg723ceppltg3hq9my';
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiaDJud2hld3NjNTk0eXJiNHB6Y2tqc2w3eVwiIiwiaWF0IjoxNzAzNjk0Nzk4LCJleHAiOjE3MDYyODY3OTh9.cizBQ_4z1mRO5-qv335hjpJHRMRohBBSm_c2DrSKpyU';
  group('Test Get Replies Api', () {
    group('Test Get Replies Api', () {
      test('Test1:  Get Replies for invalid token', () async {
        expect(
            await Api.getwithToken(
                url: '${baseURL}interactions/$tweetId/replies?limit=5&offset=3',
                token: '-1'),
            "token not valid");
      });

      test('Test2:  Get Replies for valid token and userid', () async {
        expect(await postsReplies(tweetId, token), isA<List<Tweet>>());
      });
      test('Test3:  Get Replies for invalid tweetid', () async {
        expect(   await Api.getwithToken(
                url: '${baseURL}interactions/-1/replies?limit=5&offset=3',
                token: token),
            "no interaction found ");
      });
    });
  });
}

Future<List<Tweet>> postsReplies(String tweetId, String token) async {
  Response res = await Api.getwithToken(
      url: '${baseURL}interactions/$tweetId/replies?limit=5&offset=3',
      token: token);

  List<Map<String, dynamic>> m = await mapToList(res,isforreply: true);

  List<Tweet> t = initializeTweets(m);
  return t;
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
