import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/Delete%20Tweet/delete_alert_dialog.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';

class ModalBottomProfilePosts extends StatelessWidget {
  const ModalBottomProfilePosts({super.key, required this.tweetid});
  final String tweetid;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          onTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteAlertDialog(
                    tweetid: tweetid,
                  );
                });
          },
          leading: Icon(
              key: new ValueKey(DeleteTweetKeys.tweetSettingsMenuDeleteMobile),
              FontAwesomeIcons.trashCan),
          title: const Text(
            'Delete post',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}