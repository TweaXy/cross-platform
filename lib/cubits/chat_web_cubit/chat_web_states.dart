import 'package:tweaxy/models/conversation_model.dart';

class ChatWebCubitState{ }
class InitialChatWebCubitState extends ChatWebCubitState{ }
class ChatWebCubitNoConversationState extends ChatWebCubitState{ }
class ChatWebCubitConversationState extends ChatWebCubitState{

  ChatWebCubitConversationState();
static ConversationModel conversation = ConversationModel(
    conversationID: "1",
    userID: "1",
    userAvatar: "d1deecebfe9e00c91dec2de8bc0d68bb",
    username: "username",
    name: "name",
    lastMessage: null,
  );
 }
