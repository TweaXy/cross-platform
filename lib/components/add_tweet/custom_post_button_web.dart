import 'package:flutter/material.dart';

class CustomPostButtonWeb extends StatelessWidget {
  const CustomPostButtonWeb({super.key, required this.isButtonEnabled});
  final bool isButtonEnabled;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey(" tweet add post button web"),
      onPressed: () {
        // if (tweetcontent.text.isNotEmpty ||
        //     xfilePick.isNotEmpty) {
        //   AddTweet service = AddTweet(Dio());
        //   Future response = await service.addTweet(
        //       tweetcontent.text, xfilePick);
        // } else {
        //   // showToastWidget(const CustomWebToast(
        //   //     message: "the tweet cant be empty"));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonEnabled
            ? const Color(0xFF1e9aeb)
            : const Color.fromARGB(255, 156, 203, 250),
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        elevation: 20,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      child: const Text(
        'Post',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
