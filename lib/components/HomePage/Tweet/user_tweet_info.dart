import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';
import 'package:tweaxy/shared/utils.dart';

class User_TweetInfo extends StatelessWidget {
  const User_TweetInfo(
      {super.key, required this.tweet, required this.forProfile});
  final Tweet tweet;
  final bool forProfile;
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            tweet.userName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color.fromARGB(255, 12, 12, 12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            tweet.userName.length <= 4
                ? '@${tweet.userHandle}'
                : '${'@${tweet.userHandle.substring(0, 4)}'}...',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 121, 121, 121),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Center(
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
          alignment: Alignment.bottomRight,
          child: IconButton(
            key: ValueKey((Utils()).hashText(
                DeleteTweetKeys.tweetSettingsClickMobile +
                    tweet.tweetText!.toString() +
                    tweet.userHandle.toString())),
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            color: const Color.fromARGB(255, 182, 182, 182),
            iconSize: 16,
            onPressed: () {
              if (forProfile || tweet.userId == TempUser.id) {
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
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
