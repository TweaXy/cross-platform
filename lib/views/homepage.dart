import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/appbar.dart';
import 'package:tweaxy/components/BottomNavBar/bottom_navigation_bar.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _isVisible = true;

  late ScrollController controller;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    _tabController = TabController(vsync: this, length: 2);
    controller.addListener(() {
      setState(() {
        _isVisible =
            controller.position.userScrollDirection == ScrollDirection.forward;
      });
    });
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ApplicationBar(
                  isVisible: _isVisible, tabController: _tabController),
              SliverToBoxAdapter(
                child: Divider(
                  height: 1,
                  color: Color.fromARGB(255, 184, 189, 193),
                ),
              )
            ];
          },
          body: HomePageBody(
            tabController: _tabController,
          )),
      floatingActionButton: FloatingButton(),
      bottomNavigationBar:
          Offstage(offstage: !_isVisible, child: BottomNaviagtion()),
    );
  }
}
