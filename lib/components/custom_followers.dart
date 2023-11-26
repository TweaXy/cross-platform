import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';

class CustomFollowers extends StatefulWidget {
  CustomFollowers({super.key, required this.isFollower});
  bool isFollower;

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
            side: BorderSide(color: Colors.blueGrey.shade200)),
      ),
      onPressed: () {},
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "kaokabkareem",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Text(
                        "@kaokab5456236",
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
            )
          ],
        ),
      ),
    );
  }
}
