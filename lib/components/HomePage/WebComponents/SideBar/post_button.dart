import 'package:flutter/material.dart';

import 'package:tweaxy/Views/add_tweet/add_tweet_web_view.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      // statesController:,
      onPressed: () {
        showDialog(
          useSafeArea: false,
          barrierColor: const Color.fromARGB(100, 97, 119, 129),
          context: context,
          builder: (BuildContext context) {
            return const AddTweetWebView(); // Use the custom dialog widget
          },
        );
      },
      style: ElevatedButton.styleFrom(
         backgroundColor:  const Color(0xFF1e9aeb),
         shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        elevation: 20,
        padding: EdgeInsets.all(screenWidth * 0.015),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),

      child: const Text(
        'Post',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white),
      ),
    );
  }
}
