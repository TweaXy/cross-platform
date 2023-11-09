import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/models/tweet.dart';

class User_TweetInfo extends StatelessWidget {
  const User_TweetInfo({super.key, required this.tweet});
  final Tweet tweet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            tweet.userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            tweet.userName.length <= 9
                ? '@' + tweet.userHandle
                : '${'@' + tweet.userHandle.substring(0, 8)}...',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 133, 132, 132),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            tweet.time,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Icon(
          FontAwesomeIcons.ellipsisVertical,
          size: 15,
        )
      ],
    );
  }
}
