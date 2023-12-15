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

class RepliesList extends StatefulWidget {
  const RepliesList({super.key, required this.replyto});
  final List<String> replyto;

  @override
  State<RepliesList> createState() => _MyPageState();
}

class _MyPageState extends State<RepliesList> {
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

  final _pageSize = 10;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItems =
          await TweetsServices.getTweetsHome(offset: pageKey);
      print('neew' + newItems.toString());
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
            if (updateallstate is LoadingStata ||
                state is TweetHomeRefresh ||
                state is TweetAddedState) {
              _pagingController.refresh();
            }
            if (state is TweetDeleteState) {
              _pagingController.itemList!
                  .removeWhere((element) => element.id == state.tweetid);
              BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
            }
            if (state is TweetLikedState) {
              _pagingController.itemList!.map((element) {
                if (element.id == state.tweetid) {
                  element.isUserLiked = !element.isUserLiked;
                  element.likesCount++;
                }
                return element;
              }).toList();

              BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
            }
            if (state is TweetUnLikedState) {
              _pagingController.itemList!.map((element) {
                if (element.id == state.tweetid) {
                  element.isUserLiked = !element.isUserLiked;
                  element.likesCount--;
                }
                return element;
              }).toList();
              BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
            }
            return PagedSliverList<int, Tweet>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return CustomTweet(
                    tweet: item,
                    replyto: widget.replyto,
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
