import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/get_likers_in_profile.dart';

class ProfileLikes extends StatefulWidget {
  const ProfileLikes({super.key});

  @override
  State<ProfileLikes> createState() => _ProfileLikesState();
}

final _pageSize = 4;

class _ProfileLikesState extends State<ProfileLikes> {
  GetLikersInProfile services = GetLikersInProfile(Dio());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Tweet> newItems =
          await services.likersList(pageNumber: pageKey);
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

  final PagingController<int, Tweet> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
        builder: (context, state) {
      if (state is TweetDeleteState ||
          state is TweetAddedState ||state is TweetUnLikedState
          // || state is TweetInitialState
          ) {
        // setState() {
        //   _pagingController.itemList!
        //       .removeWhere((element) => element.id == state.tweetid);
        // }

        _pagingController.refresh();
      }
      // if (state is TweetUnLikedState) {
      //   // List<Tweet> list = [];
      //   // for (int i = 0; i < _pagingController.itemList!.length; i++) {
      //   //   String id = _pagingController.itemList![i].id;
      //   //   if (id != state.tweetid) ;
      //   //   list.add(_pagingController.itemList![i]);
      //   // }
      //   // _pagingController.itemList!.clear();
      //   // _pagingController.itemList = list;
      //   // _pagingController.refresh();
      //   // _pagingController.itemList!
      //   //     .removeWhere((element) => element.id == state.tweetid);
      // }
      return PagedSliverList<int, Tweet>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) {
            return const Center(
              child: Text("You have no liked Tweets"),
            );
          },
          animateTransitions: true,
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(
              heightFactor: 3,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
          noMoreItemsIndicatorBuilder: (context) {
            return const SizedBox(
              width: 0,
              height: 0,
            );
          },
          newPageProgressIndicatorBuilder: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          )),
          itemBuilder: (context, item, index) {
            return CustomTweet(
              forProfile: false,
              tweet: item,
            );
          },
        ),
      );
    });
  }
}
