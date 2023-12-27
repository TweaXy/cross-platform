import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/Delete%20Tweet/tweet_settings_profile_web.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';

class User_TweetInfoWeb extends StatelessWidget {
  const User_TweetInfoWeb(
      {super.key, required this.tweet});
  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              tweet.userName,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              // tweet.userName.length <= 9
              //     ? '@${tweet.userHandle}'
              //     : '${'@${tweet.userHandle.substring(0, 8)}'}...',
              '@${tweet.userHandle}',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
              ),
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
        Container(
          alignment: Alignment.bottomRight,
          child: Container(
            child: ( tweet.userId == TempUser.id)
                ? TweetSettingsProfileWeb(
                    tweetId: tweet.id, parentid: tweet.parentid,
                  )
                : IconButton(
                    key: const ValueKey(DeleteTweetKeys.tweetSettingsClickWeb),
                    splashRadius: 15,
                    hoverColor: const Color.fromARGB(255, 207, 232, 253),
                    icon: const Icon(FontAwesomeIcons.ellipsis),
                    iconSize: 16,
                    onPressed: () {
                      // if (isProfile)
                    },
                  ),
          ),
        )
      ],
    );
  }
}
// 