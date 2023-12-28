import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/like_tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';

void main() {
  String tweetId = 'b94430alg723ceppltg3hq9my';
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiaDJud2hld3NjNTk0eXJiNHB6Y2tqc2w3eVwiIiwiaWF0IjoxNzAzNjk1NjEwLCJleHAiOjE3MDYyODc2MTB9.mgE8vixCONaqkLKkzlbcCCdUE1HZkGDp7Rky7ohwbTA';
  group('ReTweet', () {
    test('Re-Tweet', () async {
      var response = await addRetweet(tweetId, token);

      expect(response, true);
    });
     test('Re-Tweet with invalid token', () async {
      var response = await addRetweet(tweetId, '-1');

      expect(response, false);
    });
     test('Re-Tweet on an already retweeted post', () async {
      var response = await addRetweet(tweetId,token);

      expect(response, false);
    });
     test('Delete Re-Tweet ', () async {
      var response = await deleteRetweet(tweetId,token);

      expect(response, true);
    });
     test('Delete Re-Tweet with invalid token ', () async {
      var response = await deleteRetweet(tweetId,'-1');

      expect(response, false);
    });
    test('Delete Re-Tweet where no retweet ', () async {
      var response = await deleteRetweet(tweetId,'-1');

      expect(response, false);
    });
    
  });
}

Future<bool> addRetweet(String id, String token) async {
  var dio = Dio();

  try {
    var response = await dio.post(
      '${baseURL}interactions/$id/retweet',
      options: Options(headers: {'Authorization': 'Bearer ${token}'}),
    );
    print(response.toString());
    print('Liked');
    return true;
  } catch (e) {
    return false;
  }
}
Future<bool> deleteRetweet(String id, String token) async {
  var dio = Dio();

  try {
    var response = await dio.delete(
      '${baseURL}interactions/retweet/$id',
      options: Options(headers: {'Authorization': 'Bearer ${token}'}),
    );
    print(response.toString());
    print('Liked');
    return true;
  } catch (e) {
    return false;
  }
}
