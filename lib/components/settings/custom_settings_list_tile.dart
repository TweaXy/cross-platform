import 'package:flutter/material.dart';

class CustomSettingsListTile extends StatelessWidget {
  const CustomSettingsListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 25),
      iconColor: Colors.grey.shade800,
      title: Text(title),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      isThreeLine: true,
      subtitle: Text(subtitle),
      subtitleTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: onTap,
    );
  }
}
