import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/services/temp_user.dart';

class UpdateUsernameCubit extends Cubit<UpdateUsernameStates> {
  UpdateUsernameCubit() : super(UpdateUsernameInitialState());

  void updateUsername(String username) {
    TempUser.setUserName(username: username);
    emit(UpdateUsernameDoneState());
  }
}
