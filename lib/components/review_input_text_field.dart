import 'package:flutter/material.dart';

class ReviewInputTextField extends StatelessWidget {
  final String label;
  final String value;

  const ReviewInputTextField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      cursorHeight: 30.0,
      cursorColor: Colors.lightBlue[700],
      decoration: InputDecoration(
        filled: true,
        suffixIcon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        labelText: label,
        border: const OutlineInputBorder(borderSide: BorderSide()),
      ),
    );
  }
}
