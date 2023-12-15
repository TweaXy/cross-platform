import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/services/temp_user.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: selectedIndex == 2 || TempUser.notificationCount == 0 ? false : true,
      offset: const Offset(6.0, -5.0),
      label: Text(TempUser.notificationCount.toString()),
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
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color.fromARGB(255, 93, 93, 93))
            : (selectedIndex == 2
                ? Colors.white
                : const Color.fromARGB(255, 176, 176, 176)),
      ),
    );
  }
}
