import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_followers.dart';

class ShowAllFollowersAndFollowing extends StatelessWidget {
  ShowAllFollowersAndFollowing({super.key, required this.follow});
  List<int> follow = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: follow.length,
        itemBuilder: (context, index) {
          return CustomFollowers(
            isFollower: true,
          );
        });
  }
}
