import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/services/get_likers.dart';
import 'package:tweaxy/views/followersAndFollowing/custom_future.dart';

class LikersInTweet extends StatefulWidget {
  LikersInTweet({super.key, required this.id});
  String id;
  @override
  State<LikersInTweet> createState() => _LikersInTweetState();
}

class _LikersInTweetState extends State<LikersInTweet> {
  late ScrollController controller;

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
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
          'Liked by',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder(
            future: Likers().getLikers(scroll: controller, id: widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "NO Likers yet",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return ShowAllFollowersAndFollowing(
                    follow: snapshot.data ?? [],
                    isFollower: true,
                    controller: controller,
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
        ),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}
