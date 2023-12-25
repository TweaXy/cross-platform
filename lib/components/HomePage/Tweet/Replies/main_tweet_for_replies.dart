import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/interactions.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/text_reply_info.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/user_tweet_info_main_reply.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/multi_video.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_media.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info_web.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/views/followersAndFollowing/likers_in_tweet.dart';
import 'package:tweaxy/views/followersAndFollowing/retweeters_in_tweet.dart';

class MainTweetReplies extends StatelessWidget {
  const MainTweetReplies(
      {super.key, required this.tweetid, required this.replyto});
  final String tweetid;
  final List<String> replyto;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: TweetsServices.getMainTweetForReply(
          offset: 0,
          id: tweetid,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            Tweet tweet = snapshot.data;
            List<String>? t = tweet.image;
            List<String> rawLines = [];
            if (tweet.tweetText != null) {
              rawLines = tweet.tweetText!
                  .split(new RegExp(r'(?<=#\w+)(?=\s)'))
                  .expand((s) => s.split(RegExp(r'(?<=\S)(?=\s)')))
                  .toList();
            }
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
                        margin:
                            const EdgeInsets.only(left: 9, right: 7, top: 4),
                        child: UserImageForTweet(
                          userid: tweet.userId,
                          image: tweet.userImage!,
                          text: tweet.userId == TempUser.id ? '' : 'Following',
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 7),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kIsWeb
                                  ? User_TweetInfoWeb(
                                      tweet: tweet,
                                    )
                                  : UserTweetInfoReply(
                                      tweet: tweet,
                                      replyto: replyto,
                                    ),
                              if (tweet.tweetText != null)
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, bottom: 5),
                                    child: RichText(
                                        text: TextSpan(
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                          color: Colors.black),
                                      children: rawLines.map((e) {
                                        return TextSpan(
                                          text: e,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: e.contains('#')
                                                  ? Colors.blue
                                                  : Color.fromARGB(
                                                      255, 40, 39, 39)),
                                        );
                                      }).toList(),
                                    ))),
                              // const NetworkVideoPlayer(
                              //   video: '',
                              // ),
                              if (t != null)
                                MultiVideo(
                                  videos: tweet.image!
                                      .where(
                                          (element) => element.endsWith('.mp4'))
                                      .toList(),
                                ),
                              if (t != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: TweetMedia(
                                      pickedfiles: tweet.image!
                                          .where((element) =>
                                              !element.endsWith('.mp4'))
                                          .toList()),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 7, bottom: 10),
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
                            margin: const EdgeInsets.only(left: 5.0, right: 7),
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
                  if (tweet.likesCount > 0 || tweet.retweetsCount > 0)
                    Divider(
                      height: 1,
                      color: Color.fromARGB(255, 153, 153, 153),
                    ),
                  if (tweet.likesCount > 0 || tweet.retweetsCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 12, bottom: 10),
                      child: Row(
                        children: [
                          if (tweet.retweetsCount > 0)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RepostsinTweet(
                                        id: tweet.isretweet
                                            ? tweet.parentid
                                            : tweet.id),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextReplyInfo(
                                    count: tweet.retweetsCount.toString(),
                                    text: 'Reposts'),
                              ),
                            ),
                          if (tweet.likesCount > 0)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LikersInTweet(
                                        id: tweet.isretweet
                                            ? tweet.parentid
                                            : tweet.id),
                                  ),
                                );
                              },
                              child: TextReplyInfo(
                                  count: tweet.likesCount.toString(),
                                  text: 'Likes'),
                            ),
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
        });
  }
}
