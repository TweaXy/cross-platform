import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/Delete%20Tweet/delete_alert_dialog.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/modal_bottom_options_posts.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';

class WrapModalBottomProfile extends StatelessWidget {
  const WrapModalBottomProfile({super.key, required this.tweetid, required this.forreply});
  final String tweetid;
  final bool forreply;

  @override
  Widget build(BuildContext context) {
    return ModalBottomProfilePosts(
      tweetid: tweetid,
      forreply: forreply,
    );
  }
}
