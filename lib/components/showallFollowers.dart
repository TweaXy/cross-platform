import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/models/followers_model.dart';

class ShowAllFollowersAndFollowing extends StatefulWidget {
  ShowAllFollowersAndFollowing(
      {super.key,
      required this.follow,
      required this.isFollower,
      required this.controller});
  List<FollowersModel> follow = [];
  ScrollController controller;
  bool isFollower;

  @override
  State<ShowAllFollowersAndFollowing> createState() =>
      _ShowAllFollowersAndFollowingState();
}

class _ShowAllFollowersAndFollowingState
    extends State<ShowAllFollowersAndFollowing> {
  List<FollowersModel> allfollow = [];
  @override
  void initState() {
    super.initState();
    allfollow = widget.follow;
    widget.controller.addListener(() {
      if (widget.controller.position.maxScrollExtent ==
          widget.controller.offset) {
        setState(() {
          if (widget.follow.isNotEmpty) allfollow.addAll(widget.follow);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // allfollow = widget.follow;
    return ListView.builder(
      controller: widget.controller,
      itemBuilder: (context, index) {
        return CustomFollowers(
          user: allfollow[index],
          isFollower: widget.isFollower,
        );
      },
      itemCount: allfollow.length,
    );
  }
}
