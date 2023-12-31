import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/replies_screen.dart';
import 'package:tweaxy/views/chat/web/get_conversations_web_view.dart';
import 'package:tweaxy/views/followersAndFollowing/web_followers_followings.dart';
import 'package:tweaxy/views/notifications/notification_screen.dart';
import 'package:tweaxy/views/settings/web/settings_and_privacy_web_view.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/side_nav_bar.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/Trending/trending_list.dart';
import 'package:tweaxy/components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/components/HomePage/WebComponents/explore_web_screen.dart';
import 'package:tweaxy/components/HomePage/WebComponents/profile_component_web.dart';
import 'package:tweaxy/components/HomePage/WebComponents/search_bar_web.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
                BlocBuilder<SidebarCubit, SidebarState>(
                  builder: (context, state) {
                    if (state is SidebarInitialState ||
                        state is SidebarHomeState) {
                      return Expanded(
                          flex: 8,
                          child:
                              HomeTweets(tabController: widget.tabController));
                    } else if (state is SidebarProfileState) {
                      return Expanded(
                          flex: 8,
                          child: ProfileComponentWeb(
                            id: profileID,
                            text: '',
                          ));
                    } else if (state is SidebarSettingsState) {
                      return const Expanded(
                          flex: 13, child: SettingsAndPrivacyWeb());
                    } else if (state is SidebarExploreState) {
                      return const Expanded(flex: 8, child: ExploreWebScreen());
                    } else if (state is OtherProfileState) {
                      return Expanded(
                          flex: 8,
                          child: ProfileComponentWeb(
                            id: state.id,
                            text: state.text,
                          ));
                    } else if (state is OpenRepliesState) {
                      return Expanded(
                        flex: 8,
                        child: RepliesScreen(
                            tweetid: state.tweetid,
                            replyto: state.replyto,
                            userHandle: state.userHandle,
                            isARepost: false,
                            reposteruserName: ''),
                      );
                    } else if (state is SearchUserLoadingState) {
                      return const Scaffold(
                        body: Center(
                          child: SpinKitRing(
                            color: Colors.blueAccent,
                          ),
                        ),
                      );
                    } else if (state is SidebarNotificationState) {
                      return const Expanded(
                          flex: 8, child: NotificationScreen());
                    } else if (state is SidebarMessageState) {
                      return const Expanded(
                          flex: 13, child: GetConversationsWebView());
                    } else if (state is FollowingFollowerListState) {
                      return Expanded(
                        flex: 8,
                        child: WebFollowersAndFollowings(
                          username: state.username,
                          name: state.name,
                        ),
                      );
                    } else {
                      return const Placeholder();
                    }
                  },
                ),
                SizedBox(
                  width: screenWidth * 0.0009,
                ),
                BlocBuilder<SidebarCubit, SidebarState>(
                  builder: (context, state) {
                    if (state is SidebarHomeState ||
                        state is SidebarInitialState) {
                      return Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              SearchBarWeb(id: profileID, token: token),
                              const TrendingList()
                            ],
                          ));
                    } else if (state is SidebarExploreState) {
                      return const Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 0,
                            width: 0,
                          ));
                    }
                    if (state is SidebarSettingsState ||
                        state is SidebarMessageState) {
                      return const Expanded(
                          flex: 0,
                          child: SizedBox(
                            width: 0,
                            height: 0,
                          ));
                    } else {
                      return const Expanded(
                          flex: 5,
                          child: Column(
                            children: [TrendingList()],
                          ));
                    }
                  },
                )
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
            child:
                TabBarView(controller: widget.tabController, children: <Widget>[
              CustomScrollView(
                  scrollBehavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  slivers: [
                    SliverToBoxAdapter(
                      child: isweb(),
                    ),
                    const HomePageBody()
                  ]),
            ])),
      ),
    );
  }
}

Widget isweb() {
  if (kIsWeb) {
    return const AddPost();
  } else {
    return const SizedBox(
      height: 0,
      width: 0,
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
