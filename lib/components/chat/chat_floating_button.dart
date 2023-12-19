import 'package:flutter/material.dart';
import 'package:tweaxy/models/app_icons.dart';

class ChatFloatingButton extends StatelessWidget {
  const ChatFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: FloatingActionButton(
        onPressed: () {
          
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
