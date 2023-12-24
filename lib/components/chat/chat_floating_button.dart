import 'package:flutter/material.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/views/chat/direct_message.dart';

class ChatFloatingButton extends StatelessWidget {
  const ChatFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CustomPageRoute(
                  direction: AxisDirection.left,
                  child: const DirectMesssage()));
        },
        child: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Icon(
            AppIcon.newMessage,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
