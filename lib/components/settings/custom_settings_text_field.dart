import 'package:flutter/material.dart';

class CustomSettingsTextField extends StatelessWidget {
  const CustomSettingsTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.controller,
      required this.isPassword});
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(209, 61, 59, 59),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade200)),
      ),
    );
  }
}
