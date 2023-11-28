import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/models/followers_model.dart';

class CustomFollowers extends StatefulWidget {
  CustomFollowers({super.key, required this.isFollower, required this.user});
  bool isFollower;
  FollowersModel user;
  @override
  State<CustomFollowers> createState() => _CustomFollowersState();
}

class _CustomFollowersState extends State<CustomFollowers> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blueGrey.shade50)),
      ),
      onPressed: () {},
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!kIsWeb)
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06,
                    top: MediaQuery.of(context).size.height * 0.01),
                child: const Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 96, 110, 121),
                      size: 15,
                    ),
                    Text(
                      "  Follwers you",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromARGB(255, 96, 110, 121),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.00),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "widget.user",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        Text(
                          "widget.user.username",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: SizedBox(
                            // width: 150,
                            child: CustomButton(
                                color: !widget.user.followedByMe
                                    ? Colors.black
                                    : Colors.white,
                                text: !widget.user.followedByMe
                                    ? 'Follow Back'
                                    : 'Following',
                                onPressedCallback: () {
                                  setState(() {
                                    widget.isFollower = !widget.isFollower;
                                  });
                                },
                                initialEnabled: true),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (widget.user.bio != "")
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.16,
                    bottom: MediaQuery.of(context).size.height * 0.015),
                child: Text(
                  widget.user.bio != "" ? widget.user.bio : "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
