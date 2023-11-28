import 'package:flutter/material.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';

class CustomAddTweetButton extends StatelessWidget {
  const CustomAddTweetButton({
    super.key,
    required this.isButtonEnabled,
  });

  final bool isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey(AddTweetKeys.postTweet),
      onPressed: () async {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonEnabled
            ? const Color(0xFF1e9aeb)
            : const Color.fromARGB(255, 156, 203, 250),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
        child: Text(
          "Post",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),
        ),
      ),
    );
  }
}
