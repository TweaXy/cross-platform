import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_general.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_mobile.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_web.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomTweet extends StatelessWidget {
  const CustomTweet({super.key, required this.tweet});

  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 0.2,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 135, 135, 135)
                    : const Color.fromARGB(255, 233, 233, 233))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 2, right: 7),
            child: UserImageForTweet(image: tweet.userImage!),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                User_TweetInfo(
                  tweet: tweet,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0, left: 2, right: 2),
                  child: Text(
                    tweet.tweetText!,
                    style: TextStyle(
                      fontSize: 18,
                      // color: const Color.fromARGB(255, 132, 132, 132),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(tweet.image!),
                  ),
                ),
                TweetInteractions(),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: AspectRatio(
                //     aspectRatio: 16 / 9,
                //     child: Chewie(
                //       controller: _chewieController,
                //     ),
                //   ),
                // ),

                // Expanded(child: Container( child: VideoPlayerScreen()))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
