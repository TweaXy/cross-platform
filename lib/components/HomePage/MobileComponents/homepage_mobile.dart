import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/AppBar/appbar.dart';
import 'package:tweaxy/components/BottomNavBar/bottom_navigation_bar.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';
import 'package:tweaxy/components/HomePage/MobileComponents/drawer_home_screen.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/views/trends/trending_screen.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';

class HomePageMobile extends StatefulWidget {
  HomePageMobile({super.key, required this.tabController});
  TabController tabController;

  @override
  State<HomePageMobile> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePageMobile>
    with SingleTickerProviderStateMixin {
  var _isVisible = true;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      setState(() {
        _isVisible =
            controller.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      HomeTweetsMobile(
        tabController: widget.tabController,
        controller: controller,
        isVisible: _isVisible,
      ),
      TrendingScreen(),
    ];
    return BlocProvider(
      create: (context) => SidebarCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        body: BlocBuilder<SidebarCubit, SidebarState>(
          builder: (context, state) {
            if (state is SidebarInitialState || state is SidebarHomeState) {
              return widgets[_selectedIndex];
            } else if (state is SidebarProfileState)
              return ProfileScreen(
                id: '',
                text: '',
              );
            //TODO:- Provide The rest of the states
            else
              return const Placeholder();
          },
        ),
        floatingActionButton: const FloatingButton(),
        bottomNavigationBar: Offstage(
          offstage: !_isVisible,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 138, 138, 138),
                width: 0.4,
              ),
            )),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,

              items: <BottomNavigationBarItem>[
                //home icon
                BottomNavigationBarItem(
                  icon: HomeIcon(
                    selectedIndex: _selectedIndex,
                  ),
                  label: '',
                ),
                //search icon
                BottomNavigationBarItem(
                    icon: SearchIcon(
                      key: new ValueKey(HomePageKeys.navSearchIcon),
                      selectedIndex: _selectedIndex,
                    ),
                    label: ''),
                //notification icon
                BottomNavigationBarItem(
                  icon: NotificationIcon(
                    selectedIndex: _selectedIndex,
                  ),
                  label: '',
                ),
                //message icon
                BottomNavigationBarItem(
                    icon: MessageIcon(selectedIndex: _selectedIndex),
                    label: ''),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped, // Handle item selection

              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        ),
        drawer: const Drawer(
            child: CustomDrawer() // Populate the Drawer in the next step.
            ),
      ),
    );
  }
}

class HomeTweetsMobile extends StatelessWidget {
  const HomeTweetsMobile(
      {super.key,
      required this.controller,
      required this.tabController,
      required this.isVisible});
  final ScrollController controller;
  final TabController tabController;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ApplicationBar(isVisible: isVisible, tabController: tabController),
            const SliverToBoxAdapter(
              child: Divider(
                height: 1,
                color: Color.fromARGB(255, 184, 189, 193),
              ),
            )
          ];
        },
        body: CustomScrollView(slivers: [
          HomePageBody(
          ),
        ]));
  }
}
