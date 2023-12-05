import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/search_for_users.dart';
import 'package:tweaxy/views/search_users/search_users.dart';

class SearchBarWeb extends StatefulWidget {
  const SearchBarWeb({super.key, required this.id, required this.token});
  final String id;
  final String token;
  @override
  State<SearchBarWeb> createState() => _SearchBarWebState();
}

class _SearchBarWebState extends State<SearchBarWeb> {
  bool cleared = false;
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<User>(
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
              height: 60, child: Center(child: InitialTextSearchUser()));
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
        if (widget.id == item.id) {
          text = '';
        }
        log('Text = $text', name: 'Testing Explore');
        BlocProvider.of<SidebarCubit>(context).openProfile(item.id!, text);
      },
      suggestionsCallback: (search) async {
        if (search != '') {
          return SearchForUsers.searchForUser(search, widget.token);
        } else {
          return Future(() => [User()]);
        }
      },
    );
  }
}
