import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/services/add_tweet_and_reply.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';

class CustomAddTweetButton extends StatelessWidget {
  const CustomAddTweetButton({
    super.key,
    required this.isButtonEnabled,
    required this.textPadding,
    required this.tweetcontent,
    required this.xfilePick,
    required this.isReply,
    this.tweetId,
  });

  final bool isButtonEnabled;
  final EdgeInsetsGeometry textPadding;
  final dynamic tweetcontent;
  final dynamic xfilePick;

  final bool isReply;
  final String? tweetId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey(AddTweetKeys.postTweet),
      onPressed: () async {
        String type = isReply ? 'reply' : 'post';

        if (tweetcontent.text.isNotEmpty) {
          // if (tweetcontent.text.isNotEmpty || xfilePick.isNotEmpty) {
          AddTweetAndReply service = AddTweetAndReply(Dio());
          dynamic response = isReply
              ? await service.addReply(tweetcontent.text, xfilePick, tweetId!)
              : await service.addTweet(tweetcontent.text, xfilePick);
          log(response.toString());
          if (response is String) {
            showToastWidget(CustomToast(message: "the $type cant be posted"));
          } else {
            showToastWidget(CustomToast(message: "the $type has been posted"));
          }
          BlocProvider.of<TweetsUpdateCubit>(context).addTweet();
          Navigator.pop(context);
        } else {
          showToastWidget(CustomToast(message: "the $type cant be empty"));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonEnabled
            ? const Color(0xFF1e9aeb)
            : const Color.fromARGB(255, 156, 203, 250),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      child: Padding(
        padding: textPadding,
        child: Text(
          isReply ? 'Reply' : 'Post',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),
        ),
      ),
    );
  }
}
