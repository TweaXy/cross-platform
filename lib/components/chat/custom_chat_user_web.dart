import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_cubit.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/models/user_chat.dart';
import 'package:tweaxy/constants.dart';

class CustomUserChatWeb extends StatefulWidget {
  CustomUserChatWeb({super.key, required this.user});
  UserChat user;
  @override
  State<CustomUserChatWeb> createState() => _CustomFollowersState();
}

class _CustomFollowersState extends State<CustomUserChatWeb> {
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
    return BlocBuilder<ChatWebCubit, ChatWebCubitState>(
      builder: (context, state) {
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
            ConversationModel conversation = ConversationModel(
                conversationID: '',
                userID: widget.user.id,
                userAvatar: widget.user.avatar,
                username: widget.user.username,
                name: widget.user.name,
                isBlockedByMe: false,
                isBlockingMe: false,
                isMutedByMe: false,
                isMutingMe: false,
                unseenCount: 0,
                lastMessage: null);
            BlocProvider.of<ChatWebCubit>(context).loadingConversation();
            Future.delayed(const Duration(milliseconds: 100), () {
              BlocProvider.of<ChatWebCubit>(context)
                  .openConversation(conversation: conversation);
              Navigator.pop(context);
            });
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
                          backgroundImage: CachedNetworkImageProvider(
                              widget.user.avatar == null
                                  ? kDefaultAvatarPhoto
                                  : '$basePhotosURL${widget.user.avatar}'),
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
                                  bottom: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Row(
                                children: [
                                  Text(
                                    kIsWeb
                                        ? "${widget.user.username.length > 15 ? widget.user.username.substring(0, 15) : widget.user.username}  "
                                        : widget.user.username.length > 15
                                            ? widget.user.username
                                                .substring(0, 15)
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
      },
    );
  }
}
