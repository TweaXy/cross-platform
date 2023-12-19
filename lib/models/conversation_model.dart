import 'package:tweaxy/models/last_message_model.dart';

class ConversationModel {
  String conversationID;
  String userID;
  String? userAvatar;
  String username;
  String name;
  LastMessage? lastMessage;
  ConversationModel({
    required this.conversationID,
    required this.userID,
    required this.userAvatar,
    required this.username,
    required this.name,
    required this.lastMessage,
  });
}
