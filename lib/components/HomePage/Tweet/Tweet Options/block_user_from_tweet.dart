import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/shared/keys/tweet_keys.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class BlockUserTweet extends StatelessWidget {
  const BlockUserTweet(
      {super.key,
      required this.userHandle,
      required this.tweetid,
      required this.isUserBlocked,
      required this.userid});
  final String userHandle;
  final String tweetid;
  final bool isUserBlocked;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: new ValueKey(TweetKeys.blockUserFromTweet),
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
          BlocProvider.of<TweetsUpdateCubit>(context).blockUser(userid);
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
