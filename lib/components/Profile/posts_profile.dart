import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/tweets_services.dart';

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({super.key, required this.id});
  final String id;
  @override
  State<ProfilePosts> createState() => _MyPageState();
}

class _MyPageState extends State<ProfilePosts> {
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

  // void dispose() {
  //   super.dispose();

  //   _pagingController.dispose();
  // }

  final _pageSize = 5;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItems =
          await TweetsServices.getProfilePosts(offset: pageKey,id:widget.id);
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
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
      builder: (context, state) {
        if ( state is TweetAddedState) {
        
          _pagingController.refresh();
        }
        if(state is TweetDeleteState){
           _pagingController.itemList!
            .removeWhere((element) => element.id == state.tweetid);
              BlocProvider.of<TweetsUpdateCubit>(context)
                        .initializeTweet();
        }
        return PagedSliverList<int, Tweet>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
              noItemsFoundIndicatorBuilder: (context) {
            return const Center(
              child: Text("This user have no posts yet"),
            );
          },
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              return CustomTweet(
                forProfile: true,
                tweet: item, replyto: [],
              );
            },
          ),
        );
      },
    );
  }
}
