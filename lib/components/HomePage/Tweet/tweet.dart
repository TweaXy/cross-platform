import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info.dart';
import 'package:tweaxy/models/tweet.dart';

class CustomTweet extends StatelessWidget {
  const CustomTweet({super.key, required this.tweet});

  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom: BorderSide(
            // color: Color.fromARGB(255, 155, 154, 154),
            width: 0.2,
          ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 2, right: 7),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image(
                  width: 50,
                  image: AssetImage(tweet.userImage!),
                )),
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
                TweetInteractions()
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
