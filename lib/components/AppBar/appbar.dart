import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/constants.dart';

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
            scale: 1.5,
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
         Navigator.pushNamed(context, kProfileScreen);
        },
        icon: Icon(
          FontAwesomeIcons.user,
          size: 25,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      bottom: CustomTabBar(
        isVisible: isVisible,
        tabController: tabController,
      ),
    );
  }
}
