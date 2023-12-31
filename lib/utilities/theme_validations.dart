import 'package:flutter/material.dart';

Color forgroundColorTheme(BuildContext context) {
  return Brightness.dark == Theme.of(context).brightness
      ? Colors.white
      : Colors.black;
}

Color backgroundColorTheme(BuildContext context) {
  return Brightness.dark == Theme.of(context).brightness
      ? Colors.black
      : Colors.white;
}

Color iconColorTheme(BuildContext context) {
  return Brightness.dark == Theme.of(context).brightness
      ? Colors.white54
      : Colors.black54;
}
