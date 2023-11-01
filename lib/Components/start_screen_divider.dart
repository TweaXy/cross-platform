import 'package:flutter/material.dart';

class StartScreenDivider extends StatelessWidget {
  const StartScreenDivider({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          indent: 24,
          endIndent: 24,
          color: !isDarkMode?Colors.grey[400]: Colors.black26,
          thickness: 1,
        ),
        Container(
          width: 30,
          color: !isDarkMode ? Colors.white : Colors.black,
          child: Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              backgroundColor: !isDarkMode ? Colors.white  : Colors.black,
              color: !isDarkMode ? Colors.black54 : Colors.white70,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
