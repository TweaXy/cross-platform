import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class GetMentionedTweets {
  GetMentionedTweets._();
  static const String _endpoint = 'users/tweets/mentioned/';
  static Future<List<Tweet>> getMentionedTweets(String id,
      {int pageSize = 20, int offset = 0, String token = ''}) async {
    var response = await Api.getwithToken(
      url: '$baseURL$_endpoint$id?limit=$pageSize&offset=$offset',
      token: token,
    );
    List<Map<String, dynamic>> m = mapToList(response);
    List<Tweet> tweets = initializeTweets(m);
    return tweets;
  }
}
