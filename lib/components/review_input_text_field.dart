import 'package:flutter/material.dart';

class ReviewInputTextField extends StatelessWidget {
  final String label;
  final String textValue;

  const ReviewInputTextField(
      {super.key, required this.label, required this.textValue});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      // readOnly: true,
      autofocus: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        labelText: label,
        hintText: textValue,
        border: const OutlineInputBorder(borderSide: BorderSide()),
      ),
    );
  }
}
