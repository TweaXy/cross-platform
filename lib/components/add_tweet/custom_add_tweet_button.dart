import 'package:flutter/material.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';

class CustomAddTweetButton extends StatelessWidget {
  const CustomAddTweetButton({
    super.key,
    required this.isButtonEnabled,required this.textPadding
  });

  final bool isButtonEnabled;
  final EdgeInsetsGeometry textPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey(AddTweetKeys.postTweet),
      onPressed: () async {
        // if (tweetcontent.text.isNotEmpty ||
        //     xfilePick.isNotEmpty) {
        //   AddTweet service = AddTweet(Dio());
        //   Future response = await service.addTweet(
        //       tweetcontent.text, xfilePick);
        // } else {
        //   // showToastWidget(const CustomWebToast(
        //   //     message: "the tweet cant be empty"));
        // }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonEnabled
            ? const Color(0xFF1e9aeb)
            : const Color.fromARGB(255, 156, 203, 250),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      child:  Padding(
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
