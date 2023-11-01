import 'package:flutter/material.dart';

class SideBarText extends StatelessWidget {
  const SideBarText(
      {super.key, required this.text, required this.selectedIndex,required this.curindex});
  final String text;
  final int selectedIndex;
  final int curindex;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: curindex == selectedIndex
              ? FontWeight.bold
              : FontWeight.normal),
    );
  }
}
