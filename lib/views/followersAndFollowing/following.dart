import 'package:flutter/material.dart';
import 'package:tweaxy/components/showallFollowers.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage({super.key});
  var future;
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
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
          return ShowAllFollowersAndFollowing(
            follow: [1, 1, 1, 11, 1, 1, 1, 1, 1],
          );
          // } else if (snapshot.hasError) {
          // return CustomToast(message: "We have a problem");
          // } else {
          // return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
