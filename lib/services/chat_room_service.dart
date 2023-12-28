import 'dart:developer';

import 'package:chatview/chatview.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class ChatRoomService {
  final Dio dio;
  late String userID;
  ChatRoomService(this.dio);
  Future<List<Message>> getMessages(
      String? tokenSent, String id, int pageOffset) async {
    Response response;
    String? token;
    if (tokenSent != null) {
      token = tokenSent;
    } else {
      try {
        List<String> s = await loadPrefs();
        token = s[1];
        userID = s[0];
      } catch (e) {
        log(e.toString());
      }
    }
    try {
      response = await Api.getwithToken(
          url: '${baseURL}conversations/$id?limit=10&offset=$pageOffset',
          token: token);
      return messageformat(response);
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('get old messages error ');
    }
  }

  // Future<dynamic> sendMessage(String text, String media) async {
  //   File imageFile = File(media);
  //   List<int> imageBytes = await imageFile.readAsBytes();
  // }

  List<Message> messageformat(Response response) {
    var items = response.data["data"]["items"];
    List<Message> messages = [];
    for (var i in items) {
      String sendByid = i["senderId"];
      String mess = i["text"];
      MessageType messtype = MessageType.text;
      MessageStatus state =
          i["seen"] == true ? MessageStatus.read : MessageStatus.delivered;

      messages.add(Message(
          id: "1",
          status: state,
          messageType: messtype,
          message: mess,
          createdAt: DateTime.parse(i["createdDate"]).toLocal(),
          sendBy: sendByid));
    }
    return messages;
  }

  // List<ChatMessage> chatmessageformat(Response response) {
  //   var items = response.data["data"]["items"];
  //   List<ChatMessage> messages = [];
  //   for (var i in items) {
  //     String sendByid = i["senderId"];
  //     String mess = i["text"];

  //     messages.add(ChatMessage(
  //       text: mess,
  //       user: ChatUser(
  //         id: sendByid,
  //       ),
  //       createdAt: DateTime.parse(i["createdDate"]).toLocal(),
  //     ));
  //   }
  //   return messages;
  // }

  Future<String> firstConversation(String? tokenSent, String username) async {
    String returndata = "";
    Response response;
    String? token;
    if (tokenSent != null) {
      token = tokenSent;
    } else {
      try {
        List<String> s = await loadPrefs();
        token = s[1];
      } catch (e) {
        log(e.toString());
      }
    }
    try {
      response = await Api.post(
          body: {"UUID": username},
          url: '${baseURL}conversations',
          token: token);
      if (response.statusCode == 201) {
        returndata = response.data["data"]["conversationID"];
      } else if (response.statusCode == 200) {
        returndata = response.data["data"]["conversation"]["id"];
      }
      return returndata;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('create conservation error ');
    }
  }
}
