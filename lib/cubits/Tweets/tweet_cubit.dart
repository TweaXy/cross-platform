import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';

class TweetsUpdateCubit extends Cubit<TweetUpdateState> {
  TweetsUpdateCubit() : super(TweetInitialState());
  void deleteTweet({required String tweetid}) {
    print('deleted');
    emit(TweetDeleteState(tweetid: tweetid));
  }

  void addTweet() {
    emit(TweetAddedState());
  }

  void initializeTweet() {
    emit(TweetInitialState());
  }

  void unLikeTweet(String id) {
    emit(TweetUnLikedState(tweetid: id));
  }

  void refresh() {
    emit(TweetHomeRefresh());
  }
}