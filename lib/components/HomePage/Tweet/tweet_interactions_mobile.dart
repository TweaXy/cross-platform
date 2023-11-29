import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet_interactions_general.dart';

class TweetInteractionsMobile extends StatelessWidget {
  const TweetInteractionsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TweetInteractions(),
          Icon(Icons.share_rounded), // Replace with your desired icon
          // Replace with your desired label
        ],
      ),
    );
  }
}
