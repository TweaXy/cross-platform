import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tweaxy/models/user.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _MyPageState();
}

bool showAction = false;

class _MyPageState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

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
            // fetchData(value);
            showAction = value == '' ? false : true;
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
                      //TODO Add the search function
                      // var u = await fetchData(query);
                      // controller.add(u);
                    },
                  );
                  return controller.stream;
                })(), builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ahmed Samy',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          '@ahmedsamy',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
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
                                                  color: Colors.blueGrey[600],
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 20,
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
