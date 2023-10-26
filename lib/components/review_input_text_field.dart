import 'package:flutter/material.dart';

class ReviewInputTextField extends StatelessWidget {
  final String label;

  const ReviewInputTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      readOnly: true,
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
