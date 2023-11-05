import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/appbar.dart';
import 'package:tweaxy/components/BottomNavBar/bottom_navigation_bar.dart';
import 'package:tweaxy/components/HomePage/WebComponents/homepage_web.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';

class HomePageMobile extends StatefulWidget {
  HomePageMobile({super.key, required this.tabController});
  TabController tabController;

  @override
  State<HomePageMobile> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePageMobile>
    with SingleTickerProviderStateMixin {
  var _isVisible = true;

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
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ApplicationBar(
                  isVisible: _isVisible, tabController: widget.tabController),
              SliverToBoxAdapter(
                child: Divider(
                  height: 1,
                  color: Color.fromARGB(255, 184, 189, 193),
                ),
              )
            ];
          },
          body: HomePageBody(
            tabController: widget.tabController,
          )),
      floatingActionButton: FloatingButton(),
      bottomNavigationBar:
          Offstage(offstage: !_isVisible, child: BottomNaviagtion()),
    );
  }
}
