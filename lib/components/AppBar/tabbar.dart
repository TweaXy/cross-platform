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
    Brightness brightness = Theme.of(context).brightness;
    Color selectedTextColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    Color unselectedTextColor =
        brightness == Brightness.light ? Color(0xff56595c) : Color(0xff56595c);

    return TabBar(
      controller: tabController,
      isScrollable: false,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.white,
      indicatorWeight: 4,
      indicatorPadding: EdgeInsets.only(bottom: 1.0),
      tabs: !isVisible
          ? [
              Tab(
                child: Container(
                  color: Colors.transparent,
                  height: 0,
                  width: 0,
                ),
              ),
            ]
          : [
              Tab(
                child: Text(
                  "ALL",
                  style: TextStyle(
                    color: tabController.index == 1
                        ? selectedTextColor
                        : unselectedTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
    );
  }
}
