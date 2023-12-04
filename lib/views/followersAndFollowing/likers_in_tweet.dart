import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/get_likers.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';
import 'package:tweaxy/views/loading_screen.dart';

class LikersInTweet extends StatefulWidget {
  LikersInTweet({super.key, required this.id});
  String id;
  @override
  State<LikersInTweet> createState() => _LikersInTweetState();
}

class _LikersInTweetState extends State<LikersInTweet> {
  ScrollController controller = ScrollController();
  int offset = 0;
  bool FirstTime = true;
  int myindex = 0;
  Set<FollowersModel> alllikers = {};
  Future<void> _refresh() async {
    setState(() {});
    alllikers = {};
    offset = 0;
    myindex = 0;
    FirstTime = true;
  }

  @override
  void initState() {
    super.initState();
    alllikers = {};
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
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, state) {
        if (state is LoadingStata) {
          alllikers.clear();
          return LoadingScreen(asyncCall: true);
        } else
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
                'Liked by',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            body: RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder<List<FollowersModel>>(
                  future: Likers().getLikers(
                      scroll: controller, id: widget.id, offset: offset),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty && FirstTime) {
                        return const Center(
                          child: Text("NO Likers yet",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        );
                      } else {
                        FirstTime = false;
                        if (snapshot.data!.isNotEmpty)
                          alllikers.addAll(snapshot.data!);
                        myindex = alllikers.length;
                        return ListView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            List<FollowersModel> myList = alllikers.toList();
                            return CustomFollowers(
                              user: myList[index],
                              isFollower: false,
                            );
                          },
                          itemCount: alllikers.length,
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
      },
    );
  }
}
