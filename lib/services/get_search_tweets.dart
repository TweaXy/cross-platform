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
    if (response is String) {
      return [];
    }
    List<Map<String, dynamic>> m = mapToList(response);
    print('ressss' + m.toString());

    print('mm' + m.toString());
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }
}
