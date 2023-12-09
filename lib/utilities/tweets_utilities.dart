import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

List<String>? _getImageList(dynamic image) {
  if (image == null) {
    return null;
  } else if (image is String) {
    return [image.toString().trim()];
  } else if (image is List<dynamic>) {
    List<String> tmp = image.map((item) => item.toString().trim()).toList();

    // If 'image' is already a List, convert each item to String
    return tmp
        .map((item) => 'https://tweaxybackend.mywire.org/uploads/tweetsMedia/$item')
        .toList();
  } else {
    return null;
  }
  return null;
}

List<Tweet> initializeTweets(List<Map<String, dynamic>> temp) {
  print('hhh' + temp.toString());
  return temp
      .map((e) => Tweet(
            id: e['id']!,
            image: _getImageList(e['image']),
            userImage: e['userImage']!,
            userHandle: e['userHandle']!,
            userName: e['userName']!,
            time: e['time']!,
            tweetText: e['tweetText'],
            userId: e['userid'],
            likesCount: e['likesCount'],
            viewsCount: e['viewsCount'],
            retweetsCount: e['retweetsCount'],
            commentsCount: e['commentsCount'],
            isUserLiked: e['isUserLiked'],
            isUserRetweeted: e['isUserRetweeted'],
            isUserCommented: e['isUserCommented'],
          ))
      .toList();
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
  DateTime dt1 = DateTime.parse(date).toLocal();
  DateTime now = DateTime.now().toLocal();
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
  else if (now.hour < dt1.hour)
    time = '${now.hour + 24 - dt1.hour}h';
  else if (now.hour == dt1.hour && now.day != dt1.day)
    time = '24h';
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
