import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialogAppBar extends StatelessWidget {
  CustomDialogAppBar({super.key, required this.isDarkMode, this.icon});

  final bool isDarkMode;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: !isDarkMode ? Colors.black : Colors.white,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 12.0),
        onPressed: () {
          Navigator.pop(context);
        },
        icon:  Icon(icon ?? Icons.close,
            color: isDarkMode ? Colors.black : Colors.white),
      ),
      centerTitle: true,
      title: SvgPicture.asset(
        width: 50,
        height: 50,
        'assets/images/logo.svg',
        fit: BoxFit.cover,
      ),
    );
  }
}
