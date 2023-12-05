import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/custom_followers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';
import 'package:tweaxy/views/loading_screen.dart';

// ignore: must_be_immutable
class WebFollowersAndFollowings extends StatefulWidget {
  WebFollowersAndFollowings({Key? key, required this.username})
      : super(key: key);
  String username;
  @override
  State<WebFollowersAndFollowings> createState() =>
      _WebFollowersAndFollowingsState();
}

class _WebFollowersAndFollowingsState extends State<WebFollowersAndFollowings>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController controller = ScrollController();
  int offset1 = 0;
  int offset2 = 0;
  // ignore: non_constant_identifier_names
  bool FirstTime1 = true;
  // ignore: non_constant_identifier_names
  bool FirstTime2 = true;
  Set<FollowersModel> allfollow1 = {};
  Set<FollowersModel> allfollow2 = {};
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(_handleTabSelection);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          offset1 += 10;
          offset2 += 10;
        });
      }
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAllCubit, UpdataAllState>(
      builder: (context, state) {
        if (state is LoadingStata) {
          allfollow1.clear();
          allfollow2.clear();
          return const LoadingScreen(asyncCall: true);
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
              title: const Column(
                children: [
                  Text(
                    'KareemKaokab',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '@KareemKaokab',
                    style: TextStyle(
                      color: Color(0xffADB5BC),
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.blue,
                indicatorWeight: 4,
                indicatorPadding: const EdgeInsets.only(bottom: 1.0),
                tabs: [
                  Tab(
                    child: Text(
                      "Followers",
                      style: TextStyle(
                        color: tabController.index == 0
                            ? Colors.black
                            : const Color(0xffADB5BC),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Following",
                      style: TextStyle(
                        color: tabController.index == 1
                            ? Colors.black
                            : const Color(0xffADB5BC),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                FutureBuilder<List<FollowersModel>>(
                  future: followApi().getFollowers(
                      scroll: controller,
                      username: widget.username,
                      offset: offset1),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty && FirstTime1) {
                        return const Center(
                          child: Text("You don't have Followers",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        );
                      } else {
                        FirstTime1 = false;
                        if (snapshot.data!.isNotEmpty) {
                          allfollow1.addAll(snapshot.data!);
                        }
                        return ListView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            List<FollowersModel> myList = allfollow1.toList();
                            return CustomFollowers(
                              user: myList[index],
                              isFollower: true,
                            );
                          },
                          itemCount: allfollow1.length,
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
                ),
                FutureBuilder<List<FollowersModel>>(
                  future: followApi().getFollowings(
                      scroll: controller,
                      username: widget.username,
                      offset: offset2),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty && FirstTime1) {
                        return const Center(
                          child: Text("You don't Follow any one",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        );
                      } else {
                        FirstTime2 = false;
                        if (snapshot.data!.isNotEmpty) {
                          allfollow2.addAll(snapshot.data!);
                        }
                        return ListView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            List<FollowersModel> myList = allfollow2.toList();
                            return CustomFollowers(
                              user: myList[index],
                              isFollower: false,
                            );
                          },
                          itemCount: allfollow2.length,
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
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
