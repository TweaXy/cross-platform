import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialogAppBar extends StatelessWidget {
  const CustomDialogAppBar({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: !isDarkMode ? Colors.black : Colors.white,
      leading: IconButton(
        padding: EdgeInsets.only(left: 12.0),
        onPressed: () {
          Navigator.pop(context);
        },
        icon:
            Icon(Icons.close, color: isDarkMode ? Colors.black : Colors.white),
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
