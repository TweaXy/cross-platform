import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/mute_block_reply.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class RepliesList extends StatefulWidget {
  const RepliesList(
      {super.key, required this.replyto, required this.mainTweetId});
  final List<String> replyto;
  final String mainTweetId;
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
      final List<Tweet> newItems = await TweetsServices.getReplies(
          offset: pageKey, id: widget.mainTweetId);
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
            updateStatesforTweet(state, context, _pagingController);

            return PagedSliverList<int, Tweet>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                noItemsFoundIndicatorBuilder: (context) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "No replies found\n",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                          child: Text(
                            "List is currently empty",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(121, 119, 119, 1)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemBuilder: (context, item, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: (_pagingController.itemList != null &&
                                index == _pagingController.itemList!.length - 1)
                            ? 150
                            : 0),
                    child: _pagingController.itemList != null &&
                            _pagingController.itemList!.length > 0 &&
                            !item.isShown
                        ? MuteBlockReply(
                            tweetid: item.id,
                            isMute: item.isUserMutedByMe,
                          )
                        : CustomTweet(
                            tweet: item,
                            replyto: widget.replyto,
                            isMuted: false,
                            isUserBlocked: false,
                          ),
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
