import 'package:flutter/material.dart';

class CustomPostButtonWeb extends StatelessWidget {
  const CustomPostButtonWeb(
      {super.key, required this.isButtonEnabled, required this.onpress});
  final bool isButtonEnabled;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    final onPressed = isButtonEnabled ? onpress : (){};

    return ElevatedButton(
      key: const ValueKey(" tweet add post button web"),
      onPressed: onPressed  as void Function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonEnabled
            ? const Color(0xFF1e9aeb)
            : const Color.fromARGB(255, 156, 203, 250),
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        elevation: 20,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      child: const Text(
        'Post',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
