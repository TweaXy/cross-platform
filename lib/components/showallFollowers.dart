import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/models/followers_model.dart';

class ShowAllFollowersAndFollowing extends StatelessWidget {
  ShowAllFollowersAndFollowing(
      {super.key, required this.follow, required this.isFollower});
  List<FollowersModel> follow = [];
  bool isFollower;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: follow.length,
        itemBuilder: (context, index) {
          return CustomFollowers(
            user: follow[index],
            isFollower: isFollower,
          );
        });
  }
}
