import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/loading_screen.dart';

// ignore: must_be_immutable
class WebFollowersAndFollowings extends StatefulWidget {
  WebFollowersAndFollowings(
      {Key? key, required this.username, required this.name})
      : super(key: key);
  String username;
  String name;
  @override
  State<WebFollowersAndFollowings> createState() =>
      _WebFollowersAndFollowingsState();
}

class _WebFollowersAndFollowingsState extends State<WebFollowersAndFollowings>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  PagingController<int, FollowersModel> _pagingController1 =
      PagingController(firstPageKey: 0);
  PagingController<int, FollowersModel> _pagingController2 =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(_handleTabSelection);
    _pagingController1.addPageRequestListener((pageKey) {
      _fetchPage1(pageKey);
    });
    _pagingController2.addPageRequestListener((pageKey) {
      _fetchPage2(pageKey);
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController1.dispose();
    _pagingController2.dispose();
  }

  Future<void> _refresh() async {
    _pagingController1.refresh();
    _pagingController2.refresh();
    setState(() {});
  }

  final _pageSize = 7;
  Future<void> _fetchPage1(int pageKey) async {
    try {
      final newItems = await followApi().getFollowers(
        username: widget.username,
        pageSize: _pageSize,
        offset: pageKey,
      );
      print(newItems);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController1.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController1.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController1.error = error;
    }
  }

  Future<void> _fetchPage2(int pageKey) async {
    try {
      final newItems = await followApi().getFollowings(
        username: widget.username,
        pageSize: _pageSize,
        offset: pageKey,
      );
      print(newItems);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController2.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController2.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController2.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, state) {
        if (state is LoadingStata) {
          _pagingController1.dispose();
          _pagingController1 = PagingController(firstPageKey: 0);
          _pagingController1.addPageRequestListener((pageKey) {
            _fetchPage1(pageKey);
          });
          _pagingController2.dispose();
          _pagingController2 = PagingController(firstPageKey: 0);
          _pagingController2.addPageRequestListener((pageKey) {
            _fetchPage2(pageKey);
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
              title: Column(
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "@${widget.username}",
                    style: const TextStyle(
                      color: Color(0xffADB5BC),
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.blue,
                indicatorWeight: 4,
                indicatorPadding: const EdgeInsets.only(bottom: 1.0),
                tabs: [
                  Tab(
                    child: Text(
                      "Followers",
                      style: TextStyle(
                        color: tabController.index == 0
                            ? Colors.black
                            : const Color(0xffADB5BC),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Following",
                      style: TextStyle(
                        color: tabController.index == 1
                            ? Colors.black
                            : const Color(0xffADB5BC),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                PagedListView<int, FollowersModel>(
                  pagingController: _pagingController1,
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    noItemsFoundIndicatorBuilder: (context) {
                      return const Center(
                        child: Text(
                          'No Followers',
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
                PagedListView<int, FollowersModel>(
                  pagingController: _pagingController2,
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    firstPageProgressIndicatorBuilder: (context) {
                      return const Center(
                        child: SpinKitRing(color: Colors.blueAccent),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return const Center(
                        child: Text(
                          "No Followings",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
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
              ],
            ),
          );
        }
      },
    );
  }
}
