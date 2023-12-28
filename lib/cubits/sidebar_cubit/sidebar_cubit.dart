import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(SidebarInitialState());
  void toggleMenu(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        emit(SidebarHomeState());
        break;
      case 1:
        emit(SidebarExploreState());
        break;
      case 2:
        emit(SidebarNotificationState());
        break;
      case 3:
        emit(SidebarMessageState());
        break;
      case 4:
        emit(SearchUserLoadingState());
        emit(SidebarProfileState());
        break;

      default:
        emit(SidebarSettingsState());
    }
  }

  void openProfile(String id, String text) {
    emit(OtherProfileState(id, text));
  }

  void openExplore() {
    emit(SidebarExploreState());
  }

  void openFollowers({required String username, required String name}) {
    emit(FollowingFollowerListState(username, name));
  }

  void showReplies(String tweetid, String userHandle, Set<String> replyto) {
    emit(OpenRepliesState(tweetid, userHandle, replyto));
  }
}
