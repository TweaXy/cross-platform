import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/components/HomePage/Tweet/modal_bottom_sheet_tweet.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';
import 'package:tweaxy/shared/utils.dart';

class User_TweetInfo extends StatelessWidget {
  const User_TweetInfo({super.key, required this.tweet, required this.replyto});
  final Tweet tweet;
  final List<String> replyto;
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
                    if (tweet.userId == TempUser.id) {
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
                          );
                        },
                      );
                    } else {
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
                              ListTile(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await FollowUser.instance
                                      .deleteUser(tweet.userName);
                                  Fluttertoast.showToast(
                                      msg: 'You Unfollowed ${tweet.userName}');
                                },
                                leading: Icon(
                                  Icons.person_remove_outlined,
                                  color: Colors.blueGrey[600],
                                ),
                                title: Text(
                                  'Unfollow @${tweet.userName}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              ListTile(
                                onTap: () async {
                                  Navigator.pop(context);

                                  AnimatedSnackBar muteAnimatedSnackBar(
                                      {IconData? icon,
                                      bool muteFlag = true,
                                      BuildContext? mainContext,
                                      bool failure = false,
                                      String userName = ''}) {
                                    String titleText = '';
                                    Color iconColor = Colors.blue[700]!;
                                    if (muteFlag) {
                                      titleText = 'You muted @$userName';
                                    } else {
                                      titleText = 'You unmuted @$userName';
                                    }
                                    return AnimatedSnackBar(
                                      mobileSnackBarPosition:
                                          MobileSnackBarPosition.top,
                                      mobilePositionSettings:
                                          const MobilePositionSettings(
                                        left: 5,
                                        right: 5,
                                      ),
                                      duration: const Duration(seconds: 3),
                                      builder: ((context) {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: failure
                                                  ? Colors.red[100]
                                                  : Colors.blue[100],
                                              border: Border.all(
                                                color: Colors.blue[700]!,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          width: double.infinity,
                                          child: ListTile(
                                            title: Text(
                                              failure
                                                  ? 'Oops There\'s an error'
                                                  : titleText,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            leading: Icon(
                                              failure ? Icons.close : icon,
                                              color: failure
                                                  ? Colors.red
                                                  : Colors.blue[700],
                                            ),
                                            subtitle: muteFlag
                                                ? ElevatedButton(
                                                    onPressed: () {
                                                      muteAnimatedSnackBar(
                                                        failure: false,
                                                        icon: Icons
                                                            .volume_off_outlined,
                                                        muteFlag: false,
                                                        mainContext: context,
                                                        userName:
                                                            tweet.userName!,
                                                      ).show(context);
                                                      // _isMuted = false;
                                                    },
                                                    child: const Text('Undo'))
                                                : null,
                                          ),
                                        );
                                      }),
                                    );
                                  }
                                  //TODO: Implement Mute Logic
                                },
                                leading: Icon(
                                  Icons.volume_off_outlined,
                                  color: Colors.blueGrey[600],
                                ),
                                title: Text(
                                  'Mute @${tweet.userName}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              ListTile(
                                onTap: () async {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      contentPadding: const EdgeInsets.all(20),
                                      title: Text(
                                        'Block @${tweet.userName}',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 24),
                                      ),
                                      content: Text(
                                        "@${tweet.userName} will no longer be able to follow or message you, and you will not see notifications from @${tweet.userName}",
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              //TODO: Implement Block Logic
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Block',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16))),
                                      ],
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.block,
                                  color: Colors.blueGrey[600],
                                ),
                                title: Text(
                                  'Block @${tweet.userName}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
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
