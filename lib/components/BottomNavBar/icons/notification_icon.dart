import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: true,
      offset: Offset(6.0, -5.0),
      label: Text('1'),
      backgroundColor: Colors.blue,
      child: Icon(
        FontAwesomeIcons.bell,
        color: selectedIndex == 2
            ? Color.fromARGB(255, 0, 0, 0)
            : Color.fromARGB(255, 93, 93, 93),
      ),
    );
  }
}
