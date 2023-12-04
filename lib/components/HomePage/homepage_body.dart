import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody(
      {super.key, required this.tabController, required this.controller});
  final TabController tabController;
  final ScrollController controller;
  @override
  State<HomePageBody> createState() => _MyPageState();
}

class _MyPageState extends State<HomePageBody> {
  final PagingController<int, Tweet> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  final _pageSize = 5;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItems =
          await TweetsServices.getTweetsHome(offset: pageKey);
      print('neew' + newItems.toString());
      final isLastPage = newItems.length < _pageSize;
      print('tttt');
      print(newItems.length);
      print(_pageSize);
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

  String query = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
      builder: (context, state) {
        if (state is TweetDeleteState || state is TweetHomeRefresh) {
          // setState() {
          //   _pagingController.itemList!
          //       .removeWhere((element) => element.id == state.tweetid);
          // }

          _pagingController.refresh();
        }
        return PagedSliverList<int, Tweet>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              return CustomTweet(
                forProfile: false,
                tweet: item,
              );
            },
          ),
        );
      },
    );
  }
}
