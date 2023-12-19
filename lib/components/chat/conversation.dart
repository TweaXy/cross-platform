import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/conversation_model.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key, required this.conversation});
  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        
        
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage:
            CachedNetworkImageProvider(basePhotosURL + conversation.photo),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            conversation.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(" @${conversation.username} . ${conversation.time}"),
        ],
      ),
      subtitle: Text(conversation.lastmessage),
    );
  }
}
