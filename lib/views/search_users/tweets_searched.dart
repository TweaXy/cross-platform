import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/get_search_tweets.dart';
import 'package:tweaxy/services/search_for_users.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/views/loading_screen.dart';
import 'package:tweaxy/views/search_users/search_tweets.dart';
import 'package:tweaxy/views/search_users/search_users.dart';
import 'package:tweaxy/views/splash_screen.dart';

class TweetsSearched extends StatefulWidget {
  TweetsSearched(
      {super.key,
      required this.text,
      required this.username,
      required this.id});
  String text;
  String id;
  String username;
  @override
  State<TweetsSearched> createState() => _TweetsSearchedState();
}

class _TweetsSearchedState extends State<TweetsSearched>
    with SingleTickerProviderStateMixin {
  PagingController<int, Tweet> _pagingController2 =
      PagingController(firstPageKey: 0);
  PagingController<int, FollowersModel> _pagingController3 =
      PagingController(firstPageKey: 0);
  final TextEditingController _searchController = TextEditingController();
  late TabController tabController;
  final FocusNode _searchFocusNode = FocusNode();
  String initText = '';
  String id = '';
  String token = '';
  String queryPeople = '';
  String queryTweets = '';

  @override
  void initState() {
    _searchController.text = widget.text;
    initText = widget.text;
    // query = makequery();
    querySearch();
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(_handleTabSelection);
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchScreen(
                    txt: _searchController.text,
                  )),
        );
      }
    });

    _pagingController2.addPageRequestListener((pageKey) {
      _fetchPage2(pageKey);
    });
    _pagingController3.addPageRequestListener((pageKey) {
      _fetchPage3(pageKey);
    });
    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      setState(() {});
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController2.dispose();
    _pagingController3.dispose();
  }

  Future<void> _refresh() async {
    _pagingController2.refresh();
    _pagingController3.refresh();
    setState(() {});
  }

  final _pageSize = 7;

  Future<void> _fetchPage2(int pageKey) async {
    if (queryTweets == '') {
      try {
        final newItems = await SearchTweetTweets().getSearchTweets(
            username: widget.username, offset: pageKey, pageSize: _pageSize);
        print(newItems);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController2.appendLastPage(newItems.cast<Tweet>());
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController2.appendPage(newItems.cast<Tweet>(), nextPageKey);
        }
        queryTweets=widget.text;
      } catch (error) {
        _pagingController2.error = error;
      }
    } else {
      if ((queryPeople == queryTweets && widget.text.indexOf('from:@') != 0) ||
          (queryPeople == '' && widget.text[0] == '#')) {
        //هبحث عن كل التويت من غير username
        String temp = queryTweets.replaceAll("#", "%23");
        try {
          final newItems = await SearchTweetTweets().getSearchTweets(
              query: temp, offset: pageKey, pageSize: _pageSize);
          print(newItems);
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController2.appendLastPage(newItems.cast<Tweet>());
          } else {
            final nextPageKey = pageKey + newItems.length;
            _pagingController2.appendPage(newItems.cast<Tweet>(), nextPageKey);
          }
        } catch (error) {
          _pagingController2.error = error;
        }
      } else {
        //search for tweets with username
        try {
          final newItems = await SearchTweetTweets().getSearchTweets(
              username: widget.username,
              query: queryTweets,
              offset: pageKey,
              pageSize: _pageSize);
          print(newItems);
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController2.appendLastPage(newItems.cast<Tweet>());
          } else {
            final nextPageKey = pageKey + newItems.length;
            _pagingController2.appendPage(newItems.cast<Tweet>(), nextPageKey);
          }
        } catch (error) {
          _pagingController2.error = error;
        }
      }
    }
  }

  Future<void> _fetchPage3(int pageKey) async {
    if (queryPeople != '') {
      try {
        final newItems = await SearchForUsers.searchForUserinside(
          username: queryPeople,
          pageSize: _pageSize,
          offset: pageKey,
        );
        print(newItems);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController3.appendLastPage(newItems.cast<FollowersModel>());
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController3.appendPage(
              newItems.cast<FollowersModel>(), nextPageKey);
        }
      } catch (error) {
        _pagingController3.error = error;
      }
    } else {
      _pagingController3.itemList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, state) {
        if (state is LoadingStata) {
          _pagingController2.dispose();
          _pagingController2 = PagingController(firstPageKey: 0);
          _pagingController2.addPageRequestListener((pageKey) {
            _fetchPage2(pageKey);
          });
          _pagingController3.dispose();
          _pagingController3 = PagingController(firstPageKey: 0);
          _pagingController3.addPageRequestListener((pageKey) {
            _fetchPage3(pageKey);
          });
          return LoadingScreen(asyncCall: true);
        } else {
          return Scaffold(
            appBar: AppBar(
              shape: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 0.4,
                color: Colors.grey[300]!,
              )),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: TextField(
                focusNode: _searchFocusNode, // Use the new FocusNode
                textInputAction: TextInputAction.search,
                controller: TextEditingController.fromValue(
                  TextEditingValue(text: initText),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 17),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 218, 228, 231),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.only(left: 10.0),
                ),
              ),
              // actions: [
              //   IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.format_list_bulleted_rounded,
              //         color: Colors.black,
              //       )),
              //   PopupMenuButton(
              //     icon: const Icon(
              //       Icons.more_vert,
              //       color: Colors.black,
              //     ),
              //     itemBuilder: (context) => [
              //       const PopupMenuItem(
              //         value: 'Search Setteing',
              //         child: Text('Search Setteing'),
              //       ),
              //       const PopupMenuItem(
              //         value: 'Delete Search',
              //         child: Text('Delete Search'),
              //       ),
              //       const PopupMenuItem(
              //         value: 'Share',
              //         child: Text('Share'),
              //       ),
              //     ],
              //     onSelected: (value) {},
              //   ),
              // ],
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.blue,
                indicatorWeight: 4,
                indicatorPadding: const EdgeInsets.only(bottom: 1.0),
                tabs: [
                  Tab(
                    child: Text(
                      "Latest",
                      style: TextStyle(
                        color: tabController.index == 0
                            ? Colors.black
                            : const Color(0xffADB5BC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "People",
                      style: TextStyle(
                        color: tabController.index == 1
                            ? Colors.black
                            : const Color(0xffADB5BC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
                    builder: (context, state) {
                  if (state is TweetHomeRefresh || state is TweetAddedState) {
                    _pagingController2.refresh();
                  }
                  if (state is TweetDeleteState) {
                    _pagingController2.itemList!
                        .removeWhere((element) => element.id == state.tweetid);
                    BlocProvider.of<TweetsUpdateCubit>(context)
                        .initializeTweet();
                  }
                  if (state is TweetLikedState) {
                    _pagingController2.itemList!.map((element) {
                      if (element.id == state.tweetid) {
                        element.isUserLiked = !element.isUserLiked;
                        element.likesCount++;
                      }
                      return element;
                    }).toList();

                    BlocProvider.of<TweetsUpdateCubit>(context)
                        .initializeTweet();
                  }
                  if (state is TweetUnLikedState) {
                    _pagingController2.itemList!.map((element) {
                      if (element.id == state.tweetid) {
                        element.isUserLiked = !element.isUserLiked;
                        element.likesCount--;
                      }
                      return element;
                    }).toList();
                    BlocProvider.of<TweetsUpdateCubit>(context)
                        .initializeTweet();
                  }
                  return PagedListView<int, Tweet>(
                    pagingController: _pagingController2,
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      firstPageProgressIndicatorBuilder: (context) {
                        return const Center(
                          child: SpinKitRing(color: Colors.blueAccent),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Text(
                            'No results for ${queryTweets}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(
                        child: SpinKitRing(color: Colors.blueAccent),
                      ),
                      itemBuilder: (context, item, index) {
                        return CustomTweet(
                          tweet: item,
                          replyto: [],
                        );
                      },
                    ),
                  );
                }),
                PagedListView<int, FollowersModel>(
                  pagingController: _pagingController3,
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    firstPageProgressIndicatorBuilder: (context) {
                      return const Center(
                        child: SpinKitRing(color: Colors.blueAccent),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Center(
                        child: Text(
                          'No results for ${queryPeople == '' ? queryTweets : queryPeople}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    newPageProgressIndicatorBuilder: (context) => const Center(
                      child: SpinKitRing(color: Colors.blueAccent),
                    ),
                    itemBuilder: (context, item, index) {
                      return CustomFollowers(
                        isFollower: false,
                        user: item,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // String makeText() {
  //   String text;
  //   if (_searchController.text.length > 20) {
  //     text = _searchController.text.substring(0, 20) + '...';
  //   } else
  //     text = _searchController.text;
  //   return text;
  // }

  // String makequery() {
  //   String text;
  //   int i = _searchController.text.indexOf('${widget.username}');
  //   text = _searchController.text.substring(i + widget.username.length);
  //   return text;
  // }

  void querySearch() {
    if (widget.text[0] == '#') {
      queryPeople = '';
      queryTweets = widget.text;
    } else if (widget.text.indexOf('from:@') == 0) {
      if (widget.text.length > 6 + widget.username.length) {
        queryTweets = widget.text.substring(6 + widget.username.length + 1);
        queryPeople = widget.username;
      } else {
        queryPeople = widget.username;
        queryTweets = "";
      }
    } else {
      queryPeople = widget.text;
      queryTweets = widget.text;
    }
  }
}
