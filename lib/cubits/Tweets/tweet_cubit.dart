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

  void unLikeTweet(String id) {
    emit(TweetUnLikedState(tweetid: id));
  }
 void likeTweet(String id) {
    emit(TweetLikedState(tweetid: id));
  }
  void refresh() {
    emit(TweetHomeRefresh());
  }
  void deletewithpopforreply() {
    emit(TweetDeleteInReplyState());
  }
  void retweet(String id) {
    emit(TweetRetweetState(tweetid: id));
  }
  void deleteretweet(String id) {
    emit(TweetDeleteRetweetState(tweetid: id));
  }
}
