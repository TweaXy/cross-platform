import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/loading_screen.dart';
import 'package:tweaxy/views/settings/settings_and_privacy_view.dart';

class FollowersPage extends StatefulWidget {
  FollowersPage({super.key, required this.username});
  String username;
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  PagingController<int, FollowersModel> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  Future<void> _refresh() async {
    _pagingController.refresh();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  final _pageSize = 7;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await followApi().getFollowers(
        username: widget.username,
        pageSize: _pageSize,
        offset: pageKey,
      );
      print(newItems);
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
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, state) {
        if (state is LoadingStata) {
          _pagingController.dispose();
          _pagingController = PagingController(firstPageKey: 0);
          _pagingController.addPageRequestListener((pageKey) {
            _fetchPage(pageKey);
          });
          return const LoadingScreen(asyncCall: true);
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Followers',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              actions: [
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Notification Setteing',
                      child: Text('Notification Setteing'),
                    ),
                  ],
                  onSelected: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsAndPrivacyView()),
                    );
                    print('Selected: $value');
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: PagedListView<int, FollowersModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  animateTransitions: true,
                  noItemsFoundIndicatorBuilder: (context) {
                    return const Center(
                      child: Text(
                        "No Followers ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: SpinKitRing(color: Colors.blueAccent),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) => const Center(
                    child: SpinKitRing(color: Colors.blueAccent),
                  ),
                  itemBuilder: (context, item, index) {
                    return CustomFollowers(isFollower: true, user: item);
                  },
                ),
              ),
            ),
            floatingActionButton: const FloatingButton(),
          );
        }
      },
    );
  }
}
