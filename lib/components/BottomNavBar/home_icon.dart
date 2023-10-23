import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key, required this.iconColor});
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return DecoratedIcon(
      icon: Icon(FontAwesomeIcons.house, color: iconColor),
      decoration:
          IconDecoration(border: IconBorder(color: Colors.black, width: 4)),
    );
  }
}
