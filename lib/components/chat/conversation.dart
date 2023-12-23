import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_cubit.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';
import 'package:tweaxy/views/chat/chat_room.dart';

class Conversation extends StatelessWidget {
  Conversation({super.key, required this.conversation});
  final ConversationModel conversation;
  late String date;
  @override
  Widget build(BuildContext context) {
    if (conversation.lastMessage != null) {
      date = dateFormatter(conversation.lastMessage!.createdDate);
    }
    conversation.userAvatar ??= "d1deecebfe9e00c91dec2de8bc0d68bb";

    return ListTile(
      onTap: () {
        // BlocProvider.of<ChatWebCubit>(context).openConversation();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoom(
                  id: conversation.userID,
                  avatar: conversation.userAvatar,
                  username: conversation.username,
                  isFirstMsg: false,
                  name: conversation.name,
                  conversationID: conversation.conversationID)),
        );
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: CachedNetworkImageProvider(
            basePhotosURL + conversation.userAvatar!),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            conversation.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              " @${conversation.username} ",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(". $date"),
        ],
      ),
      subtitle: conversation.lastMessage == null
          ? const Text("")
          : conversation.lastMessage!.text == null
              ? Text("${conversation.name} sent a photo")
              : Text(conversation.lastMessage!.text!),
    );
  }
}
