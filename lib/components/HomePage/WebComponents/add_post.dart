import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 0.2,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 135, 135, 135)
                    : const Color.fromARGB(255, 233, 233, 233))),
      ),
      child: Column(
        children: [
          Row(
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
          Row(
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.image),
                color: Colors.blue.shade400,
                iconSize: 20,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.faceSmile),
                color: Colors.blue.shade400,
                iconSize: 20,
                onPressed: () {},
              ),
              Material(
                child: Ink(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blue.shade400,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.gif),
                    color: Colors.blue.shade400,
                    iconSize: 23,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
