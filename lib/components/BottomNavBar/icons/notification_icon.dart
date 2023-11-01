import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: selectedIndex == 2 ? false : true,
      offset: Offset(6.0, -5.0),
      label: Text('1'),
      backgroundColor: Colors.blue,
      child: Icon(
        //  Theme.of(context).brightness == Brightness.light
        //     ? (selectedIndex == 1
        //         ? Colors.black
        //         : Color.fromARGB(255, 137, 137, 137))
        //     : (selectedIndex == 1
        //         ? Colors.white
        //         : const Color.fromARGB(255, 203, 203, 203)),
        FontAwesomeIcons.bell,
        color: Theme.of(context).brightness == Brightness.light
            ? (selectedIndex == 2
                ? Color.fromARGB(255, 0, 0, 0)
                : Color.fromARGB(255, 93, 93, 93))
            : (selectedIndex == 2
                ? Colors.white
                : Color.fromARGB(255, 176, 176, 176)),
      ),
    );
  }
}
