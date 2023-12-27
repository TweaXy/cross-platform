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
  String tweetid = 'xz5jzcgv7icfnmzqoevkqnob0';
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiaDJud2hld3NjNTk0eXJiNHB6Y2tqc2w3eVwiIiwiaWF0IjoxNzAzNjkzNzYzLCJleHAiOjE3MDYyODU3NjN9.9IeCNdaMQu3zf8qDU_MLDK7e0cUBgayQfuVJApW5mPQ";
  group('Test Delete Tweets ', () {
    group('Test Delete Tweets Api', () {
      test('Test1:  Delete Tweet for valid tweetid and valid token', () async {
        dynamic res = await Api.delete(
            url: '${baseURL}interactions/$tweetid', token: token);

        expect(
            await Api.delete(
                url: '${baseURL}interactions/$tweetid', token: token),
            "success");
      });
    });
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
