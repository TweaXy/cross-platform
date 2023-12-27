class SidebarState {}

class SidebarInitialState extends SidebarState {}

class SidebarHomeState extends SidebarState {}

class SidebarExploreState extends SidebarState {}

class SidebarNotificationState extends SidebarState {}

class SidebarMessageState extends SidebarState {}

class SidebarProfileState extends SidebarState {}

class SearchUserLoadingState extends SidebarState {}

class SidebarSettingsState extends SidebarState {}

class OtherProfileState extends SidebarState {
  final String id;
  final String text;
  OtherProfileState(this.id, this.text);
}

class FollowingFollowerListState extends SidebarState {
  final String username;
  final String name;

  FollowingFollowerListState(this.username, this.name);
}

class OpenRepliesState extends SidebarState {
final String tweetid;
final String userHandle;
final List<String>replyto;
  OpenRepliesState(this.tweetid, this.userHandle, this.replyto);
}
