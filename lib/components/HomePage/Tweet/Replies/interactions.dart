import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/like_tweet.dart';
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
              icon: const Icon(FontAwesomeIcons.comment),
              onPressed: () {
                addReplyPress();
              },
            ), // Replace with your desired icon
            SizedBox(
                width: screenWidth *
                    0.009), // Adjust the width as per your preference
          ],
        ),
        Row(
          children: [
            const Icon(
                FontAwesomeIcons.retweet), // Replace with your desired icon
            SizedBox(
                width: screenWidth *
                    0.009), // Adjust the width as per your preference
            // Replace with your desired label
          ],
        ),
        LikeButton(
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
              BlocProvider.of<TweetsUpdateCubit>(context).unLikeTweet(tweet.id);
              return (res);
            } else {
              var res = await LikeTweet.likeTweet(tweet.id, token);
              BlocProvider.of<TweetsUpdateCubit>(context).likeTweet(tweet.id);
              return res;
            }
          },
          size: 23,
          isLiked: tweet.isUserLiked,
        ),

        // Replace with your desired icon
      ],
    );
  }
}
