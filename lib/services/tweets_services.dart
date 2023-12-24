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
  static String baseUrl = 'https://tweaxybackend.mywire.org/api/v1';
  static Future<List<Tweet>> getTweetsHome({required int offset}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    // print('scroll=' + scroll.position.userScrollDirection.toString());
    Response res = await Api.getwithToken(
        url: '$baseUrl/home?/limit=10&offset=$offset', token: s);

    if (res is String) {
      // throw Future.error(res);
      return [];
    }

    List<Map<String, dynamic>> m = await mapToList(res);

    List<Tweet> t = initializeTweets(m);
    print('tt' + t.toString());
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
        url: '$baseUrl/users/tweets/$id?limit=5&offset=$offset', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;

    // print('rrrrr' + res.toString());
    List<Map<String, dynamic>> m = await mapToList(res);
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<List<bool>> isFollowed(String userid) async {
    dynamic result = await Api.getwithToken(
        token: TempUser.token,
        url: 'https://tweaxybackend.mywire.org/api/v1/users/$userid');
    print('resulttt' + result.toString());
    if (result is String) {
      return [];
    } else if (result is Response) {
      Response res = result;
      List<bool> ret = [
        res.data['data']['user']['followedByMe'],
        res.data['data']['user']['followsMe'],
        TempUser.id == userid
      ];
      return ret;
    }
    return [];
  }

  static Future<List<Tweet>> getTweetsTrend(
      {required int offset, required String trendname}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    Response res = await Api.getwithToken(
        url: '$baseUrl/trends/$trendname?limit=5&offset=$offset', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;

    // print('rrrrr' + res.toString());
    List<Map<String, dynamic>> m = await mapToList(res);
    print('ressss' + m.toString());

    print('mm' + m.toString());
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<List<Tweet>> getReplies(
      {required int offset, required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    Response res = await Api.getwithToken(
        url: '$baseUrl/interactions/$id/replies?limit=5&offset=$offset',
        token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;
    if (res.data['data'] == []) return [];
    print('rrrrr' + res.data['data'].toString());
    List<Map<String, dynamic>> m = mapToList(res, isforreply: true);
    print('ressss' + m.toString());

    print('mm' + m.toString());
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<dynamic> getMainTweetForReply(
      {required int offset, required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    Response res = await Api.getwithToken(
        url: '$baseUrl/interactions/$id/replies?limit=5&offset=$offset',
        token: s);
    if (res is String) {
      throw Future.error(res);
      return null;
    }

    Tweet t = Tweet(
      likesCount: res.data['data']['parent']['mainInteraction']['likesCount'],
      retweetsCount: res.data['data']['parent']['mainInteraction']
          ['retweetsCount'],
      viewsCount: res.data['data']['parent']['mainInteraction']['viewsCount'],
      commentsCount: res.data['data']['parent']['mainInteraction']
          ['commentsCount'],
      id: res.data['data']['parent']['mainInteraction']['id'],
      userId: res.data['data']['parent']['mainInteraction']['user']['id'],
      userImage: res.data['data']['parent']['mainInteraction']['user']
                  ['avatar'] !=
              null
          ? res.data['data']['parent']['mainInteraction']['user']['avatar']
          : 'b631858bdaafa77258b9ed2f7c689bdb.png',
      image: res.data['data']['parent']['mainInteraction']['media'] != null
          ? getImageList(
              res.data['data']['parent']['mainInteraction']['media'].toList())
          : null,
      userName: res.data['data']['parent']['mainInteraction']['user']['name'],
      userHandle: res.data['data']['parent']['mainInteraction']['user']
          ['username'],
      time: dateFormatter(
          res.data['data']['parent']['mainInteraction']['createdDate']),
      tweetText: res.data['data']['parent']['mainInteraction']['text'],
      isUserLiked: intToBool(res.data['data']['parent']['mainInteraction']
          ['isUserInteract']['isUserLiked']),
      isUserRetweeted: intToBool(res.data['data']['parent']['mainInteraction']
          ['isUserInteract']['isUserRetweeted']),
      isUserCommented: intToBool(res.data['data']['parent']['mainInteraction']
          ['isUserInteract']['isUserCommented']),
      createdDate: calculateTime(
          res.data['data']['parent']['mainInteraction']['createdDate']),
      isretweet:
          res.data['data']['parent']['mainInteraction']['type'] != "RETWEET"
              ? false
              : true,
      reposteruserid: '',
      reposteruserName: '',
      parentid: res.data['data']['parent']['mainInteraction']['id'],
      isUserBlockedByMe: res.data['data']['parent']['mainInteraction']['user']
              ['blockedByMe'] ??
          false,
      isUserMutedByMe: res.data['data']['parent']['mainInteraction']['user']
              ['mutedByMe'] ??
          false,
      isShown: true,
    );
    return t;
  }

  static Future<bool> addRetweet(String id) async {
    var dio = Dio();
    print(id);
    try {
      var response = await dio.post(
        '$baseUrl/interactions/$id/retweet',
        options:
            Options(headers: {'Authorization': 'Bearer ${TempUser.token}'}),
      );
      print('Liked');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteRetweet({required String tweetid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    dynamic res = await Api.delete(
        url: '$baseUrl/interactions/retweet/$tweetid', token: s);
    if (res is String)
      return false;
    else
      return true;
  }
}

bool intToBool(int a) => a == 0 ? false : true;
