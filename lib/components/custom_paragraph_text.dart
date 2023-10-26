import 'package:flutter/material.dart';

class CustomParagraphText extends StatelessWidget {
  const CustomParagraphText(
      {super.key, required this.textValue, required this.textAlign});
  final String textValue;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      textAlign: textAlign,
      overflow: TextOverflow.fade,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Brightness.dark == Theme.of(context).brightness
              ? Colors.white54
              : Colors.black54),
    );
  }
}
