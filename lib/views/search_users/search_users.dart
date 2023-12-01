import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  }

  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const UnderlineInputBorder(borderSide: BorderSide(width: 0.4)),
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
            ? Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Try searching for name or username',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    )),
              )
            : SizedBox(
                width: double.infinity,
                child: StreamBuilder<List<User>>(stream: (() {
                  late final StreamController<List<User>> controller;
                  controller = StreamController<List<User>>(
                    onListen: () async {
                      var u = await SearchForUsers.searchForUser(query, token!);
                      controller.add(u);
                    },
                  );
                  return controller.stream;
                })(), builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var users = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            User user = users[index];
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
                          child:
                              SearchUsersListTile(user:users[index]),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              ),
      ),
    );
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
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blueGrey[600],
              backgroundImage: CachedNetworkImageProvider(
                  basePhotosURL + user.avatar!),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.name!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      user.userName!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
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
