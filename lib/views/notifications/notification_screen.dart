import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/models/user_notification.dart';
import 'package:tweaxy/services/get_all_notifications.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const _pageSize = 20;

  final PagingController<int, UserNotification> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
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
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  floating: true,
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
                  leading: Padding(
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
                  centerTitle: true,
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
                  child: PagedListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    pagingController: _pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<UserNotification>(
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
                              'There Are No Notifications',
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
                        return NotificationListTile(
                          notificationType: item.action!,
                          avatarURL: item.avatar!,
                          name: item.name!,
                          tweet: item.interaction == null
                              ? ''
                              : item.interaction!.text ?? '',
                          followStatus: 'Follow Back',
                          userId: item.userId!,
                          username: item.userName!,
                        );
                      },
                    ),
                  ),
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return Placeholder();
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                  ),
                  itemCount: 200,
                ),
              ],
            ),
          ),
        );
  }
}

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
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
  Widget build(BuildContext context) {
    String text = '';
    void Function() onPressed = () {};
    switch (notificationType) {
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
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ProfileScreen(id: userId, text: followStatus);
            },
          ));
        };
        break;
      case 'mention':
        text = 'Mentioned you';
        break;
      default:
    }
    Color color = Colors.blueGrey;
    if (notificationType == 'like') {
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
            'assets/images/$notificationType.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(color, BlendMode.src),
          ),
          notificationType == 'follow'
              ? const SizedBox()
              : CircleAvatarNotification(avatarURL: avatarURL)
        ],
      ),
      subtitle: notificationType == 'follow'
          ? FollowNotificationSubtitle(
              name: name, username: username, text: text, avatar: avatarURL)
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
                          text: name,
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
                          text: '\n\n$tweet',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ClipOval(
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
      ),
    );
  }
}

class FollowNotificationSubtitle extends StatelessWidget {
  const FollowNotificationSubtitle({
    super.key,
    required this.name,
    required this.username,
    required this.text,
    required this.avatar,
  });
  final String name;
  final String username;
  final String text;
  final String avatar;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Container(
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatarNotification(avatarURL: avatar)),
                FollowEditButton(text: text, user: User(userName: username))
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '@$username',
              style: TextStyle(
                color: Color(0xFF3A5771),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
