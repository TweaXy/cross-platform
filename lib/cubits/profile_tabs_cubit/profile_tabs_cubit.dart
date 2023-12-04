import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/profile_tabs_cubit/profile_tabs_status.dart';

class ProfileTabsCubit extends Cubit<ProfileTabs> {
  ProfileTabsCubit() : super(ProfileTabInitialState());
  void toggleMenu(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        emit(ProfileTabPostsState());
        break;
      case 1:
        emit(ProfileTabRepliesState());
        break;
      case 2:
        emit(ProfileTabLikesState());
        break;
      default:
        emit(ProfileTabPostsState());
    }
  }
}
