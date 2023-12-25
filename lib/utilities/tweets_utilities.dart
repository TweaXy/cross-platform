import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/add_tweet/add_tweet_view.dart';

List<String>? getImageList(dynamic image) {
  if (image == null) {
    return null;
  } else if (image is String) {
    return [image.toString().trim()];
  } else if (image is List<dynamic>) {
    List<String> tmp = image.map((item) => item.toString().trim()).toList();

    // If 'image' is already a List, convert each item to String
    return tmp
        .map((item) => 'https://tweaxybackend.mywire.org/api/v1/images/$item')
        .toList();
  } else {
    return null;
  }
  return null;
}

List<Tweet> initializeTweets(List<Map<String, dynamic>> temp) {
  // print('hhh' + temp.toString());
  List<Tweet> t = temp
      .map((e) => Tweet(
          id: e['id']!,
          image: getImageList(e['image']),
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
          createdDate: e['createdDate'],
          isretweet: e['isretweet'],
          reposteruserid: e['reposteruserid'],
          reposteruserName: e['reposteruserName'],
          parentid: e['parentid'],
          isUserBlockedByMe: e['isUserBlockedByMe'],
          isUserMutedByMe: e['isUserMutedByMe'],
          isShown: !(e['isUserBlockedByMe'] || e['isUserMutedByMe'])))
      .toList();
  return t;
}

String dateFormatter(String date) {
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

List<String> calculateTime(String fulldate) {
  DateTime dt1 = DateTime.parse(fulldate).toLocal();
  print(fulldate.toString());
  print('ddd' + dt1.hour.toString());
  String time;
  String date;
  String min = '';

  if (dt1.minute < 10)
    min += ':' + '0' + '${dt1.minute}';
  else
    min += ':' + '${dt1.minute}';
  if (dt1.hour == 0)
    time = '12' + min + ' ' + 'AM';
  else if (dt1.hour <= 12)
    time = '${dt1.hour}' + min + ' ' + 'AM';
  else
    time = '${dt1.hour - 12}' + min + ' ' + 'PM';
  if (dt1.day < 10)
    date = '0' +
        '${dt1.day}' +
        ' ' +
        '${months[dt1.month - 1]}' +
        ' ' +
        '${dt1.year - 2000}';
  else
    date = '${dt1.day}' +
        ' ' +
        '${months[dt1.month - 1]}' +
        ' ' +
        '${dt1.year - 2000}';
  return [time, date];
}

List<Map<String, dynamic>> mapToList(Response res,
    {bool isforreply = false, bool isformaintweetreply = false}) {
  List<dynamic> t = [];
  if (isformaintweetreply)
    t = res.data['data']['parent'] as List<dynamic>;
  else
    t = isforreply
        ? res.data['data']['interactions']
        : res.data['data']['items'];
  return (t as List<dynamic>).map((item) {
    String x = 'mainInteraction';
    String reposteruserid = '';
    String reposteruserName = '';
    if (item['mainInteraction']['type'] == "RETWEET") {
      x = 'parentInteraction';
      reposteruserid = item['mainInteraction']['user']['id'];
      reposteruserName = item['mainInteraction']['user']['name'];
    }
    return {
      'likesCount': item[x]['likesCount'],
      'viewsCount': item[x]['viewsCount'],
      'retweetsCount': item[x]['retweetsCount'],
      'commentsCount': item[x]['commentsCount'],
      'id': item['mainInteraction']['id'],
      'userid': item[x]['user']['id'],
      'userImage': item[x]['user']['avatar'] != null
          ? item[x]['user']['avatar']
          : 'b631858bdaafa77258b9ed2f7c689bdb.png',
      'image': item[x]['media'] != null ? item[x]['media'].toList() : null,
      'userName': item[x]['user']['name'],
      'userHandle': item[x]['user']['username'],
      'time': dateFormatter(item[x]['createdDate']),
      'tweetText': item[x]['text'],
      'isUserLiked': intToBool(item[x]['isUserInteract']['isUserLiked']),
      'isUserRetweeted':
          intToBool(item[x]['isUserInteract']['isUserRetweeted']),
      'isUserCommented':
          intToBool(item[x]['isUserInteract']['isUserCommented']),
      'createdDate': calculateTime(item[x]['createdDate']),
      'isretweet': item['mainInteraction']['type'] != "RETWEET" ? false : true,
      'reposteruserid': reposteruserid,
      'reposteruserName': reposteruserName,
      'parentid': item[x]['id'],
      'isUserBlockedByMe':
          item['mainInteraction']['user']['blockedByMe'] ?? false,
      'isUserMutedByMe': item['mainInteraction']['user']['mutedByMe'] ?? false,
    };
  }).toList();
}

bool intToBool(int a) => a == 0 ? false : true;

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
void addReplyPress(context,
    {required String tweetId, required String tweetAuthor}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTweetView(
                isReply: true,
                tweetId: tweetId,
                replyto: tweetAuthor,
                photoIconPressed: false,
              )));
}

void updateStatesforTweet(state, context, PagingController pagingController,
    {bool isforHome = false}) {
  if (state is TweetHomeRefresh ||
      state is TweetAddedState ||
      state is TweetReplyAddedState ||
      state is UpdateUsernameDoneState) {
    pagingController.refresh();
    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
  if (state is TweetDeleteState) {
    pagingController.itemList!.removeWhere((element) =>
        element.id == state.tweetid ||
        element.id == state.parentid ||
        element.parentid == state.tweetid);
    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
  if ((state is TweetUserBlocked ||
          state is TweetUserMuted ||
          state is TweetUserUnfollowed) &&
      isforHome) {
    pagingController.itemList!.removeWhere((element) {
      print(element.userId.toString() + ' ' + state.userid.toString());
      return element.userId == state.userid;
    });
    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
  if (state is ViewTweetforMuteorBlock) {
    pagingController.itemList!.map((element) {
      if (element.id == state.id) {
        element.isShown = true;
        return element;
      }
    }).toList();

    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
  if (state is TweetLikedState) {
    pagingController.itemList!.map((element) {
      if (element.id == state.id ||
          element.id == state.parentid ||
          element.parentid == state.id) {
        element.isUserLiked = !element.isUserLiked;
        element.likesCount++;
        return element;
      }
    }).toList();

    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
  if (state is TweetUnLikedState) {
    pagingController.itemList!.map((element) {
      if (element.id == state.id ||
          element.id == state.parentid ||
          element.parentid == state.id) {
        element.isUserLiked = !element.isUserLiked;
        element.likesCount--;
      }
      return element;
    }).toList();
    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }

  if (state is TweetRetweetState) {
    pagingController.itemList!.map((element) {
      print('hereee');

      if (element.id == state.id ||
          element.id == state.parentid ||
          element.parentid == state.id) {
        element.isUserRetweeted = !element.isUserRetweeted;
        element.retweetsCount++;
      }
      return element;
    }).toList();

    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
  if (state is TweetDeleteRetweetState) {
    pagingController.itemList!.map((element) {
      if (element.id == state.id ||
          element.id == state.parentid ||
          element.parentid == state.id) {
        element.isUserRetweeted = !element.isUserRetweeted;
        element.retweetsCount--;
      }

      return element;
    }).toList();
    if (state.reposteruserid == TempUser.id) {
      pagingController.itemList!.removeWhere((element) =>
          (element.parentid == state.id ||
              element.parentid == state.parentid) &&
          element.isretweet);
    }

    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
  }
}
