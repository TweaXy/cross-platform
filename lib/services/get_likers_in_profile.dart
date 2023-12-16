import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class GetLikersInProfile {
  final Dio dio;
  final String baseUrl = 'https://tweaxybackend.mywire.org/api/v1';

  GetLikersInProfile(this.dio);

  Future<Object> likersList({int pageNumber = 0, required String id}) async {
    // String? id;
    // try {
    //   List<String> s = await loadPrefs();
    //   id = s[0];
    // } catch (e) {
    //   log(e.toString());
    // }
    Response response = await Api.getwithToken(
        url: '$baseUrl/users/tweets/liked/$id?limit=4&offset=$pageNumber',
        token: TempUser.token);
    if (response is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;

    // print('rrrrr' + res.toString());
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
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }
}

bool intToBool(int a) => a == 0 ? false : true;
