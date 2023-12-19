import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/models/user_notification.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/get_all_notifications.dart';
import 'package:tweaxy/services/get_mentioned_tweets.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const _pageSize = 20;
  final PagingController<int, Tweet> _mentionsPagingController =
      PagingController(firstPageKey: 0);
  final PagingController<int, UserNotification> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _mentionsPagingController.addPageRequestListener((pageKey) {
      _fetchMentionPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await GetAllNotifications.getAllNotifications(
          _pageSize, pageKey, TempUser.token);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _fetchMentionPage(int pageKey) async {
    try {
      final newItems = await GetMentionedTweets.getMentionedTweets(
        TempUser.id,
        pageSize: _pageSize,
        offset: pageKey,
        token: TempUser.token,
      );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _mentionsPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _mentionsPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              floating: kIsWeb ? false : true,
              pinned: true,
              bottom: const TabBar(
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 50),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
                isScrollable: false,
                tabs: <Widget>[
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Mentions',
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              leading: kIsWeb
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, kProfileScreen);
                          Scaffold.of(context).openDrawer();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: CachedNetworkImageProvider(
                              basePhotosURL + TempUser.image),
                        ),
                      ),
                    ),
              titleSpacing: 10,
              title: const Text('Notifications'),
              centerTitle: kIsWeb ? false : true,
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ];
        },
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () async {
                return _pagingController.refresh();
              },
              child: BlocProvider(
                create: (context) => SidebarCubit(),
                child: PagedListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<UserNotification>(
                    noItemsFoundIndicatorBuilder: (context) => const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'There Are No Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Any new notification will appear here',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return AllNotificationsListTile(
                        notificationType: item.action!,
                        avatarURL: item.avatar!,
                        name: item.name!,
                        tweet: item.interaction == null
                            ? ''
                            : item.interaction!.text ?? '',
                        followStatus: 'Follow back',
                        userId: item.userId!,
                        username: item.userName!,
                      );
                    },
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                return _mentionsPagingController.refresh();
              },
              child: PagedListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
                pagingController: _mentionsPagingController,
                builderDelegate: PagedChildBuilderDelegate<Tweet>(
                  noItemsFoundIndicatorBuilder: (context) => const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'There Are No Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Any mention notification on post will appear here',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  animateTransitions: true,
                  itemBuilder: (context, item, index) {
                    return CustomTweet(
                        tweet: item, replyto: const [], isMuted: false,);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllNotificationsListTile extends StatefulWidget {
  const AllNotificationsListTile({
    super.key,
    required this.notificationType,
    required this.avatarURL,
    required this.name,
    required this.tweet,
    required this.userId,
    required this.username,
    required this.followStatus,
  });
  final String notificationType;
  final String avatarURL;
  final String name;
  final String tweet;
  final String userId;
  final String username;
  final String followStatus;

  @override
  State<AllNotificationsListTile> createState() =>
      _AllNotificationsListTileState();
}

class _AllNotificationsListTileState extends State<AllNotificationsListTile> {
  String _followStatus = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _followStatus = widget.followStatus;
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    void Function() onPressed = () {};
    switch (widget.notificationType) {
      case 'like':
        text = 'Liked your tweet';
        break;
      case 'reply':
        text = 'Replied on your tweet';
        break;
      case 'retweet':
        text = 'Retweeted your tweet';
        break;
      case 'follow':
        text = 'Followed you';
        onPressed = () {
          if (!kIsWeb) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ProfileScreen(id: widget.userId, text: _followStatus);
              },
            ));
          } else {
            BlocProvider.of<SidebarCubit>(context)
                .emit(OtherProfileState(widget.userId, _followStatus));
          }
        };
        break;
      case 'mention':
        text = 'Mentioned you';
        break;
      default:
    }
    Color color = Colors.blueGrey;
    if (widget.notificationType == 'like') {
      color = Colors.pink;
    } else {
      color = Colors.blue[800]!;
    }
    return ListTile(
      onTap: onPressed,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/${widget.notificationType}.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
          ),
          widget.notificationType == 'follow'
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: widget.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: ' $text',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ])),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatarNotification(avatarURL: widget.avatarURL),
                )
        ],
      ),
      subtitle: widget.notificationType == 'follow'
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 20, 30, 0),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatarNotification(avatarURL: widget.avatarURL),
                        ElevatedButton(
                          onPressed: () async {
                            if (_followStatus == 'Follow back') {
                              //TODO :- Implement the follow logic
                              await FollowUser.instance
                                  .followUser(widget.username);
                              setState(() {
                                _followStatus = 'Following';
                              });
                            } else if (_followStatus == 'Following') {
                              //TODO :- Implement the unfollow logic
                              await FollowUser.instance
                                  .deleteUser(widget.username);
                              setState(() {
                                _followStatus = 'Follow back';
                              });
                            }
                          },
                          style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(3),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: _followStatus == 'Follow back'
                                          ? Colors.transparent
                                          : Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(80))),
                            backgroundColor: MaterialStatePropertyAll(
                                _followStatus == 'Follow back'
                                    ? Colors.black
                                    : Colors.white),
                          ),
                          child: Text(
                            _followStatus,
                            style: TextStyle(
                              color: _followStatus == 'Follow back'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '@${widget.username}',
                      style: TextStyle(
                        color: Color(0xFF3A5771),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, top: 15, bottom: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 10,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: ' $text',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n${widget.tweet}',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CircleAvatarNotification extends StatelessWidget {
  const CircleAvatarNotification({
    super.key,
    required this.avatarURL,
  });

  final String avatarURL;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) {
            return const Center(
              child: SpinKitRing(
                lineWidth: 3,
                size: 20,
                color: Colors.blueAccent,
              ),
            );
          },
          errorWidget: (context, url, error) {
            return const Icon(
              Icons.error_outline,
              color: Colors.blueAccent,
            );
          },
          imageUrl: basePhotosURL + avatarURL),
    );
  }
}
