import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/chat/custom_chat_user_web.dart';
import 'package:tweaxy/models/user_chat.dart';
import 'package:tweaxy/services/search_for_users.dart';

class DirectMesssageWeb extends StatefulWidget {
  const DirectMesssageWeb({super.key});

  @override
  State<DirectMesssageWeb> createState() => _DirectMesssageState();
}

class _DirectMesssageState extends State<DirectMesssageWeb> {
  final TextEditingController _searchController = TextEditingController();
  final PagingController<int, UserChat> _pagingController =
      PagingController(firstPageKey: 0);
  String id = '';
  String token = '';
  bool showAction = true;
  @override
  void initState() {
    super.initState();
    // Future(() async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   id = prefs.getString('id')!;
    //   token = prefs.getString('token')!;
    //   setState(() {});
    // });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
      _pagingController.error = Container(
        child: const Center(
          child: Text(
            'No results found',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03),
                    child: const Text(
                      'New message',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: TextField(
                  controller: _searchController,
                  maxLines: 1,
                  onChanged: (value) {
                    if (value == '') {
                      showAction = true;
                      setState(() {});
                      query = '';
                    } else {
                      showAction = false;
                      setState(() {});
                      query = value;
                    }
                    _pagingController.refresh();
                    setState(() {});
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 30,
                    ),
                    border: InputBorder.none,
                    hintText: 'Search people ',
                  ),
                ),
              ),
            ),
            Expanded(
              child: showAction
                  ? const SizedBox()
                  : PagedListView<int, UserChat>(
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
                        newPageProgressIndicatorBuilder: (context) =>
                            const Center(
                          child: SpinKitRing(color: Colors.blueAccent),
                        ),
                        itemBuilder: (context, item, index) {
                          return CustomUserChatWeb(user: item);
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
