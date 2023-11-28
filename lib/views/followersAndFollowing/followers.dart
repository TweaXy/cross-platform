import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  Future<void> _refresh() async {
    await followApi().getFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Followers',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Notification Setteing'),
                value: 'Notification Setteing',
              ),
            ],
            onSelected: (value) {
              print('Selected: $value');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomFurure(
          isFollower: true,
          future: followApi().getFollowings(),
        ),
      ),
    );
  }
}
