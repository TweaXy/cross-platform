import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddImageIconButton extends StatelessWidget {
  const CustomAddImageIconButton({super.key, required this.getImage});
  final Function getImage;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: const ValueKey("upload images for add tweet"),
        splashRadius: 20,
        hoverColor: const Color.fromARGB(255, 207, 232, 253),
        icon: const Icon(FontAwesomeIcons.image),
        color: Colors.blue.shade400,
        iconSize: 17,
        onPressed: () {
          getImage();
          // await pickImage();
        });
  }
}
