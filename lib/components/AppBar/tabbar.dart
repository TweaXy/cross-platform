import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar(
      {super.key, required this.isVisible, required this.tabController});
  final bool isVisible;

  final TabController tabController;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: false,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Color(0xff2a91d6),
      indicatorWeight: 4,
      indicatorPadding: EdgeInsets.only(bottom: 1.0),
      tabs: !isVisible
          ? [
              Tab(
                  child: Container(
                color: Colors.transparent,
                height: 0,
                width: 0,
              )),
              Tab(
                  child: Container(
                color: Colors.transparent,
                height: 0,
                width: 0,
              )),
            ]
          : [
              Tab(
                child: Text(
                  'For you',
                  style: TextStyle(
                    color: tabController.index == 0
                        ? Colors.black
                        : Color(0xff56595c),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Tab(
                  child: Text(
                'Following',
                style: TextStyle(
                  color: tabController.index == 1
                      ? Colors.black
                      : Color(0xff56595c),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
            ],
    );
  }
}
