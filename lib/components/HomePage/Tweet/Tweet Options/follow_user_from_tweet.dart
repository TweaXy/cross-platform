import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/services/follow_user.dart';

class FollowUserTweet extends StatelessWidget {
  const FollowUserTweet({super.key, required this.userHandle, required this.tweetid, required this.userid});
  final String userHandle;
  final String tweetid;
  final String userid;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Navigator.pop(context);
        await FollowUser.instance.deleteUser(userHandle);
        Fluttertoast.showToast(msg: 'You Unfollowed @${userHandle}');
        BlocProvider.of<TweetsUpdateCubit>(context).unfollowUser(userid);
      },
      leading: Icon(
        Icons.person_remove_outlined,
        color: Colors.blueGrey[600],
      ),
      title: Text(
        'Unfollow @${userHandle}',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
