import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/trend.dart';
import 'package:tweaxy/services/get_trends.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/search_keys.dart';
import 'package:tweaxy/views/trends/view_trend_tweets.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});
  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  GetTrendsService services = GetTrendsService(dio: Dio());
  final PagingController<int, Trend> _pagingController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 7;
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Trend> newItems =
          await services.getTrendsList(null, limit: 7, pageNumber: pageKey);
      log(newItems.toString());
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
    setState(() {});
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey[300],
              height: 0.7,
            ),
          ),
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, kProfileScreen);
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage:
                    CachedNetworkImageProvider(basePhotosURL + TempUser.image),
              ),
            ),
          ),
          titleSpacing: 10,
          title: GestureDetector(
            onTap: () {
              //Todo Add navigation to Search View
              Navigator.pushNamed(context, kSearchScreen);
            },
            child: Container(
              width: double.infinity,
              height: AppBar().preferredSize.height * 2 / 3,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Align(
                  key: const ValueKey(SearchKeys.searchBar),
                  alignment: Alignment.centerLeft,
                  child: Text('      Search TweaXy',
                      style: TextStyle(color: Colors.grey[500], fontSize: 15))),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: const Text(
                "Trends",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.74,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  PagedSliverList<int, Trend>(
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
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(
                              child: CircularProgressIndicator(
                        color: Colors.blue,
                      )),
                      itemBuilder: (context, item, index) {
                        String s = item.count > 1 ? ' posts' : ' post';

                        var postNumber = NumberFormat.compactCurrency(
                                symbol: '', decimalDigits: 0)
                            .format(item.count);
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ViewTrendTweets(
                                            trendName: item.name,
                                          ))));
                            },
                            title: Text(
                              '${index + 1} . Trending',
                            ),
                            titleTextStyle: TextStyle(
                              color: Colors.blueGrey[700],
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    '#${item.name}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  '$postNumber$s',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    // fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
