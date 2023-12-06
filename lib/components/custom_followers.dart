import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/constants.dart';

class CustomFollowers extends StatefulWidget {
  CustomFollowers({super.key, required this.isFollower, required this.user});
  bool isFollower;
  FollowersModel user;
  @override
  State<CustomFollowers> createState() => _CustomFollowersState();
}

class _CustomFollowersState extends State<CustomFollowers> {
  String id = '0';
  void initState() {
    super.initState();
    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString("id")!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 231, 233, 233),
            width: 0.8,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    id: widget.user.id,
                    text: id == widget.user.id
                        ? ""
                        : widget.user.followedByMe
                            ? 'Following'
                            : (!widget.user.followesMe
                                ? 'Follow'
                                : 'Follow back'),
                  )),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!kIsWeb && widget.user.followesMe == true)
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06,
                    top: MediaQuery.of(context).size.height * 0.01,
                    bottom: MediaQuery.of(context).size.height * 0.005),
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
                top: (kIsWeb
                    ? MediaQuery.of(context).size.height * 0.01
                    : (widget.user.followesMe == true
                        ? MediaQuery.of(context).size.height * 0.00
                        : MediaQuery.of(context).size.height * 0.02)),
                bottom: (widget.user.bio == null
                    ? (kIsWeb
                        ? MediaQuery.of(context).size.width * 0.01
                        : MediaQuery.of(context).size.width * 0.03)
                    : MediaQuery.of(context).size.width * 0.00),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(widget
                                  .user.avatar ==
                              null
                          ? "https://www.gstatic.com/webp/gallery2/4.png"
                          : 'http://16.171.65.142:3000/${widget.user.avatar}'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Row(
                            children: [
                              Text(
                                kIsWeb
                                    ? "${widget.user.username.length > 15 ? widget.user.username.substring(0, 15) : widget.user.username}  "
                                    : widget.user.username.length > 15
                                        ? widget.user.username.substring(0, 15)
                                        : widget.user.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: kIsWeb ? 15 : 13,
                                    color: Color(0xff536471)),
                              ),
                              if (kIsWeb && widget.user.followesMe == true)
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xffc7ced2),
                                  ),
                                  child: const Text(
                                    'Follwers you',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xff536471)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (id != widget.user.id)
                          SizedBox(
                            // width: 140,
                            // height: 45,
                            child: CustomButton(
                                color: !widget.user.followedByMe
                                    ? (!widget.user.followesMe
                                        ? Colors.white
                                        : Colors.black)
                                    : Colors.white,
                                text: !widget.user.followedByMe
                                    ? kIsWeb
                                        ? 'Follow'
                                        : (!widget.user.followesMe
                                            ? 'Follow'
                                            : 'Follow Back')
                                    : 'Following',
                                onPressedCallback: () {
                                  if (!kIsWeb) {
                                    setState(() {
                                      if (!widget.user.followedByMe) {
                                        FollowUser.instance
                                            .followUser(widget.user.username);
                                        widget.user.followedByMe = true;
                                      } else {
                                        FollowUser.instance
                                            .deleteUser(widget.user.username);
                                        widget.user.followedByMe = false;
                                      }
                                    });
                                  } else {
                                    if (widget.user.followedByMe) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          content: SizedBox(
                                            width: 300,
                                            height: 240,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Unfollow ${widget.user.username}?",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  "Their posts will no longer show up in your For You timeline. You can still view their profile, unless their posts are protected.",
                                                  style: TextStyle(
                                                      color: Color(0xff536471)),
                                                ),
                                                const SizedBox(height: 20),
                                                ButtonBar(
                                                  alignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          width: 250,
                                                          child: CustomButton(
                                                            initialEnabled:
                                                                true,
                                                            color: Colors.black,
                                                            text: "Unfollow",
                                                            onPressedCallback:
                                                                () {
                                                              FollowUser
                                                                  .instance
                                                                  .deleteUser(widget
                                                                      .user
                                                                      .username);
                                                              setState(() {
                                                                widget.user
                                                                        .followedByMe =
                                                                    false;
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: SizedBox(
                                                            width: 250,
                                                            child: CustomButton(
                                                              initialEnabled:
                                                                  true,
                                                              color:
                                                                  Colors.white,
                                                              text: "Cancel",
                                                              onPressedCallback:
                                                                  () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        FollowUser.instance
                                            .followUser(widget.user.username);
                                        widget.user.followedByMe = true;
                                      });
                                    }
                                  }
                                },
                                initialEnabled: true),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (widget.user.bio != null)
              Padding(
                padding: EdgeInsets.only(
                    left: kIsWeb
                        ? MediaQuery.of(context).size.width * 0.063
                        : MediaQuery.of(context).size.width * 0.16,
                    bottom: MediaQuery.of(context).size.height * 0.015),
                child: Text(
                  widget.user.bio ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
