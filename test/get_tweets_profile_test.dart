import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

void main() {
  String userid = "eissqonj1eb4g2fgrbr3idsam";
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiZWlzc3FvbmoxZWI0ZzJmZ3JicjNpZHNhbVwiIiwiaWF0IjoxNzAzNjg3NzgxLCJleHAiOjE3MDYyNzk3ODF9.1n_frZ40vH0NxBwBWdAxcM26z-gNdN4XROoR9gkmJt0';
  print(baseURL.toString());
  group('Test Get Tweets Profile Api', () {
    test('Test1:  Get Tweets Profile for invalid user id', () async {
      expect(
          await Api.getwithToken(
              url: '${baseURL}users/tweets/-1?limit=5&offset=3', token: token),
          "no user found ");
    });
    test('Test2:  Get Tweets Profile for invalid token', () async {
      expect(
          await Api.getwithToken(
              url: '${baseURL}users/tweets/-1?limit=5&offset=3', token: '-1'),
          "token not valid");
    });

    test('Test3:  Get Tweets Profile for valid token and userid', () async {
      expect(
          await postsInProfile(userid, '0', token), isA<List<Tweet>>());
    });
  });
}

Future<List<Tweet>> postsInProfile(
    String id, String offset, String token) async {
  Response res = await Api.getwithToken(
      url: '${baseURL}users/tweets/$id?limit=5&offset=$offset', token: token);
  
  // Response response = res;

  // print('rrrrr' + res.toString());
  List<Map<String, dynamic>> m = await mapToList(res);
  List<Tweet> t = initializeTweets(m);
  return t;
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
