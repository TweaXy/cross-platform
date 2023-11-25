import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/delete_alert_dialog_web.dart';

class TweetSettingsProfile extends StatelessWidget {
  const TweetSettingsProfile({super.key});

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
                  return DeleteAlertDialogWeb();
                });
          }
        },
        itemBuilder: (BuildContext bc) {
          return const [
            PopupMenuItem(
              child: Wrap(
                children: [
                  Icon(
                    FontAwesomeIcons.trashCan,
                    size: 20,
                    color: Colors.red,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 2, left: 10),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ))
                ],
              ),
              value: 'delete',
            ),
          ];
        },
        icon: Icon(
          FontAwesomeIcons.ellipsis,
          size: 16,
        ));
  }
}
