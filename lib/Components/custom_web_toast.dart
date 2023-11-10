import 'package:flutter/material.dart';

class CustomWebToast extends StatelessWidget {
  const CustomWebToast({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.88,
        left: MediaQuery.of(context).size.width * 0.37,
        right: MediaQuery.of(context).size.width * 0.37,
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        textAlign: TextAlign.center,
        message,
        overflow: TextOverflow.clip,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
