import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/edit_profile.dart';
import 'package:tweaxy/services/get_user_by_id.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(ProfilePageInitialState());
  Future<void> editProfile({
    required User user,
    required Uint8List? avatarByte,
    required Uint8List? bannerByte,
    required bool removedAvatar,
    required bool removedBanner,
    required String token,
  }) async {
    emit(ProfilePageLoadingState());
    await EditProfile.instance.editProfile(
        user: user,
        newAvatar: avatarByte,
        newBanner: bannerByte,
        removedAvatar: removedAvatar,
        removedBanner: removedBanner,
        token: token);
    await GetUserById.instance.excute(user.id!);
    
    emit(ProfilePageCompletedState());
  }
}
