import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/search_for_users.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/views/splash_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _MyPageState();
}

class _MyPageState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool showAction = false;
  String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('id')!;
      token = prefs.getString('token')!;
      setState(() {});
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  final _pageSize = 7;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await SearchForUsers.searchForUser(
        query,
        token!,
        pageSize: _pageSize,
        pageNumber: pageKey,
      );
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

  String query = '';
  @override
  Widget build(BuildContext context) {
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
            controller: _searchController,
            maxLines: 1,
            onChanged: (value) {
              if (value == '') {
                showAction = false;
              } else {
                showAction = true;
                query = value;
              }
              _pagingController.refresh();
              setState(() {});
            },
            style: const TextStyle(color: Colors.blue, fontSize: 17),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 10.0),
                hintText: 'Search TweaXy',
                hintStyle: TextStyle(color: Colors.grey[500])),
          ),
          actions: showAction
              ? [
                  IconButton(
                      onPressed: () {
                        _searchController.text = '';
                        showAction = false;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.close_sharp,
                        color: Colors.black,
                      ))
                ]
              : null,
        ),
        body: SizedBox(
          width: double.infinity,
          child: !showAction
              ? const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: InitialTextSearchUser(),
                )
              : SizedBox(
                  width: double.infinity,
                  child: PagedListView<int, User>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      firstPageProgressIndicatorBuilder: (context) {
                        return const Center(
                          child: SpinKitRing(color: Colors.blueAccent),
                        );
                      },
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(
                        child: SpinKitRing(color: Colors.blueAccent),
                      ),
                      itemBuilder: (context, item, index) {
                        return GestureDetector(
                          onTap: () {
                            User user = item;
                            String text = '';
                            if (user.id != id) {
                              if (user.following == 1) {
                                text = 'Following';
                              } else {
                                text = 'Follow';
                              }
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(id: user.id!, text: text),
                              ),
                            );
                          },
                          child: SearchUsersListTile(
                            user: item,
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ));
  }

  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
  }
}

// class SearchingForUsers extends StatelessWidget {
//   const SearchingForUsers({
//     super.key,
//     required this.showAction,
//     required this.query,
//     required this.id,
//     required this.userToken,
//     required this.pagingController,
//   });
//   final PagingController<int, User> pagingController;
//   final bool showAction;
//   final String query;
//   final String id;
//   final String userToken;

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class InitialTextSearchUser extends StatelessWidget {
  const InitialTextSearchUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Text(
          'Try searching for name or username',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ));
  }
}

class SearchUsersListTile extends StatelessWidget {
  const SearchUsersListTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: kIsWeb ? 70 : 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: kIsWeb ? 20 : 28,
              backgroundColor: Colors.blueGrey[300],
              backgroundImage:
                  CachedNetworkImageProvider(basePhotosURL + user.avatar!),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      user.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: kIsWeb ? 16 : 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        user.userName!,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: kIsWeb ? 13 : 15,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: user.following == 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 15,
                            color: Colors.blueGrey[600],
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                                color: Colors.blueGrey[600], fontSize: 13),
                          ),
                        ],
                      ),
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
