import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/WebComponents/search_bar_web.dart';
import 'package:tweaxy/models/trend.dart';
import 'package:tweaxy/services/get_trends.dart';

class ExploreWebScreen extends StatefulWidget {
  const ExploreWebScreen({super.key});

  @override
  State<ExploreWebScreen> createState() => _ExploreWebScreenState();
}

class _ExploreWebScreenState extends State<ExploreWebScreen> {
  String id = '';
  String token = '';
  GetTrendsService services = GetTrendsService(dio: Dio());
  final PagingController<int, Trend> _pagingController =
      PagingController(firstPageKey: 0);

  final int _pageSize = 7;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('id')!;
      token = prefs.getString('token')!;
      setState(() {});
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

  bool cleared = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 0.5,
            ),
            right: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: SearchBarWeb(id: id, token: token)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0, left: 11),
                      child: Text(
                        "Trends",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => ViewTrendTweets(
                              //               trendName: item.name,
                              //             ))));
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
        ),
      ),
    );
  }
}
