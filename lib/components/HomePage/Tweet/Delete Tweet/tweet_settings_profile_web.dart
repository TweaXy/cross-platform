import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/Delete%20Tweet/delete_alert_dialog_web.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';

class TweetSettingsProfileWeb extends StatelessWidget {
  const TweetSettingsProfileWeb({super.key, required this.tweetId, required this.parentid});
  final String tweetId;
  final String parentid;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: '',
        splashRadius: 15,
        elevation: 4,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        position: PopupMenuPosition.over,
        onSelected: (value) {
          // your logic
          // print('hello');
          if (value == 'delete') {
            print('hi');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteAlertDialogWeb(
                    tweetId: tweetId, parentid: parentid,
                  );
                });
          }
        },
        itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(
              value: 'delete',
              child: Wrap(
                children: [
                  Icon(
                    key: new ValueKey(
                        DeleteTweetKeys.tweetSettingsMenuDeleteWeb),
                    FontAwesomeIcons.trashCan,
                    size: 20,
                    color: Colors.red,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 2, left: 10),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ))
                ],
              ),
            ),
          ];
        },
        icon: Icon(
          key: new ValueKey(DeleteTweetKeys.tweetSettingsClickWeb),
          FontAwesomeIcons.ellipsis,
          size: 16,
        ));
  }
}
