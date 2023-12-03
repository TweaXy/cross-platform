import 'package:flutter/foundation.dart';
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
          fontSize: kIsWeb ? 15 : 20,
        ),
      ),
      subtitle: Text(
        subtitle.isEmpty
            ? ""
            : title == "Username"
                ? "@$subtitle"
                : subtitle,
        style: kIsWeb
            ? const TextStyle(fontSize: 13)
            : const TextStyle(fontSize: 17),
      ),
      trailing: kIsWeb
          ? const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            )
          : null,
    );
  }
}
