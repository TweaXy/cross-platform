import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/services/blocking_user_service.dart';

class BlockUserTweet extends StatelessWidget {
  const BlockUserTweet(
      {super.key, required this.userHandle, required this.tweetid});
  final String userHandle;
  final String tweetid;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            title: Text(
              'Block @${userHandle}',
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),
            content: Text(
              "@${userHandle} will no longer be able to follow or message you, and you will not see notifications from @${userHandle}",
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    bool flag = await BlockingUserService.blockUser(
                        username: userHandle);
                    if (flag)
                      BlocProvider.of<TweetsUpdateCubit>(context)
                          .blockUser(tweetid);
                    showToastWidget(
                        CustomToast(
                          message: flag
                              ? 'You blocked  @${userHandle}'
                              : 'Error blocking this user',
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    //TODO: Implement Block Logic
                    Navigator.pop(context);
                  },
                  child: const Text('Block',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
            ],
          ),
        );
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
