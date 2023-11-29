import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Tweets {
  static String baseUrl = 'http://16.171.65.142:3000/api/v1';
  static Future<List<Map<String, dynamic>>> getTweetsHome(
      {required ScrollController scroll}) async {
    //down->false
    print('scroll=' + scroll.position.userScrollDirection.toString());
// if (res)
    Response response = await Api.getwithToken(
        url: '$baseUrl/home?/limit=5&offset=0',
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiYWZwdnlwZnN1OTljbTQyNjdtMWttY3NpZVwiIiwiaWF0IjoxNzAxMjEzODgzLCJleHAiOjE3MDM4MDU4ODN9.08It4wlrSO-_8syBPABMagYcOfIbJuyB0Yzoqq-B5lI");
    if (scroll.position.userScrollDirection == ScrollDirection.reverse &&
        response!.data['pagination']['nextPage'] != null) {
      //downward
      response = await Api.getwithToken(
          url: response!.data['pagination']['nextPage'],
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiYWZwdnlwZnN1OTljbTQyNjdtMWttY3NpZVwiIiwiaWF0IjoxNzAxMjEzODgzLCJleHAiOjE3MDM4MDU4ODN9.08It4wlrSO-_8syBPABMagYcOfIbJuyB0Yzoqq-B5lI");
    } else if (scroll.position.userScrollDirection == ScrollDirection.forward &&
        response!.data['pagination']['prevPage'] != null) //up
    {
      response = await Api.getwithToken(
          url: response!.data['pagination']['prevPage'],
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiYWZwdnlwZnN1OTljbTQyNjdtMWttY3NpZVwiIiwiaWF0IjoxNzAxMjEzODgzLCJleHAiOjE3MDM4MDU4ODN9.08It4wlrSO-_8syBPABMagYcOfIbJuyB0Yzoqq-B5lI");
    }

    // print('res' + response.toString());
    List<Map<String, dynamic>> m =
        (response!.data['data']['items'] as List<dynamic>)
            .map((item) => {
                  'likesCount': item['mainInteraction']['likesCount'],
                  'viewsCount': item['mainInteraction']['viewsCount'],
                  'retweetsCount': item['mainInteraction']['retweetsCount'],
                  'commentsCount': item['mainInteraction']['commentsCount'],
                  'id': item['mainInteraction']['id'],
                  'userid': item['mainInteraction']['user']['id'],
                  'userImage': item['mainInteraction']['user']['avatar'],
                  // 'image': item['mainInteraction']['media'] != null
                  //     ? item['mainInteraction']['media'][0]
                  //     : null,
                  'image': null,
                  'userName': item['mainInteraction']['user']['name'],
                  'userHandle': item['mainInteraction']['user']['username'],
                  'time': dateFormatter(item['mainInteraction']['createdDate']),
                  'tweetText': item['mainInteraction']['text']
                })
            .toList();
    // print('hh' + m.whereType().toString());
    return m;
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
    time = months[dt1.month - 1] +
        ' ' +
        dt1.day.toString() +
        ',' +
        (kIsWeb ? dt1.year.toString() : (dt1.year - 2000).toString());
  } else if (diff.inDays > 0)
    time = months[dt1.month - 1] + ' ' + dt1.day.toString();
  else if (now.hour <= dt1.hour)
    time = (now.hour + 24 - dt1.hour).toString() + 'h';
  else if (now.hour - dt1.hour > 0)
    time = (now.hour - dt1.hour).toString() + 'h';
  else if (now.minute - dt1.minute > 0)
    time = (now.minute - dt1.minute).toString() + 'm';
  else if (now.second - dt1.second > 0)
    time = (now.second - dt1.second).toString() + 's';
  else
    time = months[dt1.month - 1] + ' ' + dt1.day.toString();
  print('time=' + time.toString());
  return time;
}
