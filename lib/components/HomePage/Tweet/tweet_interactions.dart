import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class TweetInteractions extends StatelessWidget {
  const TweetInteractions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.comment), // Replace with your desired icon
              SizedBox(width: 5), // Adjust the width as per your preference
              Text('2,000'), // Replace with your desired label
            ],
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.retweet), // Replace with your desired icon
              SizedBox(width: 5), // Adjust the width as per your preference
              Text('2,000'), // Replace with your desired label
            ],
          ),
          LikeButton(
              likeCount: 20,
              size: 20,
              likeCountPadding: const EdgeInsets.only(left: 4.0)),
          Row(
            children: [
              Icon(Icons.bar_chart), // Replace with your desired icon
              SizedBox(width: 5), // Adjust the width as per your preference
              Text('2,000'), // Replace with your desired label
            ],
          ),

          Icon(Icons.share_rounded), // Replace with your desired icon
          // Replace with your desired label
        ],
      ),
    );
  }
}
