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

final _pageSize = 7;

class _ProfileLikesState extends State<ProfileLikes> {
  GetLikersInProfile services = GetLikersInProfile(Dio());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
      if (state is TweetDeleteState || state is TweetUnLikedState|| state is TweetAddedState) {
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
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(
              heightFactor: 3,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
          newPageProgressIndicatorBuilder: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          )),
          itemBuilder: (context, item, index) {
            return CustomTweet(
              forProfile: true,
              tweet: item,
            );
          },
        ),
      );
    });
  }
}
