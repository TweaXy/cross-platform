import 'package:flutter/material.dart';

class CustomParagraphText extends StatelessWidget {
  const CustomParagraphText({super.key, required this.textValue});
  final String textValue;
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      overflow: TextOverflow.fade,
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black54),
    );
  }
}
