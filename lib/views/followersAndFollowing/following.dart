import 'package:flutter/material.dart';
import 'package:tweaxy/components/showallFollowers.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage({super.key});
  Future<void> _refresh() async {
    // You can add the logic to fetch new data here
    await followApi().getFollowings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Following',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: followApi().getFollowings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ShowAllFollowersAndFollowing(
                  follow: snapshot.data ?? [], isFollower: false);
            } else if (snapshot.hasError) {
              return CustomToast(message: "We have a problem");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
