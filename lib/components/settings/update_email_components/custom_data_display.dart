import 'package:flutter/material.dart';

class CustomdataDisplay extends StatelessWidget {
  CustomdataDisplay(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onpress,
      this.lead});
  final String title;
  final String subtitle;
  final VoidCallback onpress;
  Widget? lead;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: lead,
      onTap: onpress,
      title: Text(
        title,
        style: TextStyle(
          color: title == "Log out" ? Colors.red : Colors.black,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        subtitle.isEmpty
            ? ""
            : title == "Username"
                ? "@$subtitle"
                : subtitle,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}
