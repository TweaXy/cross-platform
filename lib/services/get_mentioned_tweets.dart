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
    List<Map<String, dynamic>> m = (response.data['data']['items']
            as List<dynamic>)
        .map((item) => {
              'likesCount': item['mainInteraction']['likesCount'],
              'viewsCount': item['mainInteraction']['viewsCount'],
              'retweetsCount': item['mainInteraction']['retweetsCount'],
              'commentsCount': item['mainInteraction']['commentsCount'],
              'id': item['mainInteraction']['id'],
              'userid': item['mainInteraction']['user']['id'],
              'userImage': item['mainInteraction']['user']['avatar'],
              'image': item['mainInteraction']['media'] != null
                  ? item['mainInteraction']['media'].toList()
                  : null,
              'userName': item['mainInteraction']['user']['name'],
              'userHandle': item['mainInteraction']['user']['username'],
              'time': dateFormatter(item['mainInteraction']['createdDate']),
              'tweetText': item['mainInteraction']['text'],
              'isUserLiked': intToBool(
                  item['mainInteraction']['isUserInteract']['isUserLiked']),
              'isUserRetweeted': intToBool(
                  item['mainInteraction']['isUserInteract']['isUserRetweeted']),
              'isUserCommented': intToBool(
                  item['mainInteraction']['isUserInteract']['isUserCommented']),
              'createdDate':
                  calculateTime(item['mainInteraction']['createdDate'])
            })
        .toList();
    List<Tweet> tweets = initializeTweets(m);
    return tweets;
  }
}
