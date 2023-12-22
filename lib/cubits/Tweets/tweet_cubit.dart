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

  void unLikeTweet(String parentid,String id) {
    emit(TweetUnLikedState(parentid: parentid, id: id));
  }

  void likeTweet(String parentid,String id) {
    emit(TweetLikedState(parentid: parentid, id: id));
  }

  void refresh() {
    emit(TweetHomeRefresh());
  }

  void deletewithpopforreply() {
    emit(TweetDeleteInReplyState());
  }

  void retweet(String parentid,String id) {
    emit(TweetRetweetState(parentid: parentid, id: id));
  }

  void deleteretweet(
      {required String userid,
      required String id,
      required bool isretweet,
      required String parentid}) {
    emit(TweetDeleteRetweetState(userid, id, isretweet, parentid));
  }

  void blockUser(String id,String parentid){
    emit(TweetUserBlocked(tweetid: id, tweetparentid: parentid));
  }

  void muteUser(String id,String parentid) {
    emit(TweetUserMuted(tweetid: id, tweetparentid: parentid));
  }

  void unfollowUser(String id,String parentid) {
    emit(TweetUserUnfollowed(tweetid: id, tweetparentid: parentid));
  }
}
