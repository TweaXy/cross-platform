import 'dart:async';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';

import 'package:tweaxy/services/blocking_user_service.dart';
import 'package:tweaxy/services/mute_user_service.dart';

import 'package:tweaxy/components/HomePage/SharedComponents/account_information.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/profile_icon_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/get_user_by_id.dart';
import 'package:tweaxy/views/loading_screen.dart';
import 'package:tweaxy/views/profile/edit_profile_screen.dart';
import 'package:tweaxy/components/Profile/profile_screen_body.dart';
import 'package:tweaxy/views/search_users/search_tweets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.id, required this.text});
  final String id;
  final String text;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController controller;

  String id = '';
  bool initialized = false;
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
    if (widget.text == '') {
      text = 'Edit Profile';
    } else {
      text = widget.text;
    }
    controller = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    controller.dispose();
  }

  String? profileID;
  int _selectedTabIndex = 0;
  String text = '';

  // bool initialized = false;
  @override
  Widget build(BuildContext context) {
    // return PopScope(
    //   onPopInvoked: (value) {},
    // child:
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
                    if (!initialized) {
                      initialized = true;

                      if (text != 'Edit Profile') {
                        text = user.followedByMe! ? 'Following' : 'Follow';
                      }
                    }
                    _isUserBlocked = user.blockedByMe!;

                    _isMuted = user.muted!;
                    return NestedScrollView(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
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
                                blockedMe: user.blockedMe ?? true,
                              ),
                            ),
                            user.blockedMe == true
                                ? SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'You are blocked from following @${user.userName} and viewing @${user.userName} posts',
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ),
                                  )
                                : SliverTabBar(
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
                                          text: 'Likes',
                                        )
                                      ],
                                    ),
                                  ),
                          ];
                        },
                        body: user.blockedMe!
                            ? const SizedBox()
                            : ProfileScreenBody(
                                tabController: _tabController,
                                id: id,
                                isMuted: _isMuted,
                                isUserBlocked: _isUserBlocked,
                              ));
                  }
                },
              );
            }
            return const Placeholder();
          },
        ),
      ),
      // ),
    );
  }
}

bool _isMuted = false;

class ProfileScreenAppBar extends SliverPersistentHeaderDelegate {
  ProfileScreenAppBar({
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

  bool initialized = false;
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    print(text);
    if (!initialized) {
      initialized = true;
    }
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
              user.blockedMe!
                  ? const SizedBox()
                  : FollowEditButton(
                      text: _isUserBlocked ? 'Blocked' : text,
                      user: user,
                      key: const ValueKey('followEditButton'), forProfile: true,
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
                    user.blockedMe!
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: ProfileIconButton(
                              borderWidth: 2,
                              icon: Icons.search,
                              iconColor: Colors.white,
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchTweets(
                                          username: user.userName!,
                                          id: user.id!)),
                                );
                              },
                            ),
                          ),
                    text == 'Edit Profile'
                        ? const SizedBox()
                        : PopupMenuButton(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                                border:
                                    Border.all(color: Colors.black26, width: 1),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 0,
                                child: Text(_isMuted ? 'Unmute' : 'Mute'),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child:
                                    Text(_isUserBlocked ? 'Unblock' : 'Block'),
                              ),
                            ],
                            onSelected: (value) async {
                              if (value == 0) {
                                if (!_isMuted) {
                                  var flag = await MuteUserService.mute(
                                      username: user.userName!);
                                  if (flag) {
                                    muteAnimatedSnackBar(
                                      failure: false,
                                      icon: Icons.volume_off_outlined,
                                      muteFlag: true,
                                      mainContext: context,
                                      userName: user.userName!,
                                    ).show(context);
                                    _isMuted = true;
                                  } else {
                                    muteAnimatedSnackBar(
                                            failure: true, muteFlag: false)
                                        .show(context);
                                  }
                                } else {
                                  var flag = await MuteUserService.unMuteUser(
                                      username: user.userName!);
                                  if (flag) {
                                    muteAnimatedSnackBar(
                                      failure: false,
                                      icon: Icons.volume_mute_outlined,
                                      muteFlag: false,
                                      mainContext: context,
                                      userName: user.userName!,
                                    ).show(context);
                                    _isMuted = false;
                                  } else {
                                    muteAnimatedSnackBar(
                                            failure: true, muteFlag: false)
                                        .show(context);
                                  }
                                }
                                BlocProvider.of<EditProfileCubit>(context)
                                    .emit(ProfilePageLoadingState());
                                BlocProvider.of<EditProfileCubit>(context)
                                    .emit(ProfilePageCompletedState());
                              } else {
                                if (_isUserBlocked) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => UnblockUserDialog(
                                        username: user.userName!),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => BlockUserDialog(
                                        username: user.userName!),
                                  );
                                }
                              }
                            },
                          ),
                    // ProfileIconButton(
                    //   borderWidth: 2,
                    //   icon: Icons.more_vert,
                    //   onPressed: () {},
                    //   iconColor: Colors.white,
                    //   color: Colors.black,
                    // ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  AnimatedSnackBar muteAnimatedSnackBar(
      {IconData? icon,
      bool muteFlag = true,
      BuildContext? mainContext,
      bool failure = false,
      String userName = ''}) {
    String titleText = '';
    Color iconColor = Colors.blue[700]!;
    if (muteFlag) {
      titleText = 'You muted @$userName';
    } else {
      titleText = 'You unmuted @$userName';
    }
    return AnimatedSnackBar(
      mobileSnackBarPosition: MobileSnackBarPosition.top,
      mobilePositionSettings: const MobilePositionSettings(
        left: 5,
        right: 5,
      ),
      duration: const Duration(seconds: 3),
      builder: ((context) {
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: failure ? Colors.red[100] : Colors.blue[100],
              border: Border.all(
                color: Colors.blue[700]!,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: double.infinity,
          child: ListTile(
            title: Text(
              failure ? 'Oops There\'s an error' : titleText,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: Icon(
              failure ? Icons.close : icon,
              color: failure ? Colors.red : Colors.blue[700],
            ),
            subtitle: muteFlag
                ? ElevatedButton(
                    onPressed: () {
                      muteAnimatedSnackBar(
                        failure: false,
                        icon: Icons.volume_off_outlined,
                        muteFlag: false,
                        mainContext: context,
                        userName: user.userName!,
                      ).show(context);
                      _isMuted = false;
                    },
                    child: const Text('Undo'))
                : null,
          ),
        );
      }),
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
    required this.forProfile,
  });

  final String text;
  final User user;
  final bool forProfile;
  @override
  State<FollowEditButton> createState() => _FollowEditButtonState();
}

