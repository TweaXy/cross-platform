import 'package:flutter/material.dart';

class SaveSettingsButton extends StatelessWidget {
  const SaveSettingsButton({super.key, required this.onPressed, required this.isButtonEnabled});
  final Function() onPressed;
  final bool isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonEnabled
            ? const Color(0xFF1e9aeb)
            : const Color.fromARGB(255, 156, 203, 250),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      child: const Text(
        "Save",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),
      ),
    );
  }
}
