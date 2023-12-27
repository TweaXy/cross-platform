import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/modal_bottom_options_posts.dart';

class WrapModalBottomProfile extends StatelessWidget {
  const WrapModalBottomProfile({super.key, required this.tweetid, required this.forreply, required this.parentid});
  final String tweetid;
  final bool forreply;
  final String parentid;

  @override
  Widget build(BuildContext context) {
    return ModalBottomProfilePosts(
      tweetid: tweetid,
      forreply: forreply, parentid: parentid,
    );
  }
}
