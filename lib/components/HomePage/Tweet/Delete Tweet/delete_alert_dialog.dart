import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({super.key, required this.tweetid});
  final String tweetid;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.height * 0.9;
    return AlertDialog(
      insetPadding: EdgeInsets.all(width * 0.04),
      contentPadding:
          EdgeInsets.only(left: width * 0.035, right: width * 0.035, top: 10),
      title: const Text('Delete post?',
          style:
              TextStyle(fontSize: 25)), // To display the title it is optional
      content: const Text(
          style: TextStyle(fontSize: 18),
          'This can\'t be undone and it will be removed from your profile, the timeline of any accounts that follow you, and from search results'), // Message which will be pop up on the screen
      actions: [
        TextButton(
          key: new ValueKey(DeleteTweetKeys.tweetCancelDeleteMobile),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel',
              style: TextStyle(color: Colors.black, fontSize: 19)),
        ),
        TextButton(
          key: new ValueKey(DeleteTweetKeys.tweetDeleteConfirmMobile),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () async {
            String t = await TweetsServices.deleteTweet(tweetid: tweetid);
            Navigator.pop(context);
            showToastWidget(
                CustomToast(
                  message: t == "success" ? 'Your post was deleted' : t,
                ),
                position: ToastPosition.bottom,
                duration: const Duration(seconds: 2));
            if (t == "success")
              BlocProvider.of<TweetsUpdateCubit>(context)
                  .deleteTweet(tweetid: tweetid);
          },
          child: const Text('Delete',
              style: TextStyle(color: Colors.black, fontSize: 19)),
        ),
      ],
    );
  }
}
