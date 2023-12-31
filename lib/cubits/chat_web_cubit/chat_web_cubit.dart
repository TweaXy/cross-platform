import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';
import 'package:tweaxy/models/conversation_model.dart';

class ChatWebCubit extends Cubit<ChatWebCubitState> {
  ChatWebCubit() : super(InitialChatWebCubitState());

  void openConversation({required ConversationModel conversation}) {
    emit(ChatWebCubitConversationState(conversation));
  }

  void loadingConversation() {
    emit(LoadingChatWebCubitState());
  }

  void closeConversation() {
    emit(ChatWebCubitNoConversationState());
  }
}
