import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/models/followers_model.dart';

class CustomFurure extends StatelessWidget {
  CustomFurure(
      {required this.isFollower,
      super.key,
      required this.future,
      required this.controller});
  ScrollController controller;
  final Future<List<FollowersModel>> future;
  bool isFollower;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FollowersModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return isFollower
                ? const Center(
                    child: Text(
                      "You don't have Followers",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                : const Center(
                    child: Text("You don't Follow any one",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  );
          } else {
            return ShowAllFollowersAndFollowing(
              follow: snapshot.data ?? [],
              isFollower: isFollower,
              controller: controller,
            );
          }
        } else if (snapshot.hasError) {
          return kIsWeb
              ? const CustomWebToast(message: "We have a problem")
              : const Center(child: CustomToast(message: "We have a problem"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
