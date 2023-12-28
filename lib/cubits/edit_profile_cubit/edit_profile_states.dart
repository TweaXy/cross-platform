class EditProfileState {}

class ProfilePageInitialState extends EditProfileState {
  String? profileID;
  ProfilePageInitialState({this.profileID});
}

class ProfilePageCompletedState extends EditProfileState {
  String? profileID;
  ProfilePageCompletedState({this.profileID});
}

class ProfilePageLoadingState extends EditProfileState {}

class EditProfileFailedState extends EditProfileState {}
