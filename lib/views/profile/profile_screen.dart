import 'dart:async';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/account_information.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/profile_icon_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/get_user_by_id.dart';
import 'package:tweaxy/services/unfollow_user.dart';
import 'package:tweaxy/views/loading_screen.dart';
import 'package:tweaxy/views/profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.id, required this.text});
  final String id;
  final String text;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

List<String> listitems = [
  'item1',
  'item2',
  'item3',
  'item4',
  'item5',
  'item6',
  'item7',
  'item8',
  'item9',
  'item10',
  'item11',
  'item12',
  'item13',
  'item14',
  'item15',
  'item16',
  'item17',
  'item18',
  'item19',
  'item20',
];

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != '')
      id = widget.id;
    else {
      Future(() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        id = prefs.getString('id')!;
        setState(() {});
      });
    }
    if (widget.text == '')
      text = 'Edit Profile';
    else
      text = widget.text;

    _tabController = TabController(length: 3, vsync: this);
  }

  String? profileID;
  int _selectedTabIndex = 0;
  String text = '';
  // bool initialized = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is ProfilePageLoadingState) {
              return const LoadingScreen(asyncCall: true);
            } else if (state is ProfilePageInitialState ||
                state is ProfilePageCompletedState) {
              return FutureBuilder(
                future: GetUserById.instance.getUserById(id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LoadingScreen(
                      asyncCall: true,
                    );
                  } else {
                    User user = snapshot.data!;
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: ProfileScreenAppBar(
                            text: text,
                            user: user,
                            postsNumber: 216820,
                            avatarURL: user.avatar ?? '',
                            coverURL: user.cover ?? '',
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: AccountInformation(
                            website: user.website ?? '',
                            birthDate: user.birthdayDate ?? '',
                            bio: user.bio ?? '',
                            followers: user.followers ?? 0,
                            following: user.following ?? 0,
                            joinedDate: user.joinedDate ?? '',
                            location: user.location ?? '',
                            profileName: user.name ?? '',
                            userName: user.userName ?? '',
                          ),
                        ),
                        SliverTabBar(
                          expandedHeight: 0,
                          backgroundColor: Colors.white,
                          tabBar: TabBar(
                            indicatorWeight: 3,
                            indicatorColor: Colors.blue,
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _tabController,
                            labelColor: Colors.black,
                            onTap: (value) => setState(() {
                              _selectedTabIndex = value;
                            }),
                            tabs: const [
                              Tab(
                                text: 'Posts',
                              ),
                              Tab(
                                text: 'Replies',
                              ),
                              Tab(
                                text: 'Likes',
                              )
                            ],
                          ),
                        ),
                        SliverList.builder(
                          itemCount: listitems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListTile(
                                  title: Text(listitems[index].toString() +
                                      _selectedTabIndex.toString()),
                                  tileColor: Colors.white,
                                ));
                          },
                        ),
                      ],
                    );
                  }
                },
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}

