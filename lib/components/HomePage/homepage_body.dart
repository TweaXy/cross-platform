import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});
  @override
  State<HomePageBody> createState() => _MyPageState();
}

class _MyPageState extends State<HomePageBody> {
  PagingController<int, Tweet> _pagingController =
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

  final _pageSize = 10;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItems =
          await TweetsServices.getTweetsHome(offset: pageKey);
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
    return BlocBuilder<UpdateUsernameCubit, UpdateUsernameStates>(
      builder: (context, state) {
      updateStatesforTweet(state, context, _pagingController);
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
                      return CustomTweet(tweet: item, replyto: const []);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
