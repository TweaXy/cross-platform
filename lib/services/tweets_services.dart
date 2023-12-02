import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TweetsServices {
  static String baseUrl = 'http://16.171.65.142:3000/api/v1';
  static Future<List<Map<String, dynamic>>> getTweetsHome(
      {required ScrollController scroll}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    // print('kkk' + s.toString());
    //down->false
    // print('scroll=' + scroll.position.userScrollDirection.toString());
    // if (res)
    dynamic res = await Api.getwithToken(
        url: '$baseUrl/home?/limit=5&offset=0', token: s);
    if (res is String) {
      // throw Future.error(res);
      return [];
    }
    Response response = res;
    if (scroll.position.userScrollDirection == ScrollDirection.reverse &&
        response.data['pagination']['nextPage'] != null) //downward
    {
      response = await Api.getwithToken(
          url: response!.data['pagination']['nextPage'], token: s!);
    } else if (scroll.position.userScrollDirection == ScrollDirection.forward &&
        response.data['pagination']['prevPage'] != null) //up
    {
      response = await Api.getwithToken(
          url: response!.data['pagination']['prevPage'], token: s!);
    }

    print('res' + response.toString());
    List<Map<String, dynamic>> m =
        (response.data['data']['items'] as List<dynamic>)
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
                  'tweetText': item['mainInteraction']['text']
                })
            .toList();
    // print('hh' + m.whereType().toString());
    return m;
  }

  static Future<String> deleteTweet({required String tweetid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('token');
    dynamic res =
        await Api.delete(url: '$baseUrl/interactions/$tweetid', token: s);
    print('ressss' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }
}

String dateFormatter(String date) {
  print(date);
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  DateTime dt1 = DateTime.parse(date);
  DateTime now = DateTime.now();
  // print('dt1=' + dt1.toString());
  // print('now=' + now.toString());

  Duration diff = now.difference(dt1);
  // print('diff=' + diff.toString());
  // print('diff day=' + diff.inDays.toString());
  // print('diff hour=' + (now.hour + 24 - dt1.hour).toString());
  // print('diff minute=' + (now.minute - dt1.minute).toString());
  // print('diff second=' + (now.second - dt1.second).toString());
  String time;
  if (dt1.year != now.year) {
    time =
        '${months[dt1.month - 1]} ${dt1.day},${kIsWeb ? dt1.year.toString() : (dt1.year - 2000).toString()}';
  } else if (diff.inDays > 0)
    time = '${months[dt1.month - 1]} ${dt1.day}';
  else if (now.hour <= dt1.hour)
    time = '${now.hour + 24 - dt1.hour}h';
  else if (now.hour - dt1.hour > 0)
    time = '${now.hour - dt1.hour}h';
  else if (now.minute - dt1.minute > 0)
    time = '${now.minute - dt1.minute}m';
  else if (now.second - dt1.second > 0)
    time = '${now.second - dt1.second}s';
  else
    time = months[dt1.month - 1] + ' ' + dt1.day.toString();
  // print('time=' + time.toString());
  return time;
}
