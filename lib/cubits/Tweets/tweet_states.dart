class TweetUpdateState {}

class TweetInitialState extends TweetUpdateState {}

class TweetAddedState extends TweetUpdateState {}

class TweetUnLikedState extends TweetUpdateState {}

class TweetDeleteState extends TweetUpdateState {
  final String tweetid;

  TweetDeleteState({required this.tweetid});
}
