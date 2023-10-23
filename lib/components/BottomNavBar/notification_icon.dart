import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, required this.iconColor,required this.borderWidth});

  final Color iconColor;
  final double borderWidth;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedIcon(
          icon: Icon(
            FontAwesomeIcons.bell,
            color: iconColor,
            size: 27,
          ),
          decoration: IconDecoration(
              border: IconBorder(width: borderWidth)),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Color(0xff2a91d6),
              shape: BoxShape.circle,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              '10', // Replace with the actual notification count
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
