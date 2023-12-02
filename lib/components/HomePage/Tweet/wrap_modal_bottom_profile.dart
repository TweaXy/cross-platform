import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/delete_alert_dialog.dart';

class WrapModalBottomProfile extends StatelessWidget {
  const WrapModalBottomProfile({super.key, required this.tweetid});
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
          leading: const Icon(FontAwesomeIcons.trashCan),
          title: const Text(
            'Delete post',
            style: TextStyle(fontSize: 20),
          ),
        ),
        // ListTile(
        //   leading: Icon(Icons.copy),
        //   title: Text('Copy Link'),
        // ),
        // ListTile(
        //   leading: Icon(Icons.edit),
        //   title: Text('Edit'),
        // ),
      ],
    );
  }
}
