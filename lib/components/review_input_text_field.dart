import 'package:flutter/material.dart';

class ReviewInputTextField extends StatelessWidget {
  final String label;
  final String textValue;

  const ReviewInputTextField(
      {super.key, required this.label, required this.textValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: TextField(
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
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black38)),
        ),
      ),
    );
  }
}
