import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
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
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage:
                CachedNetworkImageProvider(basePhotosURL + TempUser.image),
          ),
        ),
      ),
      bottom: CustomTabBar(
        isVisible: isVisible,
        tabController: tabController,
      ),
    );
  }
}
