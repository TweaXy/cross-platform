import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/MobileComponents/homepage_mobile.dart';
import 'package:tweaxy/components/HomePage/WebComponents/homepage_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: kIsWeb
          ? HomePageWeb(
              tabController: _tabController,
            )
          : HomePageMobile(
              tabController: _tabController,
            ),
    );
  }
}
