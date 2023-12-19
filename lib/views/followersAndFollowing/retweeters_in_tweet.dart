import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/get_likers.dart';
import 'package:tweaxy/services/get_reposts.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';
import 'package:tweaxy/views/loading_screen.dart';

class RepostsinTweet extends StatefulWidget {
  RepostsinTweet({super.key, required this.id});
  String id;
  @override
  State<RepostsinTweet> createState() => _RepostsinTweetState();
}

class _RepostsinTweetState extends State<RepostsinTweet> {
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
      final newItems = await Reposters().getReposts(
        id: widget.id,
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
          return LoadingScreen(asyncCall: true);
        } else {
          // _pagingController.refresh();
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
                'Reposted by',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: PagedListView<int, FollowersModel>(
                pagingController: _pagingController,
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
                        "No Likers in this tweet yet",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) => const Center(
                    child: SpinKitRing(color: Colors.blueAccent),
                  ),
                  itemBuilder: (context, item, index) {
                    return CustomFollowers(isFollower: false, user: item);
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
