import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/side_nav_bar.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/Trending/trending_list.dart';
import 'package:tweaxy/components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/components/HomePage/WebComponents/explore_web_screen.dart';
import 'package:tweaxy/components/HomePage/WebComponents/profile_component_web.dart';
import 'package:tweaxy/components/HomePage/WebComponents/search_bar_web.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/components/HomePage/trending_screen.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      profileID = prefs.getString('id')!;
      setState(() {});
    });
  }

  String profileID = '';
  String token = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(token);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.85,
          child: BlocProvider(
            create: (context) => SidebarCubit(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
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
                  child: BlocBuilder<SidebarCubit, SidebarState>(
                    builder: (context, state) {
                      if (state is SidebarInitialState ||
                          state is SidebarHomeState) {
                        return HomeTweets(tabController: widget.tabController);
                      } else if (state is SidebarProfileState)
                        return ProfileComponentWeb(
                          id: profileID,
                          text: '',
                        );
                      //TODO:- Provide The rest of the states
                      else if (state is SidebarExploreState) {
                        return const ExploreWebScreen();
                      } else if (state is OtherProfileState) {
                        return ProfileComponentWeb(
                          id: state.id,
                          text: state.text,
                        );
                      } else if (state is SearchUserLoadingState) {
                        return const Scaffold(
                          body: Center(
                            child: SpinKitRing(
                              color: Colors.blueAccent,
                            ),
                          ),
                        );
                      } else {
                        return const Placeholder();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.0009,
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SearchBarWeb(id: profileID, token: token),
                        TrendingList()
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTweets extends StatefulWidget {
  const HomeTweets({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<HomeTweets> createState() => _HomeTweetsState();
}

class _HomeTweetsState extends State<HomeTweets> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: const ContinuousRectangleBorder(
                side: BorderSide(
                    width: 0.2, color: Color.fromARGB(255, 135, 135, 135)),
              ),
              elevation: 0,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              pinned: true,
              title: CustomTabBar(
                isVisible: true,
                tabController: widget.tabController,
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                width: 0.03,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 135, 135, 135)
                    : const Color.fromARGB(255, 233, 233, 233)),
          ),
          child: HomePageBody(
            controller: controller,
            tabController: widget.tabController,
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
    return const PreferredSize(
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
