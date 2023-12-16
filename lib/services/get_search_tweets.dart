import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class SearchTweetTweets {
  final dio = Dio();
  SearchTweetTweets();
  Future<List<Tweet>> getSearchTweets({
    String? username,
    String? query,
    required int offset,
    required int pageSize,
  }) async {
    dynamic response;
    String token;

    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    print(token);
    if (username == null) {
      String u =
          "https://tweaxybackend.mywire.org/api/v1/tweets/search?keyword=$query&username=&limit=$pageSize&offset=$offset";
      response = await Api.getwithToken(
        url: u,
        token: token,
      );
    } else if (query == null) {
      response = await Api.getwithToken(
        url:
            "https://tweaxybackend.mywire.org/api/v1/tweets/search?keyword=&username=$username&limit=$pageSize&offset=$offset",
        token: token,
      );
    } else {
      response = await Api.getwithToken(
        url:
            "https://tweaxybackend.mywire.org/api/v1/tweets/search?keyword=$query&username=$username&limit=$pageSize&offset=$offset",
        token: token,
      );
    }
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
                  ,'isretweet':
                  item['mainInteraction']['type'] == "TWEET" ? false : true
            })
        .toList();
    print('ressss' + m.toString());

    print('mm' + m.toString());
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }
}
