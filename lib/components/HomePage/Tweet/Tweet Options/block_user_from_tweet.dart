import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/services/blocking_user_service.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class BlockUserTweet extends StatelessWidget {
  const BlockUserTweet(
      {super.key,
      required this.userHandle,
      required this.tweetid,
      required this.isUserBlocked});
  final String userHandle;
  final String tweetid;
  final bool isUserBlocked;
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
        }
      },
      leading: Icon(
        Icons.block,
        color: Colors.blueGrey[600],
      ),
      title: Text(
        'Block @${userHandle}',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
