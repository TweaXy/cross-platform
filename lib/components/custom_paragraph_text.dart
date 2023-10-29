import 'package:flutter/material.dart';

class CustomParagraphText extends StatelessWidget {
  CustomParagraphText(
      {super.key, required this.textValue, required this.textAlign, this.size});
  final String textValue;
  final TextAlign textAlign;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      textAlign: textAlign,
      overflow: TextOverflow.fade,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: size ?? 20,
          color: Brightness.dark == Theme.of(context).brightness
              ? Colors.white54
              : Colors.black54),
    );
  }
}
