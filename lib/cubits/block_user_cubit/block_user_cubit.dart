import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/block_user_cubit/block_user_states.dart';
import 'package:tweaxy/services/blocking_user_service.dart';

class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(BlockUserInitialState());
  Future<void> blockUser(String username) async {
    emit(BlockUserLoadingState());
    bool flag = await BlockingUserService.blockUser(username: username);
    if (flag) {
      emit(BlockUserSucessState());
    } else {
      emit(UnBlockUserSucessState());
    }
  }

  Future<void> unblockUser(String username) async {
    emit(BlockUserLoadingState());
    bool flag = await BlockingUserService.unBlockUser(username: username);
    if (!flag) {
      emit(BlockUserSucessState());
    } else {
      emit(UnBlockUserSucessState());
    }
  }
}