class _FollowEditButtonState extends State<FollowEditButton> {
  String? text;
  @override
  Widget build(BuildContext context) {
    text = text ?? widget.text;
    return BlocProvider(
      create: (context) => UpdateAllCubit(),
      child: Row(
        children: [
          text == 'Following' && widget.forProfile
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
              BlocProvider.of<UpdateAllCubit>(context).emit(LoadingStata());
              if (text == 'Follow' || text == 'Follow back') {
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
              } else if (text == 'Blocked') {
                showDialog(
                    context: context,
                    builder: (context) =>
                        UnblockUserDialog(username: widget.user.userName!));
                return;
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    user: widget.user,
                  ),
                ));
              }
              BlocProvider.of<UpdateAllCubit>(context)
                  .emit(UpdataAllinitialState());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  text == 'Follow' || text == 'Follow back'
                      ? Colors.black
                      : Colors.white),
              minimumSize: const MaterialStatePropertyAll<Size>(Size(90, 35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(
                      color: text == 'Blocked'
                          ? Colors.redAccent[700]!
                          : Colors.grey),
                ),
              ),
            ),
            child: Text(
              text!,
              style: TextStyle(
                color: text == 'Blocked'
                    ? Colors.red[800]
                    : text == 'Follow' || text == 'Follow back'
                        ? Colors.white
                        : Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UnblockUserDialog extends StatefulWidget {
  const UnblockUserDialog({super.key, required this.username});
  final String username;

  @override
  State<UnblockUserDialog> createState() => _UnblockUserDialogState();
}

bool _isUserBlocked = false;

class _UnblockUserDialogState extends State<UnblockUserDialog> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Unblock @${widget.username}?'),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      content:
          const Text('They will be able to follow you and view your posts.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        _isLoading
            ? const ProfileDialogLoading()
            : TextButton(
                onPressed: () async {
                  BlocProvider.of<EditProfileCubit>(context)
                      .emit(ProfilePageLoadingState());
                  setState(() {
                    _isLoading = true;
                  });

                  bool flag = await BlockingUserService.unBlockUser(
                      username: widget.username);
                  setState(() {
                    _isLoading = true;
                  });
                  if (flag) {
                    Fluttertoast.showToast(
                      msg: 'You unblocked @${widget.username}',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    _isUserBlocked = false;
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Oops There\'s an error',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  }
                  BlocProvider.of<EditProfileCubit>(context)
                      .emit(ProfilePageCompletedState());
                  Navigator.pop(context);
                },
                child: const Text(
                  'Unblock',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
      ],
    );
  }
}

class ProfileDialogLoading extends StatelessWidget {
  const ProfileDialogLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 40,
        height: 40,
        child: SpinKitRing(
          color: Colors.blueAccent,
          size: 40,
          lineWidth: 5,
        ),
      ),
    );
  }
}

class BlockUserDialog extends StatefulWidget {
  const BlockUserDialog({super.key, required this.username});
  final String username;

  @override
  State<BlockUserDialog> createState() => _BlockUserDialogState();
}

class _BlockUserDialogState extends State<BlockUserDialog> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Block @${widget.username}?'),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      content: Text(
          '@${widget.username} will no longer be able to follow or message you, and you will not see notifications from @${widget.username}'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        _isLoading
            ? const ProfileDialogLoading()
            : TextButton(
                onPressed: () async {
                  BlocProvider.of<EditProfileCubit>(context)
                      .emit(ProfilePageLoadingState());
                  setState(() {
                    _isLoading = true;
                  });

                  bool flag = await BlockingUserService.blockUser(
                      username: widget.username);
                  setState(() {
                    _isLoading = true;
                  });
                  if (flag) {
                    Fluttertoast.showToast(
                      msg: 'You Blocked @${widget.username}',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    _isUserBlocked = true;
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Oops There\'s an error',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  }
                  BlocProvider.of<EditProfileCubit>(context)
                      .emit(ProfilePageCompletedState());
                  Navigator.pop(context);
                },
                child: const Text(
                  'Block',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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

// void _save() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('id', 'clpj7l5wq00033h9kml3a9vkp');
//   await prefs.setString('token',
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwajdsNXdxMDAwMzNoOWttbDNhOXZrcFwiIiwiaWF0IjoxNzAxMjI4NjA2LCJleHAiOjE3MDM4MjA2MDZ9.qrToCvvaZTBWK1yn-fFlYE9zkU2ZsYwA3PiW1uVFvCo');
// }

// void _clear() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.clear();
// }
