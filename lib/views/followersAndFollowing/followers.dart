import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';
import 'package:tweaxy/views/loading_screen.dart';

class FollowersPage extends StatefulWidget {
  FollowersPage({required this.username});
  String username;
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  ScrollController controller = ScrollController();

  int offset = 0;
  bool FirstTime = true;
  int myindex = 0;
  Set<FollowersModel> allfollow = {};
  Future<void> _refresh() async {
    allfollow = {};
    offset = 0;
    myindex = 0;
    FirstTime = true;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == 0) {
        // The user has scrolled to the top
        _refresh();
      }
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          offset += 10;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, state) {
        if (state is LoadingStata) {
          allfollow.clear();
          return LoadingScreen(asyncCall: true);
        } else {
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
                'Followers',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              actions: [
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Notification Setteing',
                      child: Text('Notification Setteing'),
                    ),
                  ],
                  onSelected: (value) {
                    print('Selected: $value');
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder<List<FollowersModel>>(
                  future: followApi().getFollowers(
                      scroll: controller,
                      username: widget.username,
                      offset: offset),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty && FirstTime) {
                        return const Center(
                          child: Text("You don't have Followers",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        );
                      } else {
                        FirstTime = false;
                        if (snapshot.data!.isNotEmpty)
                          allfollow.addAll(snapshot.data!);
                        myindex = allfollow.length;
                        return ListView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            List<FollowersModel> myList = allfollow.toList();
                            return CustomFollowers(
                              user: myList[index],
                              isFollower: true,
                            );
                          },
                          itemCount: allfollow.length,
                        );
                      }
                    } else if (snapshot.hasError) {
                      return kIsWeb
                          ? const CustomWebToast(message: "We have a problem")
                          : const Center(
                              child: CustomToast(message: "We have a problem"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
            floatingActionButton: const FloatingButton(),
          );
        }
      },
    );
  }
}
