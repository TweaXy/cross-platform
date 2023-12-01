import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class FollowersPage extends StatefulWidget {
  FollowersPage({super.key, required this.username});
  String username;
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  late ScrollController controller;

  Future<void> _refresh() async {
    setState(() {});

    await followApi()
        .getFollowers(scroll: controller, username: widget.username);
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
          'Followers',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Notification Setteing',
                child: Text('Notification Setteing'),
              ),
            ],
            onSelected: (value) {
              print('Selected: $value');
            },
          ),
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
            isFollower: true,
            future: followApi()
                .getFollowers(scroll: controller, username: widget.username),
          ),
        ),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}
