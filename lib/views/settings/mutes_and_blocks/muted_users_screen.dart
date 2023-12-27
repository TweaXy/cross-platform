import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/blocking_user_service.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/get_muted_users.dart';
import 'package:tweaxy/services/mute_user_service.dart';
import 'package:tweaxy/views/notifications/notification_screen.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class MutedUsersScreen extends StatefulWidget {
  const MutedUsersScreen({super.key});

  @override
  State<MutedUsersScreen> createState() => _MutedUsersScreenState();
}

class _MutedUsersScreenState extends State<MutedUsersScreen> {
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);
  static const _pageSize = 20;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await GetMutedUsers.getUsers(
        limit: _pageSize,
        offset: pageKey,
      );
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
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Muted accounts',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return _pagingController.refresh();
        },
        child: PagedListView<int, User>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<User>(
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: SizedBox(
                  width: 330,
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Muted accounts\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\nPosts from muted accounts won\'t show up in your Home timeline. Mute accounts directly from their profile or posts.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.blueGrey[600],
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            },
            itemBuilder: (context, item, index) {
              return Column(
                children: [
                  MutedUserListTile(
                      followStatus: item.followedByMe! ? 'Following' : 'Follow',
                      user: item),
                  Divider(
                    color: Colors.grey[300],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MutedUserListTile extends StatefulWidget {
  const MutedUserListTile({
    super.key,
    required this.followStatus,
    required this.user,
  });
  final String followStatus;
  final User user;
  @override
  State<MutedUserListTile> createState() => _MutedUserListTileState();
}

class _MutedUserListTileState extends State<MutedUserListTile> {
  String _followStatus = '';
  bool isMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _followStatus = widget.followStatus;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //Todo implement the list tile on press
        Navigator.push(
            context,
            CustomPageRoute(
                direction: AxisDirection.left,
                child: ProfileScreen(
                  id: widget.user.id!,
                  text: _followStatus,
                )));
      },
      leading: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: CircleAvatarNotification(avatarURL: widget.user.avatar!),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name!,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  '@${widget.user.userName}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              !isMuted
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () async {
                        //Todo : Implement the unmute logic here
                        isMuted = await MuteUserService.unMuteUser(
                            username: widget.user.userName!);
                        if (!isMuted) {
                          Fluttertoast.showToast(
                            msg: 'Oops there\'s an error',
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else {
                          isMuted = false;
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.volume_off_outlined,
                        color: Colors.redAccent,
                      ),
                    ),
              ElevatedButton(
                onPressed: () async {
                  if (_followStatus == 'Follow') {
                    await FollowUser.instance.followUser(widget.user.userName!);
                    setState(() {
                      _followStatus = 'Following';
                    });
                  } else if (_followStatus == 'Following') {
                    await FollowUser.instance.deleteUser(widget.user.userName!);
                    setState(() {
                      _followStatus = 'Follow';
                    });
                  } else {
                    bool status = await BlockingUserService.unBlockUser(
                      username: widget.user.userName!,
                    );
                    if (status) {
                      Fluttertoast.showToast(
                        msg: 'You unblocked @${widget.user.userName}',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      setState(() {
                        _followStatus = 'Follow';
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Oops there\'s an error',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(3),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(
                        color: _followStatus == 'Follow'
                            ? Colors.transparent
                            : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(80))),
                  backgroundColor: MaterialStatePropertyAll(
                      _followStatus == 'Follow' ? Colors.black : Colors.white),
                ),
                child: Text(
                  _followStatus,
                  style: TextStyle(
                    color:
                        _followStatus == 'Follow' ? Colors.white : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      titleAlignment: ListTileTitleAlignment.top,
      subtitle: const Text(
        'akfnaofknsoaifnsainf asjif s asf a sf asf asfaifj asijf sah fajshf uash fuhas fuhas fuh as asinfoiasfn ia sf i',
        style: TextStyle(
          color: Colors.black54,
          overflow: TextOverflow.clip,
        ),
        maxLines: 2,
      ),
    );
  }
}
