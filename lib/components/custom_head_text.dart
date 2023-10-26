import 'package:flutter/material.dart';

class CustomHeadText extends StatelessWidget {
  const CustomHeadText({super.key, required this.textValue});
  final String textValue;
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      overflow: TextOverflow.clip,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
