import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/tweet.dart';

class GetLikersInProfile {
  final Dio dio;
  final String baseUrl = 'http://16.171.65.142:3000/api/v1/';

  GetLikersInProfile(this.dio);

Future<List<Tweet>> likersList({int pageNumber = 0}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Response response = await Api.getwithToken(
        url: '${baseUrl}home?/limit=5&offset=$pageNumber', token: token);
    List<Map<String, dynamic>> tweets =
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
                      ? item['mainInteraction']['media'][0]
                      : null,
                  'userName': item['mainInteraction']['user']['name'],
                  'userHandle': item['mainInteraction']['user']['username'],
                  'time': dateFormatter(item['mainInteraction']['createdDate']),
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
            ))
        .toList();
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
  } else if (diff.inDays > 0) {
    time = '${months[dt1.month - 1]} ${dt1.day}';
  } else if (now.hour <= dt1.hour) {
    time = '${now.hour + 24 - dt1.hour}h';
  } else if (now.hour - dt1.hour > 0) {
    time = '${now.hour - dt1.hour}h';
  } else if (now.minute - dt1.minute > 0) {
    time = '${now.minute - dt1.minute}m';
  } else if (now.second - dt1.second > 0) {
    time = '${now.second - dt1.second}s';
  } else {
    time = months[dt1.month - 1] + ' ' + dt1.day.toString();
  } // print('time=' + time.toString());
  return time;
}
