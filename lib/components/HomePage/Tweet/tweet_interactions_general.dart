import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/modal_bottom_repost.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/services/like_tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/shared/keys/tweet_keys.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class TweetInteractions extends StatefulWidget {
  TweetInteractions(
      {interactionskey,
      required this.id,
      required this.likesCount,
      required this.viewsCount,
      required this.retweetsCount,
      required this.commentsCount,
      required this.isUserLiked,
      required this.isUserCommented,
      required this.isUserRetweeted,
      required this.replyto});
  final int likesCount;
  final int viewsCount;
  final int retweetsCount;
  final int commentsCount;
  final bool isUserLiked;
  final bool isUserCommented;
  bool isUserRetweeted;
  final String replyto;

  final String id;

  @override
  State<TweetInteractions> createState() => _TweetInteractionsState();
}

class _TweetInteractionsState extends State<TweetInteractions> {
  bool postRetweet = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postRetweet = widget.isUserRetweeted;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                key: const ValueKey(TweetKeys.replyInteraction),
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: const Icon(FontAwesomeIcons.comment),
                onPressed: () {
                  addReplyPress(context,
                      tweetId: widget.id, tweetAuthor: widget.replyto);
                },
              ), // Replace with your desired icon
              SizedBox(
                  width: screenWidth *
                      0.01), // Adjust the width as per your preference
              Text(widget.commentsCount
                  .toString()), // Replace with your desired label
            ],
          ),
          LikeButton(
              key: const ValueKey(TweetKeys.repostInteraction),
              isLiked: widget.isUserRetweeted,
              bubblesSize: 0,
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.transparent,
                dotSecondaryColor: Colors.transparent,
              ),
              likeBuilder: (isLiked) {
                return Icon(
                  FontAwesomeIcons.retweet,
                  color: isLiked ? Colors.green : null,
                );
              },
              onTap: (isLiked) async {
                String token = '';
                await Future(() async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  token = await prefs.getString('token')!;
                });
                print(" the like value $isLiked");
                if (isLiked) {
                  // var res = await LikeTweet.unLikeTweet(widget.id, token);
                  BlocProvider.of<TweetsUpdateCubit>(context)
                      .deleteretweet(widget.id);
                  return false;
                } else {
                  // var res = await LikeTweet.likeTweet(widget.id, token);

                  BlocProvider.of<TweetsUpdateCubit>(context)
                      .retweet(widget.id);
                  return true;
                }
              },
              likeCount: widget.retweetsCount,
              size: 20,
              likeCountPadding: EdgeInsets.only(left: screenWidth * 0.03)),

          LikeButton(
              isLiked: widget.isUserLiked,
              key: const ValueKey(HomePageKeys.tweetLikesCount),
              onTap: (isLiked) async {
                String token = '';
                await Future(() async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  token = await prefs.getString('token')!;
                });
                print(" the like value $isLiked");
                if (isLiked) {
                  var res = await LikeTweet.unLikeTweet(widget.id, token);
                  BlocProvider.of<TweetsUpdateCubit>(context)
                      .unLikeTweet(widget.id);
                  return res;
                } else {
                  var res = await LikeTweet.likeTweet(widget.id, token);

                  BlocProvider.of<TweetsUpdateCubit>(context)
                      .likeTweet(widget.id);
                  return res;
                }
              },
              likeCount: widget.likesCount,
              size: 20,
              likeCountPadding: EdgeInsets.only(left: screenWidth * 0.009)),
          Row(
            children: [
              const Icon(Icons.bar_chart), // Replace with your desired icon
              SizedBox(
                  width: screenWidth *
                      0.009), // Adjust the width as per your preference
              Text(widget.viewsCount
                  .toString()), // Replace with your desired label
            ],
          ),
          // Replace with your desired icon
        ],
      ),
    );
  }
}
