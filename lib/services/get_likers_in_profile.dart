import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class GetLikersInProfile {
  final Dio dio;
  final String baseUrl = 'http://16.171.65.142:3000/api/v1/';

  GetLikersInProfile(this.dio);

  Future<Object> likersList({int pageNumber = 0, required String id}) async {
    String? id;
    try {
      List<String> s = await loadPrefs();
      id = s[0];
    } catch (e) {
      log(e.toString());
    }
    Response response = await Api.get(
        '${baseUrl}users/$id/tweets/liked?limit=4&offset=$pageNumber');
    if (response is String) {
      return response as String;
    } else {
      List<Map<String, dynamic>> tweets =
          (response.data['data']['items']['data'] as List<dynamic>)
              .map((item) => {
                    'likesCount': item['mainInteraction']['likesCount'],
                    'viewsCount': item['mainInteraction']['viewsCount'],
                    'retweetsCount': item['mainInteraction']['retweetsCount'],
                    'commentsCount': item['mainInteraction']['commentsCount'],
                    'id': item['mainInteraction']['id'],
                    'userid': item['mainInteraction']['user']['id'],
                    'userImage': item['mainInteraction']['user']['avatar'],
                    'image': item['mainInteraction']['media'] != null
                        ? item['mainInteraction']['media'][0]
                        : null,
                    'userName': item['mainInteraction']['user']['name'],
                    'userHandle': item['mainInteraction']['user']['username'],
                    'time':
                        dateFormatter(item['mainInteraction']['createdDate']),
                    'tweetText': item['mainInteraction']['text']
                  })
              .toList();
      return tweets
          .map((e) => Tweet(
                id: e['id']!,
                image: e['image'],
                userImage: e['userImage']!,
                userHandle: e['userHandle']!,
                userName: e['userName']!,
                time: e['time']!,
                tweetText: e['tweetText'],
                userId: e['userid'],
                likesCount: 1,
                viewsCount: 1,
                retweetsCount: 1,
                commentsCount: 1,
                isUserLiked: true,
                isUserRetweeted: false,
                isUserCommented: false,
              ))
          .toList();
    }
  }
}
