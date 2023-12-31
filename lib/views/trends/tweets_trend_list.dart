import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class TweetsListTrend extends StatefulWidget {
  const TweetsListTrend({super.key, required this.trendName});
  final String trendName;

  @override
  State<TweetsListTrend> createState() => _MyPageState();
}

class _MyPageState extends State<TweetsListTrend> {
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

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  final _pageSize = 10;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItems = await TweetsServices.getTweetsTrend(
          offset: pageKey, trendname: widget.trendName);
      // print('neew' + newItems.toString());
      final isLastPage = newItems.length < _pageSize;
      // print('tttt');
      // print(newItems.length);
      // print(_pageSize);
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
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, updateallstate) {
        return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
          builder: (context, state) {
            updateStatesforTweet(state, context, _pagingController);
            return PagedSliverList<int, Tweet>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                // noItemsFoundIndicatorBuilder: (context) {
                //   return const Center(
                //     child: Text("No tweets yet"),
                //   );
                // },
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return CustomTweet(
                    tweet: item,
                    replyto: {},
                    isMuted: false,
                    isUserBlocked: false,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
