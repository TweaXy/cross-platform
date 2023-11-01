import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/side_nav_Bar.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/Trending/trending.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/Trending/trending_list.dart';
import 'package:tweaxy/components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/models/trending_model.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.topRight,
                  child: SideNavBar(),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Expanded(
                flex: 8,
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    physics: const BouncingScrollPhysics(),
                    floatHeaderSlivers: true,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          elevation: 0,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                          pinned: true,
                          title: CustomTabBar(
                            isVisible: true,
                            tabController: tabController,
                          ),
                        ),
                      ];
                    },
                    body: HomePageBody(
                      tabController: tabController,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.0009,
              ),
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [TrendingList()],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPostHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50), // Adjust the height as needed
      child: AddPost(),
    );
  }

  @override
  double get maxExtent => 50; // Adjust the height as needed

  @override
  double get minExtent => 0; // Adjust the height as needed

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
