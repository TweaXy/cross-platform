import 'package:tweaxy/models/conversation_model.dart';

class ChatWebCubitState {}

class InitialChatWebCubitState extends ChatWebCubitState {}

class LoadingChatWebCubitState extends ChatWebCubitState {}

class ChatWebCubitNoConversationState extends ChatWebCubitState {}

class ChatWebCubitConversationState extends ChatWebCubitState {
  ChatWebCubitConversationState(this.conversation);
  final ConversationModel conversation;
}
