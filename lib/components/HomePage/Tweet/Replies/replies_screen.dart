import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/main_tweet_for_replies.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/replies_list.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';

class RepliesScreen extends StatelessWidget {
  const RepliesScreen({super.key, required this.tweet, required this.replyto});
  final Tweet tweet;
  final List<String> replyto;
  @override
  Widget build(BuildContext context) {
    List<String> replytochild = new List.from(replyto);
    replytochild.add(tweet.userHandle);
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
      builder: (context, state) {
       
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            leading: BackButton(color: Colors.black),
            title: Text(
              'Post',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                  child: MainTweetReplies(
                tweet: tweet,
                replyto: replyto,
              )),
              RepliesList(
                replyto: replytochild as List<String>,
              )
            ]),
          ),
        );
      },
    );
  }
}
