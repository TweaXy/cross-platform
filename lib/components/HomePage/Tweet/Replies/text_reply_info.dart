import 'package:flutter/material.dart';

class TextReplyInfo extends StatelessWidget {
  const TextReplyInfo({super.key, required this.count, required this.text});
  final String count;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: count + ' ',
        style: const TextStyle(
          fontSize: 17.5,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: TextStyle(
              color: Color.fromARGB(255, 108, 108, 108),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
