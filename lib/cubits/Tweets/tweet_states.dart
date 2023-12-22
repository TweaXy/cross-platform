import 'package:tweaxy/models/tweet.dart';

class TweetUpdateState {}

class TweetInitialState extends TweetUpdateState {}

class TweetAddedState extends TweetUpdateState {}

class TweetReplyAddedState extends TweetUpdateState {}

class TweetUnLikedState extends TweetUpdateState {
  final String parentid;
  final String id;

  TweetUnLikedState({required this.id, required this.parentid});
}

class TweetHomeRefresh extends TweetUpdateState {}

class TweetLikedState extends TweetUpdateState {
  final String parentid;
  final String id;


  TweetLikedState({required this.id, required this.parentid});
}

class TweetDeleteState extends TweetUpdateState {
  final String tweetid;

  TweetDeleteState({required this.tweetid});
}

class TweetUserBlocked extends TweetUpdateState {
  final String tweetid;
  final String tweetparentid;


  TweetUserBlocked({required this.tweetparentid,required this.tweetid});
}
class TweetUserMuted extends TweetUpdateState {
  final String tweetid;
  final String tweetparentid;

  TweetUserMuted({required this.tweetparentid, required this.tweetid});
}
class TweetUserUnfollowed extends TweetUpdateState {
  final String tweetid;
  final String tweetparentid;


  TweetUserUnfollowed({required this.tweetparentid,required this.tweetid});
}

class TweetDeleteInReplyState extends TweetUpdateState {}

class TweetRetweetState extends TweetUpdateState {
  final String parentid;
  final String id;

  TweetRetweetState({required this.id, required this.parentid});
}

class TweetDeleteRetweetState extends TweetUpdateState {
  final String reposteruserid;
  final String id;
  final bool isretweet;

  final String parentid;

  TweetDeleteRetweetState(this.reposteruserid, this.id, this.isretweet, this.parentid);
}
class ViewTweetforMuteorBlock extends TweetUpdateState {
  final String id;
  ViewTweetforMuteorBlock(this.id,);



}

