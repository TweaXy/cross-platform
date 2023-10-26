import 'package:flutter/material.dart';

class CustomHeadText extends StatefulWidget {
  const CustomHeadText({super.key, required this.textValue});
  final String textValue;
  @override
  State<CustomHeadText> createState() => _CustomHeadTextState();
}

class _CustomHeadTextState extends State<CustomHeadText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.textValue,
      overflow: TextOverflow.clip,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
