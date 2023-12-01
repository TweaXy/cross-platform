import 'package:flutter/material.dart';
import 'package:tweaxy/services/temp_user.dart';

class CustomAppbarwidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Account information",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "@${TempUser.username}",
              style: const TextStyle(color: Colors.black),
            )
          ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
