class EditProfileState {}

class EditProfileInitialState extends EditProfileState {
  String? profileID;
  EditProfileInitialState({this.profileID});
}

class EditProfileCompletedState extends EditProfileState {
  String? profileID;
  EditProfileCompletedState({this.profileID});
}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileFailedState extends EditProfileState {}
