import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class TweetsServices {
  static String baseUrl = 'http://16.171.65.142:3000/api/v1';
  static Future<List<Tweet>> getTweetsHome({required int offset}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    // print('kkk' + s.toString());
    //down->false
    // print('scroll=' + scroll.position.userScrollDirection.toString());
    Response res = await Api.getwithToken(
        url: '$baseUrl/home?/limit=10&offset=$offset', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;
    // if (scroll.position.userScrollDirection == ScrollDirection.reverse &&
    //     response.data['pagination']['nextPage'] != null) //downward
    // {
    //   response = await Api.getwithToken(
    //       url: response!.data['pagination']['nextPage'], token: s!);
    // } else if (scroll.position.userScrollDirection == ScrollDirection.forward &&
    //     response.data['pagination']['prevPage'] != null) //up
    // {
    //   response = await Api.getwithToken(
    //       url: response!.data['pagination']['prevPage'], token: s!);
    // }
// print('rrrrr'+res.t)
    List<Map<String, dynamic>> m = (res.data['data']['items'] as List<dynamic>)
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
            })
        .toList();
    print('mm' + m.toString());
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<String> deleteTweet({required String tweetid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    print(s);
    print(tweetid);
    dynamic res =
        await Api.delete(url: '$baseUrl/interactions/$tweetid', token: s);
    print('ressss of delete' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }

  static Future<List<Tweet>> getProfilePosts(
      {required int offset, required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    Response res = await Api.getwithToken(
        url: '$baseUrl/users/$id/tweets?limit=5&offset=$offset', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;

    // print('rrrrr' + res.toString());
    List<Map<String, dynamic>> m = (res.data['data']['items']['data']
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
            })
        .toList();
    print('mm' + m.toString());
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }
}

bool intToBool(int a) => a == 0 ? false : true;
