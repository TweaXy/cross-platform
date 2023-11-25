import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/delete_alert_dialog.dart';
import 'package:tweaxy/components/HomePage/Tweet/delete_alert_dialog_web.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_settings_profile.dart';
import 'package:tweaxy/models/tweet.dart';

class User_TweetInfoWeb extends StatelessWidget {
  const User_TweetInfoWeb(
      {super.key, required this.tweet, required this.forProfile});
  final Tweet tweet;
  final bool forProfile;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            tweet.userName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            tweet.userName.length <= 9
                ? '@' + tweet.userHandle
                : '${'@' + tweet.userHandle.substring(0, 8)}...',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            tweet.time,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const Spacer(),
        // if (forProfile)
        TweetSettingsProfile()
        // else
        //   IconButton(
        //     splashRadius: 15,
        //     hoverColor: const Color.fromARGB(255, 207, 232, 253),
        //     icon: const Icon(FontAwesomeIcons.ellipsis),
        //     iconSize: 16,
        //     onPressed: () {
        //       // if (isProfile)
        //     },
        //   ),
      ],
    );
  }
}
// 