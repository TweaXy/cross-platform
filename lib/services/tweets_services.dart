import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class TweetsServices {
  static Future<List<Tweet>> getTweetsHome({required int offset}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    // print('scroll=' + scroll.position.userScrollDirection.toString());
    Response res = await Api.getwithToken(
        url: '${baseURL}home?/limit=10&offset=$offset', token: s);

    if (res is String) {
      // throw Future.error(res);
      return [];
    }

    List<Map<String, dynamic>> m = mapToList(res);

    List<Tweet> t = initializeTweets(m);
    print('tt$t');
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<String> deleteTweet({required String tweetid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    print(s);
    print(tweetid);
    dynamic res =
        await Api.delete(url: '${baseURL}interactions/$tweetid', token: s);
    if (res is String) {
      return res;
    } else {
      return "success";
    }
  }

  static Future<List<Tweet>> getProfilePosts(
      {required int offset, required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    Response res = await Api.getwithToken(
        url: '${baseURL}users/tweets/$id?limit=5&offset=$offset', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;

    // print('rrrrr' + res.toString());
    List<Map<String, dynamic>> m = mapToList(res);
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<List<bool>> isFollowed(String userid) async {
    dynamic result = await Api.getwithToken(
        token: TempUser.token, url: '${baseURL}users/$userid');
    print('resulttt$result');
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
        url: '${baseURL}trends/$trendname?limit=5&offset=$offset', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;

    // print('rrrrr' + res.toString());
    List<Map<String, dynamic>> m = mapToList(res);
    print('ressss$m');

    print('mm$m');
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<List<Tweet>> getReplies(
      {required int offset, required String id,required int pageSize}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    //down->false
    Response res = await Api.getwithToken(
        url: '${baseURL}interactions/$id/replies?limit=$pageSize&offset=$offset',
        token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    // Response response = res;
    if (res.data['data'] == []) return [];
    print('rrrrr${res.data['data']}');
    List<Map<String, dynamic>> m = mapToList(res, isforreply: true);
    print('ressss$m');

    print('mm$m');
    List<Tweet> t = initializeTweets(m);
    // print('hh' + m.whereType().toString());
    return t;
  }

  static Future<dynamic> getMainTweetForReply(
      {required int offset, required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    Response res = await Api.getwithToken(
        url: '${baseURL}interactions/$id/replies?limit=5&offset=$offset',
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
              ['avatar'] ??
          'b631858bdaafa77258b9ed2f7c689bdb.png',
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
        '${baseURL}interactions/$id/retweet',
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
        url: '${baseURL}interactions/retweet/$tweetid', token: s);
    if (res is String) {
      return false;
    } else {
      return true;
    }
  }
}

bool intToBool(int a) => a == 0 ? false : true;
