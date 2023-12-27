import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/replies_screen.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/multi_video.dart';
import 'package:tweaxy/components/HomePage/Tweet/reposted.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_general.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_media.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info_web.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/tweet_keys.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';

class CustomTweet extends StatelessWidget {
  const CustomTweet(
      {super.key,
      required this.tweet,
      required this.replyto,
      required this.isMuted,
      required this.isUserBlocked});
  final List<String> replyto;
  final Tweet tweet;
  final bool isMuted;
  final bool isUserBlocked;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<String> rawLines = [];
    if (tweet.tweetText != null) {
      rawLines = tweet.tweetText!
          .split(RegExp(r'(?<=#\w+)(?=\s)'))
          .expand((s) => s.split(RegExp(r'(?<=\S)(?=\s)')))
          .toList();
    }
    List<String>? t = tweet.image;
    String? k;
    if (t != null) k = t[0];
    return GestureDetector(
      key: const ValueKey(TweetKeys.clickToShowRepliesScreen),
      onTap: () {
        print('tapped');
        Navigator.push(
            context,
            CustomPageRoute(
                child: RepliesScreen(
                  replyto: replyto,
                  tweetid:
                      tweet.id == tweet.parentid ? tweet.id : tweet.parentid,
                  userHandle: tweet.userHandle,
                  isARepost: tweet.isretweet,
                  reposteruserName: tweet.reposteruserName,
                ),
                direction: AxisDirection.left));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 253, 253, 255),
          border: Border(
              bottom: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 135, 135, 135)
                      : const Color.fromARGB(255, 233, 233, 233))),
        ),
        child: Column(
          children: [
            if (tweet.isretweet)
              RepostedBy(
                userId: tweet.userId,
                reposteruserid: tweet.reposteruserid,
                reposteruserName: TempUser.id == tweet.reposteruserid
                    ? ' You'
                    : '  ${tweet.reposteruserName}',
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  key: const ValueKey(HomePageKeys.userImageInTweetClick),
                  margin: const EdgeInsets.only(left: 2, right: 7, top: 7),
                  child: UserImageForTweet(
                    userid: tweet.userId,
                    image: tweet.userImage!,
                    text: tweet.userId == TempUser.id ? '' : 'Following',
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kIsWeb
                          ? User_TweetInfoWeb(
                              tweet: tweet,
                            )
                          : User_TweetInfo(
                              tweet: tweet,
                              replyto: replyto,
                              isMuted: isMuted,
                              isUserBlocked: isUserBlocked,
                            ),
                      if (tweet.tweetText != null)
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
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
                                          : const Color.fromARGB(255, 40, 39, 39)),
                                );
                              }).toList(),
                            ))),
                      // const NetworkVideoPlayer(
                      //   video: '',
                      // ),
                      // MultiVideo(),
                      if (t != null)
                        MultiVideo(
                          videos: tweet.image!
                              .where((element) => element.endsWith('.mp4'))
                              .toList(),
                        ),
                      if (t != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TweetMedia(
                              pickedfiles: tweet.image!
                                  .where((element) => !element.endsWith('.mp4'))
                                  .toList()),
                        ),
                      TweetInteractions(
                        replyto: tweet.userHandle,
                        id: tweet.id,
                        likesCount: tweet.likesCount,
                        viewsCount: tweet.viewsCount,
                        retweetsCount: tweet.retweetsCount,
                        commentsCount: tweet.commentsCount,
                        isUserLiked: tweet.isUserLiked,
                        isUserCommented: tweet.isUserCommented,
                        isUserRetweeted: tweet.isUserRetweeted,
                        userid: tweet.reposteruserid == ''
                            ? tweet.userId
                            : tweet.reposteruserid,
                        isretweet: tweet.isretweet,
                        parenttweetid: tweet.parentid,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
