import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/models/followers_model.dart';

class CustomFurure extends StatelessWidget {
  CustomFurure({required this.isFollower, super.key, required this.future});
  final Future<List<FollowersModel>> future;
  bool isFollower;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FollowersModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ShowAllFollowersAndFollowing(
              follow: snapshot.data ?? [], isFollower: false);
        } else if (snapshot.hasError) {
          return kIsWeb
              ? CustomWebToast(message: "We have a problem")
              : CustomToast(message: "We have a problem");
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
