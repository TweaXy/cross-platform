import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.iconButton});
  final IconButton? iconButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Center(
        child: SafeArea(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            alignment: Alignment.center,
          ),
        ),
      ),
      leading: iconButton,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
