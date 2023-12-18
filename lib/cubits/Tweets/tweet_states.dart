import 'package:tweaxy/models/tweet.dart';

class TweetUpdateState {}

class TweetInitialState extends TweetUpdateState {}

class TweetAddedState extends TweetUpdateState {}

class TweetReplyAddedState extends TweetUpdateState {}

class TweetUnLikedState extends TweetUpdateState {
  final String tweetid;

  TweetUnLikedState({required this.tweetid});
}

class TweetHomeRefresh extends TweetUpdateState {}

class TweetLikedState extends TweetUpdateState {
  final String tweetid;

  TweetLikedState({required this.tweetid});
}

class TweetDeleteState extends TweetUpdateState {
  final String tweetid;

  TweetDeleteState({required this.tweetid});
}

class TweetDeleteInReplyState extends TweetUpdateState {}

class TweetRetweetState extends TweetUpdateState {
  final String tweetid;

  TweetRetweetState({required this.tweetid});
}

class TweetDeleteRetweetState extends TweetUpdateState {
  final String tweetid;

  TweetDeleteRetweetState({required this.tweetid});
}
