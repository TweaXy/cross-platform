import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/blocking_user_service.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/get_blocked_users.dart';
import 'package:tweaxy/services/unfollow_user.dart';
import 'package:tweaxy/views/notifications/notification_screen.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  final _pageSize = 20;
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await GetBlockedUsers.getUsers(limit: _pageSize, offset: pageKey);
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
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
          'Blocked accounts',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
      ),
      body: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state is ProfilePageLoadingState) {
            return const Center(
              child: SpinKitRing(color: Colors.blueAccent),
            );
          }
          return RefreshIndicator(
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
                            text: 'Block unwanted accounts\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\nWhen you block someone, they won\'t be able to follow or message you, and you won\'t see notifications from them.',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
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
                      BlockedUserListTile(status: 'Blocked', user: item),
                      Divider(
                        color: Colors.grey[300],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class BlockedUserListTile extends StatefulWidget {
  const BlockedUserListTile({
    super.key,
    required this.status,
    required this.user,
  });
  final String status;
  final User user;
  @override
  State<BlockedUserListTile> createState() => _BlockedUserListTileState();
}

class _BlockedUserListTileState extends State<BlockedUserListTile> {
  String _status = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            CustomPageRoute(
                direction: AxisDirection.left,
                child: ProfileScreen(
                  id: widget.user.id!,
                  text: _status,
                )));
      },
      leading: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: CircleAvatarNotification(avatarURL: widget.user.avatar!),
      ),
      title: Row(
        children: [
          Expanded(
            flex: 11,
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
          Expanded(
            flex: 4,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_status == 'Follow') {
                    await FollowUser.instance.followUser(widget.user.userName!);
                    setState(() {
                      _status = 'Following';
                    });
                  } else if (_status == 'Following') {
                    await FollowUser.instance.deleteUser(widget.user.userName!);
                    setState(() {
                      _status = 'Follow';
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
                        _status = 'Follow';
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
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.fromLTRB(12, 8, 12, 8)),
                  elevation: const MaterialStatePropertyAll(3),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(
                        color: _status == 'Blocked'
                            ? Colors.transparent
                            : _status == 'Follow'
                                ? Colors.transparent
                                : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(80))),
                  backgroundColor: MaterialStatePropertyAll(_status == 'Blocked'
                      ? Colors.redAccent[700]
                      : _status == 'Follow'
                          ? Colors.black
                          : Colors.white),
                ),
                child: Text(
                  _status,
                  style: TextStyle(
                    color: _status != 'Following' ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      titleAlignment: ListTileTitleAlignment.top,
      subtitle: Text(
        widget.user.bio ?? '',
        style: const TextStyle(
          color: Colors.black54,
          overflow: TextOverflow.clip,
        ),
        maxLines: 2,
      ),
    );
  }
}
