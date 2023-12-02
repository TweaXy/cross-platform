import 'package:flutter/material.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({required this.username});
  String username;
  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  late ScrollController controller;

  Future<void> _refresh() async {
    setState(() {});

    await followApi()
        .getFollowings(scroll: controller, username: widget.username);
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
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
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomFurure(
            controller: controller,
            isFollower: false,
            future: followApi()
                .getFollowings(scroll: controller, username: widget.username),
          ),
        ),
      ),
    );
  }
}
