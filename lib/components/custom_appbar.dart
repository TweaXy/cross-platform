import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.iconButton});
  final IconButton? iconButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Center(
        child: SafeArea(
          child: Image.asset(
            alignment: Alignment.center,
            Brightness.dark == Theme.of(context).brightness
                ? 'assets/images/logo-light.png'
                : 'assets/images/logo-black.png', // Replace with the path to your image
            height: 25,
          ),
        ),
      ),
      leading: iconButton,
    );
  }
}
