import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/like_tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/shared/keys/tweet_keys.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class InteractionReplyScreen extends StatelessWidget {
  const InteractionReplyScreen({super.key, required this.tweet});
  final Tweet tweet;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            IconButton(
              key: const ValueKey(TweetKeys.replyInteractionRepliesScreen),
              icon: const Icon(FontAwesomeIcons.comment),
              onPressed: () {
                addReplyPress(context,
                    tweetId: tweet.id, tweetAuthor: tweet.userHandle);
              },
            ), // Replace with your desired icon
            SizedBox(
                width: screenWidth *
                    0.009), // Adjust the width as per your preference
          ],
        ),
        LikeButton(
          key: const ValueKey(TweetKeys.repostInteraction),
          isLiked: tweet.isUserRetweeted,
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
              var res = await TweetsServices.deleteRetweet(tweetid: tweet.id);
              BlocProvider.of<TweetsUpdateCubit>(context).deleteretweet(
                  userid: tweet.userId,
                  id: tweet.id,
                  isretweet: tweet.isretweet,
                  parentid: tweet.parentid);
              return !res;
            } else {
              var res = await TweetsServices.addRetweet(tweet.id);

              BlocProvider.of<TweetsUpdateCubit>(context)
                  .retweet(tweet.parentid, tweet.id);
              return res;
            }
          },
          size: 20,
        ),
        LikeButton(
          key: const ValueKey(TweetKeys.likeInteractionRepliesScreen),
          isLiked: tweet.isUserLiked,
          onTap: (isLiked) async {
            String token = '';
            await Future(() async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              token = await prefs.getString('token')!;
            });
            print(" the like value $isLiked");
            if (isLiked) {
              var res = await LikeTweet.unLikeTweet(tweet.id, token);
              BlocProvider.of<TweetsUpdateCubit>(context)
                  .unLikeTweet(tweet.parentid, tweet.id);
              return res;
            } else {
              var res = await LikeTweet.likeTweet(tweet.id, token);

              BlocProvider.of<TweetsUpdateCubit>(context)
                  .likeTweet(tweet.parentid, tweet.id);
              return res;
            }
          },
          size: 25,
        ),

        // Replace with your desired icon
      ],
    );
  }
}
