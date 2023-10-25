import 'package:flutter/material.dart';

AppBar CustomAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    flexibleSpace: Center(
      child: SafeArea(
        child: Image.asset(
          alignment: Alignment.center,
          'assets/images/logo-black.png', // Replace with the path to your image
          height: 25,
        ),
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.close_sharp,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
