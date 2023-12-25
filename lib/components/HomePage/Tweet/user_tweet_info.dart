import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/Tweet%20Options/block_user_from_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/Tweet%20Options/follow_user_from_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/Tweet%20Options/mute_user_from_tweet.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/blocking_user_service.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';
import 'package:tweaxy/shared/utils.dart';

class User_TweetInfo extends StatelessWidget {
  const User_TweetInfo({
    super.key,
    required this.tweet,
    required this.replyto,
    required this.isMuted,
    required this.isUserBlocked,
  });
  final Tweet tweet;
  final List<String> replyto;
  final bool isMuted;
  final bool isUserBlocked;
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenwidth * 0.3),
                child: Text(
                  maxLines: 1,
                  tweet.userName,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color.fromARGB(255, 12, 12, 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenwidth * 0.2),
                  child: Text(
                    maxLines: 1,
                    // tweet.userName.trim().length <= 5
                    //     ? '@${tweet.userHandle}'
                    //     : '${'@${tweet.userHandle.substring(0, 7)}'}...',
                    '${'@' + tweet.userHandle.toString()}',
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                      color: Color.fromARGB(255, 108, 108, 108),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  width: 3,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 121, 121, 121),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(
                  tweet.time,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 121, 121, 121),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  key: ValueKey((Utils()).hashText(
                      DeleteTweetKeys.tweetSettingsClickMobile +
                          (tweet.tweetText == null ? '' : tweet.tweetText)
                              .toString() +
                          tweet.userHandle.toString())),
                  icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                  color: const Color.fromARGB(255, 182, 182, 182),
                  iconSize: 18,
                  onPressed: () {
                    if (tweet.userId ==
                            TempUser
                                .id && //my post and not retweet or my post and my retweet
                        (!tweet.isretweet ||
                            tweet.userId == tweet.reposteruserid)) {
                      showModalBottomSheet(
                        showDragHandle: true,
                        useSafeArea: false,
                        enableDrag: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.0),
                          ),
                        ),
                        builder: (context) {
                          return WrapModalBottomProfile(
                            tweetid: tweet.id,
                            forreply: false,
                            parentid: tweet.parentid,
                          );
                        },
                      );
                    } else if (!tweet.isretweet ||
                        (tweet.userId != TempUser.id && tweet.isretweet)) {
                      showModalBottomSheet(
                        showDragHandle: true,
                        useSafeArea: false,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              FollowUserTweet(
                                userHandle: tweet.userHandle,
                                tweetid: tweet.id,
                                userid: tweet.userId,
                              ),
                              MuteUserTweet(
                                tweetid: tweet.id,
                                userHandle: tweet.userHandle,
                                isMuted: isMuted,
                                userid: tweet.userId,
                              ),
                              BlockUserTweet(
                                userHandle: tweet.userHandle,
                                tweetid: tweet.id,
                                isUserBlocked: isUserBlocked,
                                userid: tweet.userId,
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
        replyto.length > 0
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 25),
                child: Wrap(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: 'Replying to ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 108, 108, 108),
                        fontWeight: FontWeight.w400,
                      ),
                      children: replyto.asMap().entries.map((e) {
                        return TextSpan(
                            text: '${'@' + e.value}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.blue),
                            children: <TextSpan>[
                              TextSpan(
                                  text: (e.key != replyto.length - 1)
                                      ? ' and '
                                      : '')
                            ]);
                      }).toList(),
                    ))
                  ],
                ),
              )
            : Container()
      ],
    );
  }

  Widget repliesNames() {
    return Wrap(
      children: [
        RichText(
            text: TextSpan(
          children: replyto.asMap().entries.map((e) {
            return TextSpan(
                text: e.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.blue),
                children: <TextSpan>[
                  TextSpan(text: (e.key != replyto.length - 1) ? ' and ' : '')
                ]);
          }).toList(),
        ))
      ],
    );
  }
}
