import 'package:flutter/material.dart';

class TextAndLink extends StatelessWidget {
  const TextAndLink(
      {super.key,
      required this.text,
      required this.linkedText,
      required this.onPressed,
      required this.linkKey,
      required this.fontSize});
  final String text;
  final String linkedText;
  final Function() onPressed;
  final Key linkKey;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        InkWell(
          key: linkKey,
          onTap: onPressed,
          child: Text(
            linkedText,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
