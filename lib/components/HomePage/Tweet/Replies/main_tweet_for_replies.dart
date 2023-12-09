import 'package:flutter/material.dart';

import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/interactions.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/text_reply_info.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/user_tweet_info_main_reply.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_media.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info_web.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/views/followersAndFollowing/likers_in_tweet.dart';

class MainTweetReplies extends StatelessWidget {
  const MainTweetReplies(
      {super.key, required this.tweet, required this.replyto});
  final Tweet tweet;
  final List<String> replyto;

  @override
  Widget build(BuildContext context) {
    List<String>? t = tweet.image;
    print('datee' + tweet.createdDate.toString());

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 253, 255),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 9, right: 7, top: 7),
                child: UserImageForTweet(
                  userid: tweet.userId,
                  image: tweet.userImage!,
                  text: tweet.userId == TempUser.id ? '' : 'Following',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kIsWeb
                          ? User_TweetInfoWeb(
                              tweet: tweet,
                              forProfile: false,
                            )
                          : UserTweetInfoReply(
                              tweet: tweet,
                              replyto: replyto,
                            ),
                      if (tweet.tweetText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LikersInTweet(id: tweet.id),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 2, right: 2),
                              child: Text(
                                tweet.tweetText!,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      // const NetworkVideoPlayer(
                      //   video: '',
                      // ),
                      if (t != null) TweetMedia(pickedfiles: tweet.image!),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 7, bottom: 10),
            child: Row(
              children: [
                TextReplyInfo(count: '', text: tweet.createdDate[0]),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    width: 3,
                    height: 3,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 133, 132, 132),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                TextReplyInfo(count: '', text: tweet.createdDate[1]),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 3.0, right: 7),
                    width: 3,
                    height: 3,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 133, 132, 132),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                TextReplyInfo(
                    count: tweet.viewsCount.toString(), text: 'Views'),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color.fromARGB(255, 153, 153, 153),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 12, bottom: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextReplyInfo(
                      count: tweet.retweetsCount.toString(), text: 'Reposts'),
                ),
                TextReplyInfo(
                    count: tweet.likesCount.toString(), text: 'Likes'),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color.fromARGB(255, 153, 153, 153),
          ),
          InteractionReplyScreen(tweet: tweet),
          Divider(
            height: 1,
            color: Color.fromARGB(255, 153, 153, 153),
          ),
        ],
      ),
    );
  }
}
