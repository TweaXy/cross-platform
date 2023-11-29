import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class MessageIcon extends StatelessWidget {
  const MessageIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return DecoratedIcon(
      icon: Icon(
        //
        FontAwesomeIcons.envelope,
        color: Theme.of(context).brightness == Brightness.light
            ? (selectedIndex == 3
                ? Colors.black
                : const Color.fromARGB(255, 137, 137, 137))
            : (selectedIndex == 3
                ? Colors.white
                : const Color.fromARGB(255, 176, 176, 176)),
      ),
      decoration:
          IconDecoration(border: IconBorder(width: selectedIndex == 3 ? 2 : 1)),
    );
  }
}
