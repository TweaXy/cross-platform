import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/models/followers_model.dart';

class ShowAllFollowersAndFollowing extends StatelessWidget {
  ShowAllFollowersAndFollowing(
      {super.key,
      required this.follow,
      required this.isFollower,
      required this.controller});
  List<FollowersModel> follow = [];
  ScrollController controller;
  bool isFollower;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CustomFollowers(
                user: follow[index],
                isFollower: isFollower,
              );
            },
            childCount: follow.length,
          ),
        ),
      ],
    );
  }
}
