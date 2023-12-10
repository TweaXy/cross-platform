import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';

class UserTweetInfoReply extends StatelessWidget {
  const UserTweetInfoReply(
      {super.key, required this.tweet, required this.replyto});
  final Tweet tweet;
  final List<String> replyto;
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenwidth * 0.6),
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenwidth * 0.6),
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
              ],
            ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                color: const Color.fromARGB(255, 182, 182, 182),
                iconSize: 16,
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
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
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
}
