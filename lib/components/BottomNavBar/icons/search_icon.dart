import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return DecoratedIcon(
      icon: Icon(
        FontAwesomeIcons.magnifyingGlass,
        color: selectedIndex == 1
            ? Colors.black
            : Color.fromARGB(255, 137, 137, 137),
      ),
      // decoration: IconDecoration(
      // border: IconBorder(width: selectedIndex == 1 ? 1 : 0.1)),
    );
  }
}
