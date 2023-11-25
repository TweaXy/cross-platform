import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/Components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/Components/HomePage/WebComponents/add_post_dialogbox.dart';
import 'package:tweaxy/Components/custom_appbar.dart';
import 'package:tweaxy/Components/custom_appbar_web.dart';
import 'package:tweaxy/Views/signup/web/add_password_web_view.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      // statesController:,
      onPressed: () {
        showDialog(
          barrierColor: const Color.fromARGB(100, 97, 119, 129),
          context: context,
          builder: (BuildContext context) {
            return const AddPostDialogBox(); // Use the custom dialog widget
          },
        );
      },

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
