import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/models/tweet.dart';

class User_TweetInfo extends StatelessWidget {
  const User_TweetInfo(
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
                ? '@${tweet.userHandle}'
                : '${'@${tweet.userHandle.substring(0, 8)}'}...',
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
        SizedBox(
          width: 2,
          child: IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            iconSize: 16,
            onPressed: () {
              // if (isProfile)
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
                  return const WrapModalBottomProfile();
                },
              );
            },
          ),
        )
      ],
    );
  }
}
