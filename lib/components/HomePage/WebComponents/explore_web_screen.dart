import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:paginated_search_bar/paginated_search_bar_state_property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/models/user.dart';
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

  bool cleared = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TypeAheadField<User>(
              builder: (context, controller, focusNode) {
                return TextField(
                    onChanged: (value) {
                      cleared = value != '';
                      setState(() {});
                    },cursorColor: Colors.black,
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        hoverColor: Colors.grey[100],
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: cleared
                            ? IconButton(
                                onPressed: () {
                                  controller.clear();
                                  cleared = false;
                                  setState(() {});
                                },
                                icon: Icon(Icons.close))
                            : null,
                            focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.blue,
                            style: BorderStyle.solid,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
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
        ],
      ),
    );
  }
}
