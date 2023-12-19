import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/models/user_chat.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/views/chat/chat_room.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/constants.dart';

class CustomUserChat extends StatefulWidget {
  CustomUserChat({super.key, required this.user});
  UserChat user;
  @override
  State<CustomUserChat> createState() => _CustomFollowersState();
}

class _CustomFollowersState extends State<CustomUserChat> {
  String id = '0';
  void initState() {
    super.initState();
    // Future(() async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   id = prefs.getString("id")!;
    //   setState(() {});
    // });
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
            CustomPageRoute(
                direction: AxisDirection.left,
                child: ChatRoom(
                  conversationID: '',
                  isFirstMsg: true,
                  id: widget.user.id,
                  avatar: widget.user.avatar,
                  username: widget.user.username,
                  name: widget.user.name!,
                )));
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.width * 0.01,
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
                          : 'https://tweaxybackend.mywire.org/${widget.user.avatar}'),
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
                          widget.user.name!,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
