import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';

class TweetsUpdateCubit extends Cubit<TweetUpdateState> {
  TweetsUpdateCubit() : super(TweetInitialState());
  void deleteTweet({required String tweetid}) {
    print('deleted');
    emit(TweetDeleteState(tweetid: tweetid));
  }

  void addTweet() {
    emit(TweetAddedState());
  }

  void addReply() {
    emit(TweetReplyAddedState());
  }

  void initializeTweet() {
    emit(TweetInitialState());
  }

  void unLikeTweet(String parentid) {
    emit(TweetUnLikedState(parentid: parentid));
  }

  void likeTweet(String parentid) {
    emit(TweetLikedState(parentid: parentid));
  }

  void refresh() {
    emit(TweetHomeRefresh());
  }

  void deletewithpopforreply() {
    emit(TweetDeleteInReplyState());
  }

  void retweet(String parentid) {
    emit(TweetRetweetState(parentid: parentid));
  }

  void deleteretweet(
      {required String userid,
      required String id,
      required bool isretweet,
      required String parentid}) {
    emit(TweetDeleteRetweetState(userid, id, isretweet, parentid));
  }

  void blockUser(String id) {
    emit(TweetUserBlocked(tweetid: id));
  }

  void muteUser(String id) {
    emit(TweetUserMuted(tweetid: id));
  }

  void unfollowUser(String id) {
    emit(TweetUserUnfollowed(tweetid: id));
  }
}
