import 'package:flutter/material.dart';
import 'package:tweaxy/models/app_icons.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          splashColor: Color.fromARGB(255, 156, 203, 250),
          highlightElevation: 0,
        ),
      ),
      child: Transform.scale(
        scale: 1.2, // Adjust the scale factor to increase the size
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(AppIcon.fabTweet),
        ),
      ),
    );
  }
}
