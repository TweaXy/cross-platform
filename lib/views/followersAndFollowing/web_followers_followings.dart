import 'package:flutter/material.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class WebFollowersAndFollowings extends StatefulWidget {
  WebFollowersAndFollowings({Key? key}) : super(key: key);

  @override
  State<WebFollowersAndFollowings> createState() =>
      _WebFollowersAndFollowingsState();
}

class _WebFollowersAndFollowingsState extends State<WebFollowersAndFollowings>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Future<void> _refresh1() async {
    await followApi().getFollowers();
  }

  Future<void> _refresh2() async {
    await followApi().getFollowings();
  }

  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);

    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
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
        title: Column(
          children: [
            Text(
              'KareemKaokab',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              '@KareemKaokab',
              style: TextStyle(
                color: Color(0xffADB5BC),
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: TabBar(
          controller: tabController,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.blue,
          indicatorWeight: 4,
          indicatorPadding: EdgeInsets.only(bottom: 1.0),
          tabs: [
            Tab(
              child: Text(
                "Followers",
                style: TextStyle(
                  color: tabController.index == 0
                      ? Colors.black
                      : Color(0xffADB5BC),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Following",
                style: TextStyle(
                  color: tabController.index == 1
                      ? Colors.black
                      : Color(0xffADB5BC),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CustomFurure(
            isFollower: true,
            future: followApi().getFollowers(),
          ),
          CustomFurure(
            isFollower: false,
            future: followApi().getFollowings(),
          ),
        ],
      ),
    );
  }
}
