import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      // statesController:,
      onPressed: () {},

      child: Text(
        'Post',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        elevation: 20,
        padding: EdgeInsets.all(screenWidth * 0.015),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
