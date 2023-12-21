import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';

class ChatRoomWeb extends StatefulWidget {
  const ChatRoomWeb({super.key});

  @override
  State<ChatRoomWeb> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoomWeb> {
  //clqft7w6m009pe5f5j5xacfwc
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ChatUser user = ChatUser(
    id: '0',
    firstName: 'nancy',
  );

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey!',
      user: ChatUser(
        id: '1',
        firstName: 'yara',
      ),
      createdAt: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    TempUser.username = "yara";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Row(
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.transparent,
            //   backgroundImage:
            //       CachedNetworkImageProvider(basePhotosURL + TempUser.image),
            // ),
            Text(
              TempUser.username,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: DashChat(
        messageListOptions:
            MessageListOptions(scrollController: scrollController),
        messageOptions: const MessageOptions(
          showOtherUsersAvatar: false,
          showOtherUsersName: false,
          currentUserContainerColor: Colors.blue,
          currentUserTextColor: Colors.white,
          containerColor: Colors.grey,
          textColor: Colors.black,
        ),
        inputOptions: InputOptions(
          inputToolbarStyle: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(50)),
          inputDecoration: InputDecoration(
              focusedBorder: InputBorder.none,
              focusColor: Colors.grey,
              border: InputBorder.none,
              hintText: "Start a message",
              suffixIcon: messageController.text.isEmpty
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.voice_chat),
                      color: Colors.grey,
                      focusColor: Colors.grey,
                    )
                  : SizedBox(),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.photo),
                color: Colors.grey,
                focusColor: Colors.grey,
              )),
          textController: messageController,
        ),
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
      ),
    );
  }
}
