import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedIcon(
          icon: Icon(FontAwesomeIcons.house,
              color: selectedIndex == 0 ? Colors.black : Colors.white),
          decoration:
              IconDecoration(border: IconBorder(color: Colors.black, width: 4)),
        ),
        // Positioned(
        //   top: -10,
        //   right: -10,
        //   child: Container(
        //     height: 2,
        //     width: 2,
        //     decoration: BoxDecoration(
        //       color: Color(0xff2a91d6),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
