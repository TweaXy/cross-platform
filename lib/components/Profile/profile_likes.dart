import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/mute_block_reply.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/get_likers_in_profile.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class ProfileLikes extends StatefulWidget {
  const ProfileLikes({
    super.key,
    required this.id,
    required this.isMuted,
    required this.isUserBlocked,
  });
  final String id;
  final bool isMuted;
  final bool isUserBlocked;

  @override
  State<ProfileLikes> createState() => _ProfileLikesState();
}

const _pageSize = 4;

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

  final PagingController<int, Tweet> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
        builder: (context, state) {
      updateStatesforTweet(state, context, _pagingController);
      if (state is TweetDeleteState || state is TweetAddedState) {
        _pagingController.refresh();
        BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
      }
      if (state is TweetUnLikedState && TempUser.id == widget.id) {
        _pagingController.itemList!
            .removeWhere((element) => element.id == state.id);
        BlocProvider.of<TweetsUpdateCubit>(context).initializeTweet();
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
            return (_pagingController.itemList != null &&
                    _pagingController.itemList!.isNotEmpty &&
                    !item.isShown)
                ? MuteBlockReply(
                    tweetid: item.id,
                    isMute: item.isUserMutedByMe,
                  )
                : CustomTweet(
                    tweet: item,
                    replyto: {},
                    isMuted: widget.isMuted,
                    isUserBlocked: widget.isUserBlocked,
                  );
          },
        ),
      );
    });
  }
}
