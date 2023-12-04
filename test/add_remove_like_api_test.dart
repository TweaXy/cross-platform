import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/services/like_tweet.dart';

void main() {
  String tweetId = '';
  String token = '';
  group('Like_Tweet', () {
    test('Like Tweet', () async {
      var response = await LikeTweet.likeTweet(tweetId, token);
      expect(true, response);
    });
    test('Like Error Tweet', () async {
      var response = await LikeTweet.likeTweet(tweetId, token);
      expect(false, response);
    });
    test('Unlike Tweet', () async {
      var response = await LikeTweet.unLikeTweet(tweetId, token);
      expect(true, response);
    });
    test('Unlike Error Tweet', () async {
      var response = await LikeTweet.unLikeTweet(tweetId, token);
      expect(false, response);
    });
  });
}
