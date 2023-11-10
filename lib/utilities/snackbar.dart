// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

showSnackBar(context, dynamic content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${content.toString()}',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black87, // Set your desired background color
      duration: Duration(seconds: 3), // Adjust the duration as needed
      elevation: 6.0, // Add a slight elevation for a card-like effect
      behavior:
          SnackBarBehavior.floating, // Use floating behavior for a modern look
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Customize the border radius
      ),
    ),
  );
}
