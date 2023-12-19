class ConversationModel {
  String conversationID;
  String userID;
  String? photo;
  String username;
  String name;
  String? lastmessageText;
  String? lastmessageMedia;
  String? lastmessageTime;
  ConversationModel({
    required this.conversationID,
    required this.userID,
    required this.photo,
    required this.username,
    required this.name,
    required this.lastmessageText,
    required this.lastmessageMedia,
    required this.lastmessageTime,
  });
}
