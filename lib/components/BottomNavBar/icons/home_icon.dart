import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: selectedIndex == 0 ? false : true,
      label: Container(
        width: 7,
        height: 7,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      ),
      offset: Offset(10.0, -10.0),
      backgroundColor: Colors.transparent,
      child: DecoratedIcon(
        icon: Icon(
          FontAwesomeIcons.house,
          color: Theme.of(context).brightness == Brightness.light
              ? (selectedIndex == 0 ? Colors.black : Colors.white)
              : (selectedIndex == 0 ? Colors.white : Colors.black),
        ),
        decoration: IconDecoration(
          border: IconBorder(
              color: Theme.of(context).brightness != Brightness.light &&
                      selectedIndex != 0
                  ? Colors.white
                  : Colors.black,
              width: 4),
        ),
      ),
    );
  }
}
