import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/models/trend.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/get_trends.dart';
import 'package:tweaxy/services/search_for_users.dart';
import 'package:tweaxy/views/search_users/search_users.dart';

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
          await services.getTrendsList(null, pageNumber: pageKey);
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
              child: TypeAheadField<User>(
                builder: (context, controller, focusNode) {
                  return TextField(
                      onChanged: (value) {
                        cleared = value != '';
                        setState(() {});
                      },
                      cursorColor: Colors.black,
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          hoverColor: Colors.grey[100],
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: cleared
                              ? IconButton(
                                  onPressed: () {
                                    controller.clear();
                                    cleared = false;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.close))
                              : null,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          hintText: 'Search'));
                },
                itemBuilder: (context, user) {
                  if (user.id == null) {
                    return const SizedBox(
                        height: 60,
                        child: Center(child: InitialTextSearchUser()));
                  } else {
                    return SearchUsersListTile(user: user);
                  }
                },
                decorationBuilder: (context, child) {
                  return Material(
                    type: MaterialType.card,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  );
                },
                constraints: const BoxConstraints(maxHeight: 500),
                onSelected: (item) {
                  if (item.id == null) return;
                  String text = '';
                  if (item.following == 1) {
                    text = 'Following';
                  } else {
                    text = 'Follow';
                  }
                  if (id == item.id) {
                    text = '';
                  }
                  log('Text = $text', name: 'Testing Explore');
                  BlocProvider.of<SidebarCubit>(context)
                      .openProfile(item.id!, text);
                },
                suggestionsCallback: (search) async {
                  if (search != '') {
                    return SearchForUsers.searchForUser(search, token);
                  } else {
                    return Future(() => [User()]);
                  }
                },
              ),
            ),
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
