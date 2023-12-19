import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key, required this.conversation});
  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    if (conversation.lastmessageTime != null) {
      conversation.lastmessageTime =
          dateFormatter(conversation.lastmessageTime!);
    }
    conversation.photo ??= "d1deecebfe9e00c91dec2de8bc0d68bb";

    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage:
            CachedNetworkImageProvider(basePhotosURL + conversation.photo!),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            conversation.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(" @${conversation.username} . ${conversation.lastmessageTime}"),
        ],
      ),
      subtitle: conversation.lastmessageText == null
          ? null
          : Text(conversation.lastmessageText!),
    );
  }
}
