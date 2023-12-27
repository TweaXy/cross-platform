import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tweaxy/components/AppBar/tabbar.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';

class ApplicationBar extends StatefulWidget {
  const ApplicationBar(
      {super.key, required this.isVisible, required this.tabController});
  final bool isVisible;

  final TabController tabController;

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();
}

class _ApplicationBarState extends State<ApplicationBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: IconButton(
        key: const ValueKey(HomePageKeys.iconRefreshAppBar),
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
          onTap: () async {
            await TempUser.userSetData(context, refresh: false);
            setState(() {});
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
        isVisible: widget.isVisible,
        tabController: widget.tabController,
      ),
    );
  }
}
