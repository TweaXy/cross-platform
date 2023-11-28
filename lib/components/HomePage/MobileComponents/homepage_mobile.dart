import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/appbar.dart';
import 'package:tweaxy/components/BottomNavBar/bottom_navigation_bar.dart';
import 'package:tweaxy/components/HomePage/MobileComponents/drawer_home_screen.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/side_nav_bar.dart';
import 'package:tweaxy/components/HomePage/WebComponents/homepage_web.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class HomePageMobile extends StatefulWidget {
  HomePageMobile({super.key, required this.tabController});
  TabController tabController;

  @override
  State<HomePageMobile> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePageMobile>
    with SingleTickerProviderStateMixin {
  var _isVisible = true;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool customDialRoot = true;
  bool rmIcons = false;

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
    return BlocProvider(
      create: (context) => SidebarCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        body: BlocBuilder<SidebarCubit, SidebarState>(
          builder: (context, state) {
            if (state is SidebarInitialState || state is SidebarHomeState)
              return HomeTweetsMobile(
                tabController: widget.tabController,
                controller: controller,
                isVisible: _isVisible,
              );
            else if (state is SidebarProfileState)
              return ProfileScreen();
            //TODO:- Provide The rest of the states
            else
              return Placeholder();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingButton(),
        bottomNavigationBar:
            Offstage(offstage: !_isVisible, child: BottomNaviagtion()),
        drawer: Drawer(
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
            SliverToBoxAdapter(
              child: Divider(
                height: 1,
                color: Color.fromARGB(255, 184, 189, 193),
              ),
            )
          ];
        },
        body: HomePageBody(
          tabController: tabController,
        ));
  }
}
