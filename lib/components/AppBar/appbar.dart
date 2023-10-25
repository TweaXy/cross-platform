import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';

class ApplicationBar extends StatelessWidget {
  const ApplicationBar(
      {super.key, required this.isVisible, required this.tabController});
  final bool isVisible;

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
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
      bottom: CustomTabBar(
        isVisible: isVisible,
        tabController: tabController,
      ),
    );
  }
}
