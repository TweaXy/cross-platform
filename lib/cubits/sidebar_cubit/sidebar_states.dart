class SidebarState {}

class SidebarInitialState extends SidebarState {}

class SidebarHomeState extends SidebarState {}

class SidebarExploreState extends SidebarState {}

class SidebarNotificationState extends SidebarState {}

class SidebarMessageState extends SidebarState {}

class SidebarProfileState extends SidebarState {}

class SidebarSettingsState extends SidebarState {}

class OtherProfileState extends SidebarState {
  final String id;
  final String text;
  OtherProfileState(this.id, this.text);
}

// class TweetInitialState extends SidebarState {}

// class TweetAddedState extends SidebarState {}

// class TweetDeleteState extends SidebarState {
//   final  String tweetid;

//   TweetDeleteState({required this.tweetid});
// }

class FollowingListState extends SidebarState {}

class FollowerListState extends SidebarState {}
