import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/chat/custom_chat_user.dart';
import 'package:tweaxy/models/user_chat.dart';
import 'package:tweaxy/services/search_for_users.dart';
import 'package:tweaxy/services/temp_user.dart';

class DirectMesssage extends StatefulWidget {
  const DirectMesssage({super.key});

  @override
  State<DirectMesssage> createState() => _DirectMesssageState();
}

class _DirectMesssageState extends State<DirectMesssage> {
  final TextEditingController _searchController = TextEditingController();
  final PagingController<int, UserChat> _pagingController =
      PagingController(firstPageKey: 0);
  final PagingController<int, UserChat> _pagingController1 =
      PagingController(firstPageKey: 0);
  bool showAction = false;
  String id = '';
  String token = '';

  @override
  void initState() {
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
    // _pagingController1.addPageRequestListener((pageKey) {
    //   _fetchPage1(pageKey);
    // });
  }

  final _pageSize = 7;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await SearchForUsers.searchForUserinsdeChat(
        username: query,
        pageSize: _pageSize,
        offset: pageKey,
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
      _pagingController.error = const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  }

  // Future<void> _fetchPage1(int pageKey) async {
  //   try {
  //     final newItems = await SearchForUsers.allusersInChat(
  //       pageSize: _pageSize,
  //       offset: pageKey,
  //     );
  //     print(newItems);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController1.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       _pagingController1.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController1.error = Container(
  //       child: const Center(
  //         child: Text(
  //           'No results found',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       ),
  //     );
  //   }
  // }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Direct Message',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 222, 215, 215),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: TextField(
                controller: _searchController,
                maxLines: 1,
                onChanged: (value) {
                  if (value == '') {
                    showAction = false;
                    setState(() {});
                    query = '';
                  } else {
                    showAction = true;
                    setState(() {});
                    query = value;
                  }
                  _pagingController.refresh();
                  _pagingController1.refresh();
                  setState(() {});
                },
                style: const TextStyle(color: Colors.black, fontSize: 17),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 80, 88, 95),
                    size: 35,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
              child: PagedListView<int, UserChat>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              animateTransitions: true,
              noItemsFoundIndicatorBuilder: (context) {
                return const Center(
                  child: SizedBox(),
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return const SizedBox();
              },
              firstPageProgressIndicatorBuilder: (context) {
                return const Center(
                  child: SpinKitRing(color: Colors.blueAccent),
                );
              },
              newPageProgressIndicatorBuilder: (context) => const Center(
                child: SpinKitRing(color: Colors.blueAccent),
              ),
              itemBuilder: (context, item, index) {
                if (item.id == TempUser.id) {
                  return const SizedBox();
                } else {
                  return CustomUserChat(user: item);
                }
              },
            ),
          )
              //       : PagedListView<int, UserChat>(
              //           pagingController: _pagingController1,
              //           builderDelegate: PagedChildBuilderDelegate(
              //             animateTransitions: true,
              //             noItemsFoundIndicatorBuilder: (context) {
              //               return const Center(
              //                 child: SizedBox(),
              //               );
              //             },
              //             newPageErrorIndicatorBuilder: (context) {
              //               return const SizedBox();
              //             },
              //             firstPageProgressIndicatorBuilder: (context) {
              //               return const Center(
              //                 child: SpinKitRing(color: Colors.blueAccent),
              //               );
              //             },
              //             newPageProgressIndicatorBuilder: (context) =>
              //                 const Center(
              //               child: SpinKitRing(color: Colors.blueAccent),
              //             ),
              //             itemBuilder: (context, item, index) {
              //               return CustomUserChat(user: item);
              //             },
              //           ),
              //         ),
              ),
        ],
      ),
    );
  }
}
