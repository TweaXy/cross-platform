import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/models/last_message_model.dart';

class GetConversationsService {
  final Dio dio;
  static String token = '';
  GetConversationsService(this.dio);
  Future<List<ConversationModel>> getConversations(String? tokenSent,
      {required int pageNumber, required int limit}) async {
    Response response;
    if (tokenSent != null) {
      token = tokenSent;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    }
    try {
      response = await Api.getwithToken(
          url: '${baseURL}conversations?limit=$limit&offset=$pageNumber',
          token: token);
      List<Map<String, dynamic>> conversations =
          (response.data['data']['items'] as List<dynamic>)
              .map((item) => {
                    'id': item['id'],
                    'userID': item['user']['id'],
                    'userUsername': item['user']['username'],
                    'userName': item['user']['name'],
                    'userAvatar': item['user']['avatar'],
                    'isBlockedByMe': item['user']['isBlockedByMe'],
                    'isBlockingMe': item['user']['isBlockingMe'],
                    'isMutedByMe': item['user']['isMutedByMe'],
                    'isMutingMe': item['user']['isMutingMe'],
                    'lastMessage': item['lastMessage'],
                    'unseenCount': item['unseenCount'],
                    'userFollowersNum': item['user']['_count']["followedBy"],
                    'userFollowingsNum': item['user']['_count']["following"],
                  })
              .toList();
      return conversations
          .map((e) => ConversationModel(
              conversationID: e['id']!,
              userID: e['userID']!,
              username: e['userUsername']!,
              name: e['userName']!,
              userAvatar: e['userAvatar'],
              lastMessage: e['lastMessage'] == null
                  ? null
                  : LastMessage(
                      text: e['lastMessage']!['text'],
                      media: e['lastMessage']!['media'],
                      createdDate: e['lastMessage']!['createdDate'],
                    ),
              isBlockedByMe: e['isBlockedByMe'],
              isBlockingMe: e['isBlockingMe'],
              isMutedByMe: e['isMutedByMe'],
              isMutingMe: e['isMutingMe'],
              userFollowersNum: e['userFollowersNum'],
              userFollowingsNum: e['userFollowingsNum'],
              unseenCount: e['unseenCount']))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception('varification code error ');
    }
  }
}

class GetUnseenConversationCount {
  GetUnseenConversationCount._();
  static const String _endpoint = 'conversations/unseen';
  static final instance = GetUnseenConversationCount._();
  static Stream<int> getUnseenConversationCount() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response =
        await Api.getwithToken(url: '$baseURL$_endpoint', token: token);
    int data = response.data['data']['unseenConversations'];
    log('MsgsUnseenCount = $data');
    yield data;
  }
}
