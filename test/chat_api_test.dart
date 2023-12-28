import 'dart:developer';

import 'package:chatview/chatview.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/services/chat_room_service.dart';
import 'package:tweaxy/services/get_conversation_service.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:socket_io_client/socket_io_client.dart' as ioo;

void main() {
  TempUser.token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwieDU4ZzNtajMybTUxaGt3b2Q2MHZjbXNjZlwiIiwiaWF0IjoxNzAzNjgxNDgzLCJleHAiOjE3MDYyNzM0ODN9.bZ5UKTjh0IxpS9xZSnrokp-p-35E2ml9m5OACgjEJcE';

  TempUser.id = 'x58g3mj32m51hkwod60vcmscf';
  GetConversationsService getConvService = GetConversationsService(Dio());
  ChatRoomService chatRoomService = ChatRoomService(Dio());
  ConversationModel convo = ConversationModel(
    conversationID: '',
    userID: '',
    username: '',
    name: '',
    userAvatar: '',
    lastMessage: null,
    isBlockedByMe: false,
    isBlockingMe: false,
    isMutedByMe: false,
    isMutingMe: false,
    userFollowersNum: 0,
    userFollowingsNum: 0,
    unseenCount: 0,
  );
  String newConvoID = '';
  ioo.Socket socket =
      ioo.io('https://tweaxychat.gleeze.com/', <String, dynamic>{
    'transports': ['websocket'], // optional your need for
    'autoConnect': false,
  });
  socket.auth = {"token": TempUser.token};
  socket.connect();

  socket.onConnect((_) {
    log('connect');
  });
  socket.on('event', (data) => log(data.toString()));
  socket.on('fromServer', (_) => log(_.toString()));
  socket.onConnect((data) {
    log(data.toString());
  });
  socket.onConnecting((data) {
    log(data.toString());
  });
  socket.onConnectError((data) {
    log(data.toString());
  });
  socket.onConnectTimeout((data) {
    log(data.toString());
  });
  socket.onError((data) {
    log(data.toString());
  });

  group('chat_test', () {
    test('Test1 : get conversations', () async {
      var response = await getConvService.getConversations(TempUser.token,
          limit: 7, pageNumber: 0);
      convo = response[0];
      expect(response, isA<List<ConversationModel>>());
    });

    test("Test2: get old messages", () async {
      var response = await chatRoomService.getMessages(
          TempUser.token, convo.conversationID, 0);
      expect(response, isA<List<Message>>());
    });

    test('Test3: get messages', () async {
      socket.on('message', (data) {
        expect(data['text'], isA<String>());
      });
    });
    test("Test4: send message for existing conversations", () async {
      socket.emit(
        'sendMessage',
        {
          "id": TempUser.id,
          "conversationID": convo.conversationID,
          "text": "helllooo from test :)",
          "media": null
        },
      );
      socket.on('message', (data) {
        expect(data['text'], "helllooo from test :)");
      });
    });
    test("Test5: send empty message", () async {
      socket.emit(
        'sendMessage',
        {
          "id": TempUser.id,
          "conversationID": convo.conversationID,
          "text": "",
          "media": null
        },
      );
      socket.on('message', (data) {
        expect(data, null);
      });
    });
    test("Test6: Create new conversations", () async {
      var response = await chatRoomService.firstConversation(
          TempUser.token, "eman_ibrahim");
      newConvoID = response;
      expect(response, isA<String>);
    });
    test("Test7: send message for new conversations", () async {
      socket.emit(
        'sendMessage',
        {
          "id": TempUser.id,
          "conversationID": newConvoID,
          "text": "helllooo from test :)",
          "media": null
        },
      );
      socket.on('message', (data) {
        expect(data['text'], "helllooo from test :)");
      });
    });
  });
}
