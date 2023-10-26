import 'package:flutter/material.dart';

class CustomParagraphText extends StatefulWidget {
  const CustomParagraphText({super.key, required this.textValue});
  final String textValue;
  @override
  State<CustomParagraphText> createState() => _CustomParagraphTextState();
}

class _CustomParagraphTextState extends State<CustomParagraphText> {
  @override
  Widget build(BuildContext context) {
    return  Text(
      widget.textValue,
       overflow: TextOverflow.fade,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black54),
    );
  }
}
