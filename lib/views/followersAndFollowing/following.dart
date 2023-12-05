import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({required this.username});
  String username;
  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final ScrollController controller = ScrollController();
  int offset = 0;
  bool FirstTime = true;
  int myindex = 0;
  Set<FollowersModel> allfollow = {};
  Future<void> _refresh() async {
    setState(() {});
    allfollow = {};
    offset = 0;
    myindex = 0;
    FirstTime = true;
    // await followApi().getFollowings(
    //     scroll: controller, username: widget.username, offset: 0);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          offset += 10;
        });
      }
    });
  }

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
          'Following',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<List<FollowersModel>>(
            future: followApi().getFollowings(
                scroll: controller, username: widget.username, offset: offset),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty && FirstTime) {
                  return const Center(
                    child: Text("You don't Follow any one",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
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
                        isFollower: false,
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
    );
  }
}
