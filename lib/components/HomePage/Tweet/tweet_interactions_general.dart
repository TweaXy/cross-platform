import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/services/like_tweet.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';

class TweetInteractions extends StatefulWidget {
  const TweetInteractions(
      {super.key,
      required this.id,
      required this.likesCount,
      required this.viewsCount,
      required this.retweetsCount,
      required this.commentsCount,
      required this.isUserLiked,
      required this.isUserCommented,
      required this.isUserRetweeted});
  final int likesCount;
  final int viewsCount;
  final int retweetsCount;
  final int commentsCount;
  final bool isUserLiked;
  final bool isUserCommented;
  final bool isUserRetweeted;

  final String id;

  @override
  State<TweetInteractions> createState() => _TweetInteractionsState();
}

class _TweetInteractionsState extends State<TweetInteractions> {
  bool postLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postLiked = widget.isUserLiked;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                  FontAwesomeIcons.comment), // Replace with your desired icon
              SizedBox(
                  width: screenWidth *
                      0.009), // Adjust the width as per your preference
              Text(widget.commentsCount
                  .toString()), // Replace with your desired label
            ],
          ),
          Row(
            children: [
              const Icon(
                  FontAwesomeIcons.retweet), // Replace with your desired icon
              SizedBox(
                  width: screenWidth *
                      0.009), // Adjust the width as per your preference
              Text(widget.retweetsCount
                  .toString()), // Replace with your desired label
            ],
          ),
          LikeButton(
              key: new ValueKey(HomePageKeys.tweetLikesCount),
              onTap: (isLiked) async {
                String token = '';
                await Future(() async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  token = await prefs.getString('token')!;
                });

                if (isLiked) {
                  BlocProvider.of<TweetsUpdateCubit>(context)
                      .unLikeTweet(widget.id);

                  return (await LikeTweet.unLikeTweet(widget.id, token));
                } else {

                  return await LikeTweet.likeTweet(widget.id, token);
                }
              },
              likeCount: widget.likesCount,
              size: 20,
              isLiked: widget.isUserLiked,
              likeCountPadding: EdgeInsets.only(left: screenWidth * 0.0009)),
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
