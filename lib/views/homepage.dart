import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/appBar.dart';
import 'package:tweaxy/components/BottomNavBar/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: IconButton(
                onPressed: () {
                  //refresh
                },
                icon: Icon(
                  FontAwesomeIcons.xTwitter,
                  size: 30,
                  color: Colors.black,
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
            ),
            SliverToBoxAdapter(child: ApplicationBar()),

            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 900,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
        floatingActionButton: Theme(
          data: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              splashColor: Color.fromARGB(255, 156, 203, 250),
              highlightElevation: 0,
            ),
          ),
          child: Transform.scale(
            scale: 1.2, // Adjust the scale factor to increase the size
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          ),
        ),
        bottomNavigationBar:
            Offstage(offstage: !_isVisible, child: BottomNaviagtion()),
      ),
    );
  }
}
