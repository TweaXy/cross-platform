import 'dart:developer';
import 'dart:io';

import 'package:chatview/chatview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class ChatRoomService {
  final Dio dio;
  final String baseUrl = 'https://tweaxybackend.mywire.org/api/v1/';
  late String id;
  ChatRoomService(this.dio);
  Future<List<Message>> getMessages(String id, int pageOffset) async {
    Response response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
      id = s[0];
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.getwithToken(
          url: '${baseUrl}conversations/$id?limit=20&offset=$pageOffset',
          token: token);

      return messageformat(response);
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('varification code error ');
    }
  }

  Future<dynamic> sendMessage(String text, String media) async {
    File imageFile = File(media);
    List<int> imageBytes = await imageFile.readAsBytes();
  }

  List<Message> messageformat(Response response) {
    var items = response.data["data"]["items"];
    List<Message> messages = [];
    for (var i in items) {
      String sendByid = id == i["senderId"] ? id : "2";
      String mess = i["media"] == [] ? i["text"] : i["medai"];
      MessageType messtype =
          i["media"] == [] ? MessageType.text : MessageType.image;
      MessageStatus state =
          i["seen"] == true ? MessageStatus.read : MessageStatus.delivered;

      messages.add(Message(
          status: state,
          messageType: messtype,
          message: mess,
          createdAt: DateTime.parse(i["createdDate"]).toLocal(),
          sendBy: sendByid));
    }
    return messages;
  }

  Future firstConversation(String username) async {
    Response response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.post(
          body: {"UUID": username},
          url: '${baseURL}conversations',
          token: token);

      return response.data["data"]["conversationID"];
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('varification code error ');
    }
  }
}
