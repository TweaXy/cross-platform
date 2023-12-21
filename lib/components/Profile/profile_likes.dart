import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/get_likers_in_profile.dart';
import 'package:tweaxy/services/temp_user.dart';

class ProfileLikes extends StatefulWidget {
  const ProfileLikes({super.key, required this.id, required this.isMuted});
  final String id;
  final bool isMuted;

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
      dynamic response =
          await services.likersList(pageNumber: pageKey, id: widget.id);
      if (response != String) {
        final List<Tweet> newItems = response as List<Tweet>;
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  PagingController<int, Tweet> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
        builder: (context, state) {
      if (state is TweetDeleteState || state is TweetAddedState) {
        _pagingController.refresh();
      }
        if (state is TweetLikedState) {
              _pagingController.itemList!.map((element) {
                if (element.id == state.parentid) {
                  element.isUserLiked = !element.isUserLiked;
                  element.likesCount++;
                }
                return element;
              }).toList();

              BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
            }
           
      if (state is TweetUnLikedState && TempUser.id == widget.id) {
        _pagingController.itemList!
            .removeWhere((element) => element.id == state.parentid);
        // BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
      }
      return PagedSliverList<int, Tweet>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) {
            return const Center(
              child: Text("This user have no liked Tweets"),
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
              tweet: item,
              replyto: [], isMuted: widget.isMuted,
            );
          },
        ),
      );
    });
  }
}
