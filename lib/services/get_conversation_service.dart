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
                    'lastMessage': item['lastMessage'],
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
              ))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception('varification code error ');
    }
  }
}
