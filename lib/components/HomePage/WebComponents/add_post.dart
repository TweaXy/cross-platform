import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.transparent, border: Border.all(width: 0.02)),
      child: Row(
        children: [
          UserImageForTweet(image: 'assets/girl.jpg'),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What is hapenning?!',
                hintStyle: TextStyle(
                  fontSize: 20, // Customize the font size of the hint text
                  // Customize the font style of the hint text
                  // Add any other desired style properties here
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
