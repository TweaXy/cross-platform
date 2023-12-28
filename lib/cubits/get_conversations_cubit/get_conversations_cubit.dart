import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/get_conversations_cubit/get_conversations_states.dart';

class GetConversationsCubit extends Cubit<GetConversationsCubitStates> {
  GetConversationsCubit() : super(GetConversationsCubitInitial());

  void getConversations() {
    emit(GetConversationsCubitSuccess());
  }

  void loadingConversations() {
    emit(GetConversationsCubitLoading());
  }
}