class ProfileScreenAppBar extends SliverPersistentHeaderDelegate {
  const ProfileScreenAppBar({
    required this.user,
    required this.postsNumber,
    required this.avatarURL,
    required this.coverURL,
    required this.text,
  });
  final User user;
  final String text;
  final String avatarURL;
  final String coverURL;
  final int postsNumber;
  final bottomHeight = 60;
  final extraRadius = 5;
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final imageTop =
        -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);

    final double clowsingRate = (shrinkOffset == 0
            ? 0.0
            : (shrinkOffset / (maxExtent - minExtent - bottomHeight)))
        .clamp(0, 1);

    final double opacity = shrinkOffset == minExtent
        ? 0
        : 1 - (shrinkOffset.clamp(minExtent, minExtent + 30) - minExtent) / 30;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 20,
          left: 45,
          child: Row(
            children: [
              Transform.scale(
                scale: 1.9 - clowsingRate,
                alignment: Alignment.bottomCenter,
                child: _Avatar(
                  url: basePhotosURL + avatarURL,
                ),
              ),
              const Spacer(),
              FollowEditButton(
                text: text,
                user: user,
                key: const ValueKey('followEditButton'),
              ),
            ],
          ),
        ),
        _banner(
            imageTop: imageTop,
            clowsingRate: clowsingRate,
            bottomHeight: bottomHeight,
            extraRadius: extraRadius,
            maxExtent: maxExtent,
            opacity: opacity,
            bannerURL: basePhotosURL + coverURL),
        Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Row(
                  children: [
                    ProfileIconButton(
                      borderWidth: 2,
                      icon: Icons.arrow_back,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconColor: Colors.white,
                      color: Colors.black,
                    ),
                    clowsingRate == 1
                        ? CollapsedAppBarText(
                            profileNameTextColor: Colors.white,
                            postsNumberTextColor: Colors.white,
                            postsNumberTextStyle: FontWeight.bold,
                            postsNumber: postsNumber,
                            postsNumberTextSize: 16,
                            profileNameTextSize: 16,
                            profileName: user.name!,
                          )
                        : const SizedBox(),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ProfileIconButton(
                        borderWidth: 2,
                        icon: Icons.search,
                        iconColor: Colors.white,
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ),
                    ProfileIconButton(
                      borderWidth: 2,
                      icon: Icons.more_vert,
                      onPressed: () {},
                      iconColor: Colors.white,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class CollapsedAppBarText extends StatelessWidget {
  const CollapsedAppBarText({
    super.key,
    required this.profileName,
    required this.postsNumber,
    required this.profileNameTextSize,
    required this.postsNumberTextSize,
    required this.profileNameTextColor,
    required this.postsNumberTextColor,
    required this.postsNumberTextStyle,
  });
  final String profileName;
  final int postsNumber;
  final double profileNameTextSize;
  final double postsNumberTextSize;
  final Color profileNameTextColor;
  final Color postsNumberTextColor;
  final FontWeight postsNumberTextStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profileName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: profileNameTextSize,
                color: profileNameTextColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '${NumberFormat.compact().format(postsNumber)} Posts',
              style: TextStyle(
                  fontWeight: postsNumberTextStyle,
                  fontSize: postsNumberTextSize,
                  color: postsNumberTextColor),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowEditButton extends StatefulWidget {
  const FollowEditButton({
    super.key,
    required this.text,
    required this.user,
  });

  final String text;
  final User user;

  @override
  State<FollowEditButton> createState() => _FollowEditButtonState();
}

class _FollowEditButtonState extends State<FollowEditButton> {
  String? text;
  @override
  Widget build(BuildContext context) {
    text = text ?? widget.text;
    return Row(
      children: [
        text == 'Following'
            ? Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ProfileIconButton(
                  borderWidth: 2,
                  icon: Icons.notification_add_outlined,
                  onPressed: () {
                    //TODO: Implement mute notification
                  },
                  color: Colors.white,
                  iconColor: Colors.black,
                ),
              )
            : const SizedBox(),
        ElevatedButton(
          onPressed: () async {
            if (text == 'Follow') {
              //TODO :- Implement the follow logic
              await FollowUser.instance.followUser(widget.user.userName!);
              setState(() {
                text = 'Following';
              });
            } else if (text == 'Following') {
              //TODO :- Implement the unfollow logic
              await FollowUser.instance.deleteUser(widget.user.userName!);
              setState(() {
                text = 'Follow';
              });
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  user: widget.user,
                ),
              ));
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                text == 'Follow' ? Colors.black : Colors.white),
            minimumSize: const MaterialStatePropertyAll<Size>(Size(90, 35)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          child: Text(
            text!,
            style: TextStyle(
              color: text == 'Follow' ? Colors.white : Colors.black,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}

class _banner extends StatelessWidget {
  const _banner({
    required this.imageTop,
    required this.clowsingRate,
    required this.bottomHeight,
    required this.extraRadius,
    required this.maxExtent,
    required this.opacity,
    required this.bannerURL,
  });

  final double imageTop;
  final double clowsingRate;
  final int bottomHeight;
  final int extraRadius;
  final double maxExtent;
  final double opacity;
  final String bannerURL;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: imageTop,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: InvertedCircleClipper(
          radius: (1.9 - clowsingRate) * bottomHeight / 2 + extraRadius,
          offset: Offset(
            bottomHeight / 2 + 45,
            (maxExtent - bottomHeight + extraRadius / 2) +
                clowsingRate * bottomHeight / 2,
          ),
        ),
        child: SizedBox(
          height: maxExtent - bottomHeight,
          child: ColoredBox(
            color: Colors.white,
            child: Blur(
              blur: 15 * clowsingRate,
              blurColor: Colors.black,
              colorOpacity: clowsingRate / 3,
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: bannerURL == basePhotosURL
                      ? kDefaultBannerPhoto
                      : bannerURL,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 5,
                        )),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: const Text(
        'Follow',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  const InvertedCircleClipper({
    required this.offset,
    required this.radius,
  });
  final Offset offset;
  final double radius;

  @override
  Path getClip(size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: offset,
        radius: radius,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url});
  final url;

  @override
  Widget build(BuildContext context) {
    print(url);
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => const Center(
            child: SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 5,
                )),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

void _save() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', 'clpj7l5wq00033h9kml3a9vkp');
  await prefs.setString('token',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwajdsNXdxMDAwMzNoOWttbDNhOXZrcFwiIiwiaWF0IjoxNzAxMjI4NjA2LCJleHAiOjE3MDM4MjA2MDZ9.qrToCvvaZTBWK1yn-fFlYE9zkU2ZsYwA3PiW1uVFvCo');
}
