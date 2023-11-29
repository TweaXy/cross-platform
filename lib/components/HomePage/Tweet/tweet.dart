import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_general.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_mobile.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_web.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info_web.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomTweet extends StatelessWidget {
  const CustomTweet({super.key, required this.tweet, required this.forProfile});
  final bool forProfile;
  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String? t = tweet.image;

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
                kIsWeb
                    ? User_TweetInfoWeb(
                        tweet: tweet,
                        forProfile: forProfile,
                      )
                    : User_TweetInfo(
                        tweet: tweet,
                        forProfile: forProfile,
                      ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0, left: 2, right: 2),
                  child: Text(
                    tweet.tweetText!,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                if (t != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.3,
                      image: CachedNetworkImageProvider(
                        'http://16.171.65.142:3000/uploads/tweetsMedia/$t',
                      ),
                    ),
                  ),
                TweetInteractions(
                  likesCount: tweet.likesCount,
                  viewsCount: tweet.viewsCount,
                  retweetsCount: tweet.retweetsCount,
                  commentsCount: tweet.commentsCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
