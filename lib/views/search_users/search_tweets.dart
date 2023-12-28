import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweaxy/views/search_users/tweets_searched.dart';

class SearchTweets extends StatefulWidget {
  SearchTweets({super.key, required this.username, required this.id});
  String username;
  String id;
  @override
  State<SearchTweets> createState() => _SearchTweetsState();
}

class _SearchTweetsState extends State<SearchTweets> {
  final TextEditingController _searchController = TextEditingController();

  bool showAction = false;
  final FocusNode _searchFocus = FocusNode();

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
          textInputAction: TextInputAction.search, // Set the search action

          focusNode: _searchFocus,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _submitSearch();
            }
          },
          controller: _searchController,
          maxLines: 1,
          style: const TextStyle(color: Colors.blue, fontSize: 17),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10.0),
              hintText: 'Search @${widget.username} Posts',
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
      body: RawKeyboardListener(
        focusNode: _searchFocus,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyUpEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            _submitSearch();
          }
        },
        child: Container(),
      ),
    );
  }

  void _submitSearch() {
    // Add your search logic here
    if (_searchController.text != '') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TweetsSearched(
                  text: 'from:@${widget.username} ${_searchController.text}',
                  username: widget.username,
                  id: widget.id,
                )),
      );
    }
  }
}
