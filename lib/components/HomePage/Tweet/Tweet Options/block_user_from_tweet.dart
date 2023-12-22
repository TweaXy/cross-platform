import 'package:flutter/material.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class BlockUserTweet extends StatelessWidget {
  const BlockUserTweet(
      {super.key,
      required this.userHandle,
      required this.tweetid,
      required this.isUserBlocked,
      required this.parentid});
  final String userHandle;
  final String tweetid;
  final bool isUserBlocked;
  final String parentid;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Navigator.pop(context);

        if (isUserBlocked) {
          showDialog(
            context: context,
            builder: (context) => UnblockUserDialog(username: userHandle),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => BlockUserDialog(username: userHandle),
          );
          BlocProvider.of<TweetsUpdateCubit>(context)
              .blockUser(tweetid, parentid);
        }
      },
      leading: Icon(
        Icons.block,
        color: Colors.blueGrey[600],
      ),
      title: Text(
        isUserBlocked ? 'Unblock @${userHandle}' : 'Block @${userHandle}',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
