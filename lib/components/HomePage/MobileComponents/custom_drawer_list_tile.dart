import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDrawerListTile extends StatelessWidget {
  CustomDrawerListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.selectedIndex,
      this.curindex});
  final IconData icon;
  final String title;
  final Function() onTap;
  int? selectedIndex;
  int? curindex;

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
        style: TextStyle(
          fontWeight: kIsWeb
              ? curindex == selectedIndex
                  ? FontWeight.bold
                  : FontWeight.normal
              : FontWeight.w400,
          fontSize: 20,
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      iconColor: Colors.black,
      textColor: Colors.black,
      onTap: onTap,
    );
  }
}
