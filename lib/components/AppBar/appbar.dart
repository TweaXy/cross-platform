import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';

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
        key: new ValueKey(HomePageKeys.iconRefreshAppBar),
        onPressed: () {
          //refresh
          BlocProvider.of<TweetsUpdateCubit>(context).refresh();
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
          Scaffold.of(context).openDrawer();
          //swipe left
        },
        icon: Icon(
          key: new ValueKey(HomePageKeys.userIconAppBar),
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
