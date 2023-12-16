import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/replies_screen.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/multi_video.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/network_video_player.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_general.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_media.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info.dart';
import 'package:tweaxy/components/HomePage/Tweet/user_tweet_info_web.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/followersAndFollowing/likers_in_tweet.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class CustomTweet extends StatelessWidget {
  const CustomTweet({super.key, required this.tweet, required this.replyto});
  final List<String> replyto;
  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<String>? t = tweet.image;
    String? k = null;
    if (t != null) k = t[0]!;
    // if (t != null && t.length > 1) k = t[1].trim()!;

    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
      builder: (context, state) {
//         if (state is TweetDeleteState )
//              if (state.tweetid ==tweet.id)
//             {Navigator.pop(context);
// setState(){}
//             }
        return GestureDetector(
          onTap: () {
            print('tapped');
            Navigator.push(
                context,
                CustomPageRoute(
                    child: RepliesScreen(
                      tweet: tweet,
                      replyto: replyto,
                    ),
                    direction: AxisDirection.left));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 253, 253, 255),
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
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 3, left: 25),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.retweet,
                            size: 20, color: Color.fromARGB(255, 95, 94, 94)),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: screenWidth * 0.5),
                          child: Text(
                            maxLines: 1,
                            '  ${tweet.userName}',
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 95, 94, 94)),
                          ),
                        ),
                        const Text(
                          maxLines: 1,
                          '  reposted',
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 95, 94, 94)),
                        ),
                      ],
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      key: new ValueKey(HomePageKeys.userImageInTweetClick),
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
                                ),
                          if (tweet.tweetText != null)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              margin: const EdgeInsets.only(
                                  left: 2, right: 2, bottom: 5),
                              child: Text(
                                tweet.tweetText!,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                ),
                              ),
                            ),
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
                                      .where((element) =>
                                          !element.endsWith('.mp4'))
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
                            isUserRetweeted: tweet.isUserCommented,
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
      },
    );
  }
}
