import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/add_tweet.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';

class CustomAddTweetButton extends StatelessWidget {
  CustomAddTweetButton(
      {super.key,
      required this.isButtonEnabled,
      required this.textPadding,
      required this.tweetcontent,
      required this.xfilePick});

  final bool isButtonEnabled;
  final EdgeInsetsGeometry textPadding;
  final dynamic tweetcontent;
  final dynamic xfilePick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey(AddTweetKeys.postTweet),
      onPressed: () async {
        if (tweetcontent.text.isNotEmpty) {
          AddTweet service = AddTweet(Dio());
          dynamic response =
              await service.addTweet(tweetcontent.text, xfilePick);
          log(response.toString());
          if (response is String) {
            showToastWidget(
                const CustomToast(message: "the tweet cant be posted"));
          } else {
            showToastWidget(
                const CustomToast(message: "the tweet has been posted"));
          }
        } else {
          showToastWidget(
              const CustomToast(message: "the tweet cant be empty"));
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
        child: const Text(
          "Post",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),
        ),
      ),
    );
  }
}
