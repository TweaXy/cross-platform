import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/helpers/firebase_api.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/send_device_token.dart';
import 'package:tweaxy/services/temp_user.dart';
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

  // void dispose() {
  //   super.dispose();

  //   _pagingController.dispose();
  // }

  final _pageSize = 10;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItemstmp =
          await TweetsServices.getTweetsHome(offset: pageKey);
      print('lllll' + newItemstmp.toString());
      // final List<Tweet>newItems=newItemstmp.map((e) {if(!_pagingController.itemList.contains(e))
      //  return e;}).toList();
      final List<Tweet> newItems = [];
      // if (_pagingController.itemList != null)
      //   // ignore: curly_braces_in_flow_control_structures
      //   for (int i = 0; i < newItemstmp.length; i++) {
      //     if (!_pagingController.itemList!.contains(newItemstmp[i])) {
      //       newItems.add(newItemstmp[i]);
      //     }
      //   }
      //   else newItems.addAll(newItemstmp);
      newItems.addAll(newItemstmp);

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
        return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
          builder: (tweetContext, tweetState) {
            updateStatesforTweet(tweetState, tweetContext, _pagingController,
                isforHome: true);
            return PagedSliverList<int, Tweet>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                noItemsFoundIndicatorBuilder: (context) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "No tweets found\n",
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
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return CustomTweet(
                    tweet: item,
                    replyto: const [],
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
