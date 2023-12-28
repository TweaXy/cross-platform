import 'package:flutter/material.dart';

class CustomUpdatePasswordTextField extends StatelessWidget {
  const CustomUpdatePasswordTextField(
      {super.key,
      required this.labelText,
      this.controller,
      required this.isPassword});
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade200)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade200)),
      ),
    );
  }
}
