import 'package:tweaxy/models/last_message_model.dart';

class ConversationModel {
  String conversationID;
  String userID;
  String? userAvatar;
  String username;
  String name;
  bool isBlockedByMe;
  bool isBlockingMe;
  bool isMutedByMe;
  bool isMutingMe;
  int? userFollowersNum;
  int? userFollowingsNum;
  LastMessage? lastMessage;
  ConversationModel({
    required this.conversationID,
    required this.userID,
    required this.userAvatar,
    required this.username,
    required this.name,
    required this.lastMessage,
    required this.isBlockedByMe,
    required this.isBlockingMe,
    required this.isMutedByMe,
    required this.isMutingMe,
    this.userFollowersNum,
    this.userFollowingsNum,
  });
}
