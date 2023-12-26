import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/services/follow_user.dart';

class FollowUserTweet extends StatelessWidget {
  const FollowUserTweet(
      {super.key,
      required this.userHandle,
      required this.tweetid,
      required this.userid,
      required this.isfollowedByMe});
  final String userHandle;
  final String tweetid;
  final String userid;
  final bool isfollowedByMe;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Navigator.pop(context);
        if (isfollowedByMe)
          await FollowUser.instance.deleteUser(userHandle);
        else
          await FollowUser.instance.followUser(userHandle);

        Fluttertoast.showToast(
            msg: isfollowedByMe
                ? 'You Unfollowed @${userHandle}'
                : 'You followed @${userHandle}');
        BlocProvider.of<TweetsUpdateCubit>(context).unfollowUser(userid);
      },
      leading: Icon(
        Icons.person_remove_outlined,
        color: Colors.blueGrey[600],
      ),
      title: Text(
        isfollowedByMe ? 'Unfollow @${userHandle}' : 'follow @${userHandle}',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
