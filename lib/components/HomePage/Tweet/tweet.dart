import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_general.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_media.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info_web.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/temp_user.dart';

class CustomTweet extends StatelessWidget {
  const CustomTweet({super.key, required this.tweet, required this.forProfile});
  final bool forProfile;
  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<String>? t = tweet.image;
    String? k = null;
    if (t != null) k = t[0]!;
    // if (t != null && t.length > 1) k = t[1].trim()!;

    print('kkkk' + k.toString());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 253, 255),
        border: Border(
            bottom: BorderSide(
                width: 0.4,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 135, 135, 135)
                    : const Color.fromARGB(255, 233, 233, 233))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 2, right: 7, top: 7),
            child: UserImageForTweet(
              userid: tweet.userId,
              image: tweet.userImage!,
              text: tweet.userId == TempUser.id ? '' : 'Following',
            ),
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
                  margin: const EdgeInsets.only(
                      bottom: 5.0, left: 2, right: 2, top: 0),
                  child: Text(
                    tweet.tweetText!,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
                if (t != null) TweetMedia(pickedfiles: tweet.image!),
                TweetInteractions(
                  id: tweet.id,
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
