// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:tweaxy/constants.dart';
// import 'package:tweaxy/services/chat_room_service.dart';
// import 'package:tweaxy/services/temp_user.dart';

// class ChatRoomWeb extends StatefulWidget {
//   ChatRoomWeb(
//       {super.key,
//       required this.id,
//       required this.avatar,
//       required this.username,
//       required this.isFirstMsg,
//       required this.name,
//       required this.conversationID});
//   final String id;
//   final String conversationID;
//   String? avatar = "";
//   final String username;
//   final String name;
//   final bool isFirstMsg;
//   @override
//   State<ChatRoomWeb> createState() => _ChatRoomState();
// }

// class _ChatRoomState extends State<ChatRoomWeb> {
//   //clqft7w6m009pe5f5j5xacfwc
//   TextEditingController messageController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//   ChatUser user = ChatUser(
//     id: TempUser.id,
//     firstName: TempUser.name,
//   );
//   late String userID;
//   late String usertoken;
//   late String consversationID;
//   List<ChatMessage> oldMessages = [];
//   Future loadMessages() async {
//     List<String> s = await loadPrefs();
//     usertoken = s[1];
//     userID = s[0];
//     consversationID =
//         await ChatRoomService(Dio()).firstConversation(widget.username);
//     if (widget.conversationID != "") {
//       oldMessages =
//           await ChatRoomService(Dio()).getMessages(widget.conversationID, 0);
//       consversationID = widget.conversationID;
//     } else {
//       oldMessages =
//           await ChatRoomService(Dio()).getMessages(consversationID, 0);
//     }
//     setState(() {
//       messages = oldMessages;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     Future(() async {
//       await loadMessages();
//     });
//   }

//   List<ChatMessage> messages = <ChatMessage>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           color: Colors.black,
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.transparent,
//               backgroundImage:
//                   CachedNetworkImageProvider(basePhotosURL + widget.avatar!),
//             ),
//             Text(
//               widget.name,
//               style: const TextStyle(color: Colors.black),
//             )
//           ],
//         ),
//       ),
//       body: DashChat(
//         messageListOptions:
//             MessageListOptions(scrollController: scrollController),
//         messageOptions: const MessageOptions(
//           showOtherUsersAvatar: false,
//           showOtherUsersName: false,
//           currentUserContainerColor: Colors.blue,
//           currentUserTextColor: Colors.white,
//           containerColor: Colors.grey,
//           textColor: Colors.black,
//         ),
//         inputOptions: InputOptions(
//           inputToolbarStyle: BoxDecoration(
//               color: Colors.grey[300], borderRadius: BorderRadius.circular(50)),
//           inputDecoration: InputDecoration(
//               focusedBorder: InputBorder.none,
//               focusColor: Colors.grey,
//               border: InputBorder.none,
//               hintText: "Start a message",
//               suffixIcon: messageController.text.isEmpty
//                   ? IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.voice_chat),
//                       color: Colors.grey,
//                       focusColor: Colors.grey,
//                     )
//                   : SizedBox(),
//               prefixIcon: IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.photo),
//                 color: Colors.grey,
//                 focusColor: Colors.grey,
//               )),
//           textController: messageController,
//         ),
//         currentUser: user,
//         onSend: (ChatMessage m) {
//           setState(() {
//             messages.insert(0, m);
//           });
//         },
//         messages: messages,
//       ),
//     );
//   }
// }
