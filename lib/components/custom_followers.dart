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
        // height: MediaQuery.of(context).size.height * 0.12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
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
                          widget.user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        Text(
                          widget.user.username,
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
                                color: widget.isFollower
                                    ? Colors.black
                                    : Colors.white,
                                text: widget.isFollower
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
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.16),
              child: Text(
                widget.user.bio,
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
