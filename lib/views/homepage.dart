import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: IconButton(
                  onPressed: () {
                    //refresh
                  },
                  icon: Container(
                    color: Colors.transparent,
                    // Set the desired height
                    child: Transform.scale(
                      scale: 2.0,
                      child: ImageIcon(
                        AssetImage('assets/logo2.ico'),
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    //swipe left
                  },
                  icon: Icon(
                    FontAwesomeIcons.user,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xff2a91d6),
                  indicatorWeight: 4,
                  indicatorPadding: EdgeInsets.only(bottom: 1.0),
                  tabs: !_isVisible
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
                                color: _tabController.index == 0
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
                              color: _tabController.index == 1
                                  ? Colors.black
                                  : Color(0xff56595c),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                        ],
                ),
              ),
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