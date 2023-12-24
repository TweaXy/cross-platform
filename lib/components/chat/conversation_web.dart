import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_cubit.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class ConversationWeb extends StatelessWidget {
  ConversationWeb({super.key, required this.conversation});
  final ConversationModel conversation;
  late String date;

  @override
  Widget build(BuildContext context) {
    if (conversation.lastMessage != null) {
      date = dateFormatter(conversation.lastMessage!.createdDate);
    }
    conversation.userAvatar ??= "d1deecebfe9e00c91dec2de8bc0d68bb";

    return BlocBuilder<ChatWebCubit, ChatWebCubitState>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            BlocProvider.of<ChatWebCubit>(context).loadingConversation();
            Future.delayed(const Duration(milliseconds: 100), () {
              BlocProvider.of<ChatWebCubit>(context)
                  .openConversation(conversation: conversation);
            });
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
                  style:  TextStyle(
                   color: Colors.grey.shade600

                  ),
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
      },
    );
  }
}
