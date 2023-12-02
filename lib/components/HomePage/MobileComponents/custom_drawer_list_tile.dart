import 'package:flutter/material.dart';

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});
  final IconData icon;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      leading: SizedBox(
          height: double.infinity, //Align icon to center
          child: Icon(icon, size: 27)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      iconColor: Colors.black,
      textColor: Colors.black,
      onTap: onTap,
    );
  }
}
