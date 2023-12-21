import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';

class ChatWebCubit extends Cubit<ChatWebCubitState> {
  ChatWebCubit() : super(InitialChatWebCubitState());

  void openConversation() {
    emit(ChatWebCubitConversationState());
  }

  void closeConversation() {
    emit(ChatWebCubitNoConversationState());
  }
}
