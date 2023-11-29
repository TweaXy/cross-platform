import 'package:flutter/material.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({super.key});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  Future<void> _refresh() async {
    // FollowUser.instance.followUser('Abbey_Streich');
    setState(() {});
    await followApi().getFollowings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Following',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomFurure(
          isFollower: false,
          future: followApi().getFollowings(),
        ),
      ),
    );
  }
}
