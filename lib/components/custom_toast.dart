import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(
      {super.key, required this.message, required this.screenWidth});
  final String message;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(180, 0, 0, 0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/logo.svg',
            alignment: Alignment.centerLeft,
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              width: screenWidth * 0.6,
              child: Text(
                message,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
